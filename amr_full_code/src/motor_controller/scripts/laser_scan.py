#!/usr/bin/python3

import rospy
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist
from shapely.geometry import Polygon, Point as ShapelyPoint
from math import cos, sin
from visualization_msgs.msg import Marker
from geometry_msgs.msg import Point
import time

# Define the polygon centered around the robot
polygon = Polygon([(-0.0, -0.4), (0.3, -0.4), (0.3, 0.4), (-0.0, 0.4)])

# Publisher for /cmd_vel
cmd_vel_pub = None
obstacle_inside_scan = False
obstacle_inside_camera = False
marker_pub = None
prev_obstacle_state = True  # Assume initially there is an obstacle

def timer_callback(event):
    global marker_pub
    marker = Marker()
    marker.header.frame_id = "laser_link"  # Using robot's base frame
    marker.type = Marker.LINE_STRIP
    marker.action = Marker.ADD
    marker.scale.x = 0.05  # Line width
    marker.color.a = 1.0  # Fully opaque
    marker.color.r = 1.0  # Red color

    # Extract polygon points from the predefined Shapely Polygon
    points = []
    for x, y in polygon.exterior.coords:
        p = Point(x=x, y=y, z=0)  # Create a geometry_msgs Point with polygon coordinates
        points.append(p)

    # Close the polygon by adding the first point again at the end
    points.append(points[0])

    marker.points = points
    marker_pub.publish(marker)

def scan_callback(scan_msg):
    """
    Callback for LaserScan data (LIDAR). Checks if any point from the scan lies inside the polygon.
    """
    global obstacle_inside_scan

    angle_min = scan_msg.angle_min
    angle_increment = scan_msg.angle_increment
    ranges = scan_msg.ranges

    obstacle_detected = False  # Track if any obstacle is detected

    for i, range_value in enumerate(ranges):
        if range_value == float('inf') or range_value == 0.0:
            # Skip invalid or zero ranges
            continue

        # Convert polar coordinates (range, angle) to Cartesian (x, y)
        angle = angle_min + i * angle_increment
        x = range_value * cos(angle)
        y = range_value * sin(angle)

        # Check if the point is within the polygon
        point = ShapelyPoint(x, y)
        if polygon.contains(point):
            obstacle_detected = True
            #rospy.loginfo("LIDAR scan data within polygon, obstacle detected!")
            break  # No need to check more points once an obstacle is detected

    # Update the global state for LIDAR scan
    obstacle_inside_scan = obstacle_detected

def camera_scan_callback(scan_msg):
    """
    Callback for LaserScan data (from camera). Checks if any point from the scan lies inside the polygon.
    """
    global obstacle_inside_camera

    angle_min = scan_msg.angle_min
    angle_increment = scan_msg.angle_increment
    ranges = scan_msg.ranges

    obstacle_detected = False  # Track if any obstacle is detected

    for i, range_value in enumerate(ranges):
        if range_value == float('inf') or range_value == 0.0:
            # Skip invalid or zero ranges
            continue

        # Convert polar coordinates (range, angle) to Cartesian (x, y)
        angle = angle_min + i * angle_increment
        x = range_value * cos(angle)
        y = range_value * sin(angle)

        # Check if the point is within the polygon
        point = ShapelyPoint(x, y)
        if polygon.contains(point):
            obstacle_detected = True
            rospy.loginfo("Camera scan data within polygon, obstacle detected!")
            break  # No need to check more points once an obstacle is detected

    # Update the global state for camera scan
    obstacle_inside_camera = obstacle_detected

def cmd_clbk(msg):
    """
    Callback for navigation command. If there's an obstacle, the robot will stop.
    Otherwise, it will move and call `restart` only once when the state changes.
    """
    global obstacle_inside_scan, obstacle_inside_camera, cmd_vel_pub, prev_obstacle_state

    twist = Twist()
    current_obstacle_state = obstacle_inside_scan or obstacle_inside_camera

    if current_obstacle_state:
        # Stop the robot if an obstacle is detected by either the LIDAR or the camera
        twist.linear.x = 0.0
        twist.angular.z = 0.0
        rospy.loginfo("Obstacle detected, stopping the robot.")
    else:
        # If there was an obstacle and now there isn't, call `restart()` once
        if prev_obstacle_state:  # Check if the previous state had an obstacle
            print("restarted")
            #rospy.loginfo("No obstacle detected, restarting process.")

        # Pass the navigation command through if no obstacle
        twist = msg
        #rospy.loginfo("No obstacle, allowing movement.")

    # Publish the final twist message
    cmd_vel_pub.publish(twist)

    # Update the previous obstacle state
    prev_obstacle_state = current_obstacle_state


def main():
    global cmd_vel_pub
    global marker_pub
    rospy.init_node('polygon_scan_checker', anonymous=True)

    # Initialize the publisher to the /cmd_vel topic
    cmd_vel_pub = rospy.Publisher('/cmd_vel1', Twist, queue_size=10)

    # Subscribe to /cmd_nav (incoming navigation commands)
    rospy.Subscriber("/cmd_vel", Twist, cmd_clbk)

    # Subscribe to /scan (LIDAR LaserScan data)
    rospy.Subscriber('/scan', LaserScan, scan_callback)
    marker_pub = rospy.Publisher('visualization_marker', Marker, queue_size=10)

    timer = rospy.Timer(rospy.Duration(0.1), timer_callback)

    # Subscribe to /camera/scan (Camera LaserScan data)
    rospy.Subscriber('/camera/scan', LaserScan, camera_scan_callback)

    rospy.loginfo("Polygon Scan Checker Node Started.")
    rospy.spin()

if __name__ == '__main__':
    main()

