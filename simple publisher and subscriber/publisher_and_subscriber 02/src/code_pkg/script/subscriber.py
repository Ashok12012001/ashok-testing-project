#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

def callback(data):
    # Log the received message
    rospy.loginfo("I heard: %s", data.data)

def subscriber():
    # Initialize the subscriber node
    rospy.init_node('gowtham', anonymous=True)

    # Create a subscriber object
    rospy.Subscriber('cricket_topic', String, callback)

    # Keep the node running
    rospy.spin()

if __name__ == '__main__':
    try:
        subscriber()
    except rospy.ROSInterruptException:
        pass
