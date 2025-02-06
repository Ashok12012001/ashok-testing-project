#!/usr/bin/python3
import canopen
import sys
import time
import canopen_node_initiliazation
from pathlib import Path

# Add the 'config' directory to the Python path
motor_controller_dir = Path(__file__).resolve().parent.parent
sys.path.append(str(motor_controller_dir))

from config.config_txt import (
    acceleration_value,
    deacceleration_value,
)

acceleration = acceleration_value  # in RPM/s
deceleration = deacceleration_value  # in RPM/s

node = canopen_node_initiliazation.can_node_configuration()
node1 = canopen_node_initiliazation.can_node1_configuration()

def left_wheel_parameter():
    try:
        global node
        node.nmt.state = 'PRE-OPERATIONAL'
        time.sleep(0.5)
        node.nmt.state = 'OPERATIONAL'
        time.sleep(0.5)

        # RPDO Communication
        node.rpdo.read()
        node.rpdo[1].clear()
        node.rpdo[1].add_variable('Controlword')
        node.rpdo[1].add_variable('Modes_of_operation')
        node.rpdo[1].add_variable('Target_velocity')
        node.rpdo[1].enabled = True
        node.rpdo[1].trans_type = 254
        node.rpdo.save()
        
        time.sleep(0.5)
        
        node.rpdo[1]['Controlword'].phys = 15
        node.rpdo[1]['Modes_of_operation'].phys = 3
        node.rpdo[1].transmit()

        # Setting acceleration and deceleration
        node.sdo["Profile_acceleration"].raw = ((acceleration * 65536 * 16384)/4000000)
        node.sdo["Profile_deceleration"].raw = ((deceleration * 65536 * 16384)/4000000)

        return 1

    except KeyboardInterrupt:
        return 0
        
def right_wheel_parameter():
    try:
        global node1
        node1.nmt.state = 'PRE-OPERATIONAL'
        time.sleep(0.5)
        node1.nmt.state = 'OPERATIONAL'
        time.sleep(0.5)

        # RPDO Communication
        node1.rpdo.read()
        node1.rpdo[1].clear()
        node1.rpdo[1].add_variable('Controlword')
        node1.rpdo[1].add_variable('Modes_of_operation')
        node1.rpdo[1].add_variable('Target_velocity')
        node1.rpdo[1].enabled = True
        node1.rpdo[1].trans_type = 254
        node1.rpdo.save()
        
        time.sleep(0.5)
        
        node1.rpdo[1]['Controlword'].phys = 15
        node1.rpdo[1]['Modes_of_operation'].phys = 3
        node1.rpdo[1].transmit()

        # Setting acceleration and deceleration
        node1.sdo["Profile_acceleration"].raw = ((acceleration * 65536 * 16384)/4000000)
        node1.sdo["Profile_deceleration"].raw = ((deceleration * 65536 * 16384)/4000000)

        return 1

    except KeyboardInterrupt:
        return 0

def __leftwheel_stop__():

	global node

	node.sdo['Target_velocity'].raw=  0
	time.sleep(0.5)
	node.rpdo[1]['Controlword'].phys = 6
	node.rpdo[1].transmit()
	
	return

def __rightwheel_stop__():
	global node1

	node1.sdo['Target_velocity'].raw= 0

	time.sleep(0.5)

	node1.rpdo[1]['Controlword'].phys = 6
	node1.rpdo[1].transmit()
	
	return 
	
def __stop__():

	global node1,node

	node.sdo['Target_velocity'].raw= 0
	node1.sdo['Target_velocity'].raw= 0
		
	time.sleep(0.5)
	
	node.rpdo[1]['Controlword'].phys = 6
	node.rpdo[1].transmit()

	node1.rpdo[1]['Controlword'].phys = 6
	node1.rpdo[1].transmit()
	
	return

def break_check():
	global node1,node
	
	node.rpdo[1]['Controlword'].phys = 15
	node1.rpdo[1]['Controlword'].phys = 15
	
	return

#left_wheel_parameter()
#right_wheel_parameter()

