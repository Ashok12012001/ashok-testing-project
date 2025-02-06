#!/usr/bin/python3
import canopen
import sys
import os
import time
import subprocess
import canopen_node_initiliazation
from pathlib import Path

# Add the 'config' directory to the Python path
motor_controller_dir = Path(__file__).resolve().parent.parent
sys.path.append(str(motor_controller_dir))

from config.config_txt import (
    motor_driver_error_topic,
    right_wheel_encoder_ticks,
    left_wheel_encoder_ticks,
    right_wheel_velacity_topic,
    left_wheel_velacity_topic,
    acceleration_value,
    deacceleration_value,
    username,
    ssid,
)


node = canopen_node_initiliazation.can_node_configuration()
node1 = canopen_node_initiliazation.can_node1_configuration()

emergency = node.sdo[0x60fb][3].raw
print("kpp data", emergency)

emergency1 = node1.sdo[0x60fb][3].raw
print("kpp data", emergency1)

