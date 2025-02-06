#!/usr/bin/python3

import rospy
import time
from math import degrees
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist         #cmd_vel publisher
from geometry_msgs.msg import Pose
from tf.transformations import euler_from_quaternion, quaternion_from_euler

linear_x_input=float(input("linear x input: "))
angular_z_input=float(input("angular z input: "))
timeout=float(input("Timeout: "))


LINEAR_X_SPEED = linear_x_input
ANGULAR_Z_SPEED = angular_z_input
TIMEOUT = timeout #seconds
FREQ_MOTOR = 10.0 #Hz

cmd_vel_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=1)

travelled_pose = Pose()
current_pose = Pose()
start_pose = Pose()
stop_pose = Pose()

def odom_callback(msg):
    global current_pose
    current_pose = msg.pose.pose
    pass

def move_robot(speed_linear_x=LINEAR_X_SPEED, speed_angular_z=ANGULAR_Z_SPEED):
    msg = Twist()
    msg.linear.x = speed_linear_x
    msg.angular.z = speed_angular_z
    cmd_vel_pub.publish(msg)

if __name__ == '__main__':
    rospy.init_node('needle_controller')

    odom_sub = rospy.Subscriber("/odom", Odometry, odom_callback)
    rate = rospy.Rate(FREQ_MOTOR)

    rospy.sleep(2.0) #waiting the robot get the odometry data

    start = time.time()
    print("Starting....")

    start_pose = current_pose
    print(start_pose)
    while not rospy.is_shutdown() and time.time() < start + TIMEOUT:
        move_robot()
        rate.sleep()
        pass

    move_robot(0.0, 0.0)
    rate.sleep()
    print("=====================")
    print("[Stop Pose]")
    print(current_pose)
    stop_pose = current_pose
    travelled_pose.position.x = stop_pose.position.x - start_pose.position.x
    travelled_pose.position.y = stop_pose.position.y - start_pose.position.y
    q_stop=[stop_pose.orientation.x, stop_pose.orientation.y, stop_pose.orientation.z, stop_pose.orientation.w]
    euler_stop = euler_from_quaternion(q_stop)
    q_start=[start_pose.orientation.x, start_pose.orientation.y, start_pose.orientation.z, start_pose.orientation.w]
    euler_start = euler_from_quaternion(q_start)

    print("euler_stop: ", euler_stop[2])
    print("euler_start: ", euler_start[2])
    yaw_angle = euler_stop[2] - euler_start[2]

    print("=====================")
    print("[Travelled Distance]")
    print("x: %.03f m" % travelled_pose.position.x)
    print("y: %.03f m" % travelled_pose.position.y)
    print("yaw: %.03f rad = %.03f deg" % (yaw_angle, degrees(yaw_angle)))
    print("=====================")

    
    # rospy.spin()
    