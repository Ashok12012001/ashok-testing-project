#!/usr/bin/python3
import canopen
import sys
import os
import time

from pathlib import Path

# Add the 'config' directory to the Python path
auto_start_file_dir = Path(__file__).resolve().parent.parent
sys.path.append(str(auto_start_file_dir))

from config.config_txt import username, EDS_PATH, ssid, right_can_interface, left_can_interface , right_motor, left_motor

node = None
node1 = None

def can_node1_configuration():
	try:
		# Connect Motor 2 to CAN0  ######## left motor
		network1 = canopen.Network()
		network1.connect(bustype='socketcan', channel = right_can_interface, bitrate=1000000) # check the eds file location and motor baudrate and motor power and canopen connection interface in hardware connection to pc
		network1.check()
		node = canopen.BaseNode402(right_motor, EDS_PATH)
		network1.add_node(node)
	
		# Check the network connection
		
		return node
	
	except Exception as e:

		error_message = "can0 interfacing error"
		print(error_message)
		
def can_node_configuration():

	try:
		# Connect Motor 1 to CAN1  ######## right motor
		network = canopen.Network()
		network.connect(bustype='socketcan', channel=left_can_interface, bitrate=1000000)
		network.check()
		node1 = canopen.BaseNode402(left_motor, EDS_PATH)
		network.add_node(node1)
		
		return node1
	
	except Exception as e:

		error_message = "can1 interfacing error"
		print(error_message)
		
#can_node1_configuration()
#can_node_configuration()
