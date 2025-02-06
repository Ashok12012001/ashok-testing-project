#!/usr/bin/python3
"""
   twist_to_motors - converts a twist message to motor commands.  Needed for navigation stack
   
   
    Copyright (C) 2012 Jon Stephan. 
     
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""
import time

import rospy
import roslib
from std_msgs.msg import Float32
from geometry_msgs.msg import Twist 

import sys
from pathlib import Path

motor_controller_dir = Path(__file__).resolve().parent.parent
sys.path.append(str(motor_controller_dir))

from config.config_txt import left_wheel_velacity_topic, right_wheel_velacity_topic, cmd_velocity_sub_topic, wheel_radius, base_width_data, motor_max_speed


#############################################################
#############################################################
class TwistToMotors():
#############################################################
#############################################################

    #############################################################
    def __init__(self):
    #############################################################
        rospy.init_node("twist_to_motors")
        nodename = rospy.get_name()
        rospy.loginfo("%s started" % nodename)

        self.w = rospy.get_param("~base_width", base_width_data)
        self.r = rospy.get_param("~wheelRadius", wheel_radius)
        self.speed = rospy.get_param("~max_speed", motor_max_speed) ## motor maxspeed m/sec
        self.pub_lmotor = rospy.Publisher(left_wheel_velacity_topic, Float32, queue_size=1)
        self.pub_rmotor = rospy.Publisher(right_wheel_velacity_topic, Float32, queue_size=1)
        rospy.Subscriber(cmd_velocity_sub_topic, Twist, self.twistCallback)
    
        self.rate = rospy.get_param("~rate", 5)
        self.timeout_ticks = rospy.get_param("~timeout_ticks", 2)
        self.left = 0
        self.right = 0
        
    #############################################################
    def spin(self):
    #############################################################
    
        r = rospy.Rate(self.rate)
        idle = rospy.Rate(5)
        then = rospy.Time.now()
        self.ticks_since_target = self.timeout_ticks
    
        ###### main loop  ######
        while not rospy.is_shutdown():
        
            while not rospy.is_shutdown() and self.ticks_since_target < self.timeout_ticks:
                self.spinOnce()
                r.sleep()
            idle.sleep()
                
    #############################################################
    def spinOnce(self):
    #############################################################
	#to shift forward and backward change minus sign
        self.rightvelocity = (1.0 * self.dx - self.dr * self.w / 2)
        self.leftvelocity = (-1.0 * self.dx - self.dr * self.w / 2)
        
        ########## motor closed loop percentage calculation 
        
        self.left_percent  = (100 * self.leftvelocity /self.speed )
        self.right_percent = (100 * self.rightvelocity /self.speed ) 
        
        #rospy.loginfo("publishing: (%d)", self.left_percent) 
                
        self.pub_lmotor.publish(self.left_percent)
        self.pub_rmotor.publish(self.right_percent)
            
        self.ticks_since_target += 1

    #############################################################
    def twistCallback(self,msg):
    #############################################################
        if (msg.linear.x != 0.0 and msg.angular.z != 0.0):
        	rospy.loginfo("-D- twistCallback: %s" % str(msg))
        self.ticks_since_target = 0
        self.dx = msg.linear.x 
        self.dr = msg.angular.z 
        self.dy = msg.linear.y
    
#########cmd_velocity_sub_topic####################################################
#############################################################
if __name__ == '__main__':
    """ main """
    try:
        twistToMotors = TwistToMotors()
        twistToMotors.spin()
    except rospy.ROSInterruptException:
        pass
