#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

def establish_topic_and_subscribe():
    # Initialize the ROS node
    rospy.init_node('robot_start_node', anonymous=True)
    
    # Create a publisher for the '/docking_stop' topic
    robot_starts_pub = rospy.Publisher('/robot_start', String, queue_size=1)
    

    # Keep the node running and idle
    rospy.spin()

if __name__ == '__main__':
    try:
        establish_topic_and_subscribe()
    except rospy.ROSInterruptException:
        pass
