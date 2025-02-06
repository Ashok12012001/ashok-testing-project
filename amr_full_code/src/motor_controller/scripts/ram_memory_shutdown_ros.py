#!/usr/bin/env python3

import rospy
from std_msgs.msg import String
import psutil
import time

def check_memory_status():
    # Get memory information
    memory = psutil.virtual_memory()
    swap = psutil.swap_memory()

    # Calculate memory usage percentages
    ram_usage = memory.percent
    swap_usage = swap.percent

    # Define thresholds
    ram_high_threshold = 75.0
    swap_high_threshold = 40.0

    # Evaluate physical memory status
    ram_status = "normal"
    swap_status = "normal"
    
    if ram_usage > ram_high_threshold:
        ram_status = "high"
    if swap_usage > swap_high_threshold:
        swap_status = "high"

    return ram_status, swap_status

def main():
    rospy.init_node('ram_memory_status_publisher', anonymous=True)
    pub = rospy.Publisher('seirios_custom_msg', String, queue_size=10)

    rate = rospy.Rate(2)  # 1 Hz

    while not rospy.is_shutdown():
        ram_status, swap_status = check_memory_status()

        if ram_status == "high" and swap_status == "high":
            message = "Critical: Both RAM and Swap are high. Shutting down the robot to prevent failure..."
            pub.publish(message)
            time.sleep(2)
            rospy.logwarn(message)  # Log the warning message

        rate.sleep()  # Sleep to maintain the 1 Hz rate

if __name__ == "__main__":
    main()
