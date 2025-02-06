#!/usr/bin/python3

import rospy
from sensor_msgs.msg import LaserScan
from std_msgs.msg import String
from geometry_msgs.msg import Twist, Point as GeoPoint
from visualization_msgs.msg import Marker
from shapely.geometry import Point, Polygon
from math import cos, sin

# Define the protective and warning zones as polygons
protective_polygon = Polygon([(-0.0, -0.4), (0.3, -0.4), (0.3, 0.4), (-0.0, 0.4)])  # Red
warning_polygon = Polygon([(-0.0, -0.55), (0.4, -0.55), (0.4, 0.55), (-0.0, 0.55)])     # Yellow

# Publishers
cmd_vel_pub = None
protective_marker_pub = None
warning_marker_pub = None
obstacle_inside_scan = False
obstacle_inside_warning_scan = False
prev_obstacle_state = True  # Assume initially there is an obstacle
prev_warning_state = True  # Assume initially there is an obstacle in warning field


def timer_callback(event):
    global protective_marker_pub, warning_marker_pub

    # Marker for the protective field (Red color, constant glow)
    marker_protective = Marker()
    marker_protective.header.frame_id = "laser_link"
    marker_protective.type = Marker.LINE_STRIP
    marker_protective.action = Marker.ADD
    marker_protective.scale.x = 0.02
    marker_protective.color.a = 1.0  # Full opacity for constant glow
    marker_protective.color.r = 1.0  # Red color

    # Points for the protective field polygon
    for point in protective_polygon.exterior.coords:
        marker_point = GeoPoint()
        marker_point.x = point[0]
        marker_point.y = point[1]
        marker_point.z = 0.0
        marker_protective.points.append(marker_point)

    # Marker for the warning field (Yellow color, constant glow)
    marker_warning = Marker()
    marker_warning.header.frame_id = "laser_link"
    marker_warning.type = Marker.LINE_STRIP
    marker_warning.action = Marker.ADD
    marker_warning.scale.x = 0.02
    marker_warning.color.a = 1.0  # Full opacity for constant glow
    marker_warning.color.r = 1.0  # Yellow color (red + green)
    marker_warning.color.g = 1.0

    # Points for the warning field polygon
    for point in warning_polygon.exterior.coords:
        marker_point = GeoPoint()
        marker_point.x = point[0]
        marker_point.y = point[1]
        marker_point.z = 0.0
        marker_warning.points.append(marker_point)

    # Publish each marker on its own topic
    protective_marker_pub.publish(marker_protective)
    warning_marker_pub.publish(marker_warning)

def scan_callback(scan_msg):
    """
    Callback for LaserScan data (LIDAR). Checks if any point from the scan lies inside
    the protective or warning polygons.
    """
    global obstacle_inside_scan, obstacle_inside_warning_scan

    angle_min = scan_msg.angle_min
    angle_increment = scan_msg.angle_increment
    ranges = scan_msg.ranges

    protective_obstacle = False
    warning_obstacle = False

    for i, range_value in enumerate(ranges):
        if range_value == float('inf') or range_value == 0.0:
            continue  # Skip invalid readings

        angle = angle_min + i * angle_increment
        x = range_value * cos(angle)
        y = range_value * sin(angle)

        point = Point(x, y)

        # Check if point is inside the protective field
        if protective_polygon.contains(point):
            protective_obstacle = True
            warning_obstacle = True
            #rospy.loginfo(f"Object in Protective Field: ({x}, {y})")  # Print if object is in the protective field
            break  # No need to check further if protective obstacle is detected

        # Check if point is inside the warning field
        if warning_polygon.contains(point):
            protective_obstacle = False
            warning_obstacle = True
            #rospy.loginfo(f"Object in Warning Field: ({x}, {y})")  # Print if object is in the warning field
            break  # Stop once the first warning obstacle is found

    # Update flags for obstacle states
    obstacle_inside_scan = protective_obstacle
    obstacle_inside_warning_scan = warning_obstacle

def cmd_clbk(msg):
    """
    Callback for navigation command. If there's an obstacle, the robot will stop.
    Otherwise, it will move and call `restart` only once when the state changes.
    """
    global obstacle_inside_scan, obstacle_inside_warning_scan, cmd_vel_pub, prev_obstacle_state, prev_warning_state

    twist = Twist()
    current_obstacle_state = obstacle_inside_scan
    current_warning_state = obstacle_inside_warning_scan

    rospy.loginfo(f"Current Obstacle State: {current_obstacle_state}")
    rospy.loginfo(f"Current Warning State: {current_warning_state}")

    if current_obstacle_state and current_warning_state:
        # If object is in protective field, stop the robot
        rospy.loginfo("Object in Protective Field - Stopping the robot.")
        twist.linear.x = 0.0
        twist.angular.z = 0.0

    elif current_warning_state and not current_obstacle_state:
        # If object is in warning field, stop or slow down the robot
        rospy.loginfo("Object in Warning Field - Slowing down or stopping the robot.")
        data = msg.linear.x
        data1 = msg.angular.z 
        
        if data >= 5 and data1 >= 0.3 :
            twist.linear.x = 0.1
            twist.angular.z = 0.1

        elif data >= 5 and data1 <= 0.2 :
            twist.linear.x = 0.1
            twist.angular.z = data1 / 2
        
        else : 
            twist.linear.x = data / 2
            twist.angular.z = data1 / 2

    else:
        # If no obstacle, allow movement
        if prev_obstacle_state != current_obstacle_state:
            rospy.loginfo("No obstacle, allowing movement.")
        twist = msg  # Take the command from the topic

    # Publish the new movement command
    cmd_vel_pub.publish(twist)

    # Update previous state
    prev_obstacle_state = current_obstacle_state
    prev_warning_state = current_warning_state

def main():
    global cmd_vel_pub, protective_marker_pub, warning_marker_pub
    rospy.init_node('polygon_scan_checker', anonymous=True)

    # Publisher for velocity commands
    cmd_vel_pub = rospy.Publisher('/cmd_vel1', Twist, queue_size=10)

    # Subscribers for LIDAR and command velocity
    rospy.Subscriber("/cmd_vel", Twist, cmd_clbk)
    rospy.Subscriber('/scan', LaserScan, scan_callback)

    # Separate topics for protective and warning fields
    protective_marker_pub = rospy.Publisher('visualization_marker_protective', Marker, queue_size=10)
    warning_marker_pub = rospy.Publisher('visualization_marker_warning', Marker, queue_size=10)

    # Set a timer to continuously publish the markers (no blinking)
    timer = rospy.Timer(rospy.Duration(1.0), timer_callback)  # Adjust interval as needed

    #rospy.loginfo("Polygon Scan Checker Node with Protective and Warning Fields Started.")
    rospy.spin()

if __name__ == '__main__':
    main()

