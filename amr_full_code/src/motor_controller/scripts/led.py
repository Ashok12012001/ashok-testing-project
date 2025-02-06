#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

def publish_status_led():
    # Initialize the ROS node
    rospy.init_node('status_led_publisher', anonymous=True)
    
    # Create a latched publisher to /status_led topic
    pub = rospy.Publisher('/status_led', String, latch=True, queue_size=10)
    
    # Define the message
    msg = String()
    msg.data = "6"
    
    # Publish the message
    rospy.loginfo("Publishing latched message to /status_led: %s", msg.data)
    pub.publish(msg)
    
    # Keep the node running until manually interrupted
    rospy.spin()

if __name__ == '__main__':
    try:
        publish_status_led()
    except rospy.ROSInterruptException:
        pass

