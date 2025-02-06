#!/usr/bin/python3
import os

# Execute the who command and capture its output
users_output = os.popen('who').read().strip()

# Split the output into lines and extract the usernames
users = [line.split()[0] for line in users_output.split('\n')]

# Get the first username in the list
if users:
    username = users[0]

#AUTO_START_LED_INDICATION_PATH = f'/home/{username}/a_edit_folder_before_ws/src/auto_start_file/config/led_indication.sh'  ## lidar launch .sh file location
AUTO_START_URDF_PATH = f'/home/fldec/nissan_ws/src/auto_start/config/urdf_file.sh'  ## lidar launch .sh file location
AUTO_START_3D_LIDAR_PATH = f'/home/fldec/nissan_ws/src/auto_start/config/lidar_launch.sh'  ## lidar launch .sh file location
AUTO_START_MOTOR_DRIVER_PATH = f'/home/{username}/nissan_ws/src/auto_start/config/launch_motor.sh'  ## motor launch .sh file location
AUTO_START_CAMERA_PATH = f'/home/{username}/nissan_ws/src/auto_start/config/camera_file.sh'  ## motor launch .sh file location

# USB device ID for Intel RealSense Depth Camera 455
vendor_id = 0x8086
product_id = 0x0b3a           #pip install pyusb

ethernet_interface_name = "eno1" 

############### wifi ssid 
desired_ssid = "D7-FDSS" #"nissan_Robot" #"Nibav Lifts_IGK" ## wifi ssid
network_interface = 'wlx90de8073c673'  # Replace with your wireless network interface name

############### wifi ssid 

#ip_to_check = "192.168.12.155" ### Lidar ethernet connection ip
ip_to_check = "192.168.12.155" ### Lidar ethernet connection ip


