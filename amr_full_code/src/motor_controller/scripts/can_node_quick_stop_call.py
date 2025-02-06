#!/usr/bin/python3
import canopen
import canopen_node_initiliazation
import time

node = canopen_node_initiliazation.can_node_configuration()
node1 = canopen_node_initiliazation.can_node1_configuration()

def break_enable():

	global node,node1

	node.state = "QUICK STOP ACTIVE"
	time.sleep(0.3)
	node1.state = "QUICK STOP ACTIVE"
	time.sleep(0.3)
	'''
	node.state = "SWITCH ON DISABLED" #"QUICK STOP ACTIVE"
	time.sleep(0.3)
	node1.state = "SWITCH ON DISABLED" #"QUICK STOP ACTIVE"
	time.sleep(0.3)

	
	node.sdo[0x6040].raw= 15
	node1.sdo[0x6040].raw= 15
	
	node.sdo[0x6060].raw= 3
	node1.sdo[0x6060].raw= 3

	node.sdo["Profile_acceleration"].raw = ((2 * 65536 * 16384)/4000000) # DEC=[(rps/s*65536*Encoder_Resolution)/4000000]
	node.sdo["Profile_deceleration"].raw =  ((2 * 65536 * 16384)/4000000)

	node1.sdo["Profile_acceleration"].raw = ((2 * 65536 * 16384)/4000000) # DEC=[(rps/s*65536*Encoder_Resolution)/4000000]
	node1.sdo["Profile_deceleration"].raw =  ((2 * 65536 * 16384)/4000000)

	'''
	return

break_enable()

