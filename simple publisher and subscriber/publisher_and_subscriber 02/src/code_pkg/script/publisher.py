#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

def publisher():
    # Initialize the publisher node
    rospy.init_node('ashoke_node', anonymous=True)

    # Create a publisher object
    pub = rospy.Publisher('cricket_topic', String, queue_size=10)

    # Set the publishing rate
    rate = rospy.Rate(1)  # 1 Hz

    while not rospy.is_shutdown():
        # Create a message to publish
        hello_str = "i hit 100 : %s" % rospy.get_time()
        
        # Log the message
        rospy.loginfo(hello_str)

        # Publish the message
        pub.publish(hello_str)

        # Sleep to maintain the publishing rate
        rate.sleep()

if __name__ == '__main__':
    try:
        publisher()
    except rospy.ROSInterruptException:
        pass
