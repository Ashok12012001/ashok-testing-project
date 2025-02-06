#!/usr/bin/python3
import os

# Execute the who command and capture its output
users_output = os.popen("who").read().strip()

# Split the output into lines and extract the usernames
users = [line.split()[0] for line in users_output.split("\n")]

# Get the first username in the list
if users:
    username = users[0]

# AUTO_START_FILE_PATH = f'/home/{username}/a_edit_folder_before_ws/src/auto_start_file/'  ## led indication file location

EDS_PATH = f"/home/fldec/nissan_ws/src/motor_controller/config/FD_EDS_20240802.eds"

ssid = "D7-FDSS"

### canopen node interface (can1 or can)

right_can_interface = "can0"
left_can_interface = "can1"

# motor right and left node id
right_motor = 2
left_motor = 1

### motor acceleration and deacceleration set

acceleration_value = 1  # 1#4
deacceleration_value = 1  # 4


##### driver encoder topic publish string
right_wheel_encoder_ticks = "right_wheel_tickes"
left_wheel_encoder_ticks = "left_wheel_tickes"


##### error publish topic name
motor_driver_error_topic = "canopen_motor_error"  ## error topic publish name

##### driver target velacity receive topic string
left_wheel_velacity_topic = "lwheel_vtarget"
right_wheel_velacity_topic = "rwheel_vtarget"

################### twist_to_motor

########### wheel radius
wheel_radius = 0.0825
base_width_data = 0.248  ## difference b/w two wheels
motor_max_speed = 0.2  # m/sec

##### target velocity receive topic string
cmd_velocity_sub_topic = "/cmd_vel"

############## diff_tf

##### motor odometry data publisher topic
odometry_topic = "wheel_odom"

##### this data mension in motor datasheet
robot_encoder_min = int(-2147483648 / 2)  # motor min encode data
robot_encoder_max = int(21474836478 / 2)  # motor max encode data

##### Need to calculate the data for motor 1m movement
encode_ticks_meter = 174580  #  The number of wheel encoder ticks per meter of travel

##### robot measurement
robot_base_width = 0.248  # The wheel base width in meters

##### tf topic name mension
robot_base_frame_id = "base_link"  # the name of the base frame of the robot
robot_odom_frame_id = "odom"  # the name of the odometry reference frame
