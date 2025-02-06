#!/usr/bin/python3

import canopen
import sys
import os
import time
import rospy
import roslib
import subprocess
import canopen_node_initiliazation
from std_msgs.msg import Int32
from std_msgs.msg import Float32, String
from geometry_msgs.msg import Twist
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


rospy.init_node("driver_listener", anonymous=True)

# software input for start the motor
start_please_received = False  # Initialize the flag to False
# software input for start the motor

right_pub = rospy.Publisher(right_wheel_encoder_ticks, Int32, queue_size=10)
left_pub = rospy.Publisher(left_wheel_encoder_ticks, Int32, queue_size=10)

node = canopen_node_initiliazation.can_node_configuration()
node1 = canopen_node_initiliazation.can_node1_configuration()

acceleration = acceleration_value  # in RPM/s
deceleration = deacceleration_value  # in RPM/s


def publish_error(error_message):
    error_publisher = rospy.Publisher(motor_driver_error_topic, String, queue_size=10)
    error_publisher.publish(error_message)


def print_exception(e):
    print(f"Error: {e}")


def left_wheel_node_config():
    try:
        global node

        # Left wheel configuration

        time.sleep(0.5)
        print("node quick stop")
        node.state = "QUICK STOP ACTIVE"
        time.sleep(1)

        node.state = "READY TO SWITCH ON"
        print("node booted up")

        timeout = time.time() + 10
        while node.state != "READY TO SWITCH ON":
            if time.time() > timeout:
                raise Exception("Timeout when trying to change state")
        time.sleep(0.5)

        node.state = "SWITCHED ON"
        timeout = time.time() + 10
        while node.state != "SWITCHED ON":
            if time.time() > timeout:
                raise Exception("Timeout when trying to change state")
        time.sleep(0.5)

        # driver parameters
        node.nmt.state = "PRE-OPERATIONAL"
        time.sleep(0.5)
        node.nmt.state = "OPERATIONAL"
        time.sleep(0.5)

        node.sdo["Target_velocity"].raw = 0

        time.sleep(0.1)

        # Setting acceleration and deceleration
        node.sdo["Profile_acceleration"].raw = (acceleration * 65536 * 16384) / 4000000
        node.sdo["Profile_deceleration"].raw = (deceleration * 65536 * 16384) / 4000000

        time.sleep(0.1)

        node.sdo["Target_velocity"].raw = 0

        time.sleep(0.1)

        emergency = node.sdo[0x60FB][1].raw

        node.sdo[0x60FB][
            1
        ].raw = 10  # # change the kp value for arrest the motor motor vibration

        emergency = node.sdo[0x60FB][1].raw

        time.sleep(0.1)

        return 1

    except subprocess.CalledProcessError as e:
        error_message = f"left_wheel_node_config_error: {e}"
        publish_error(error_message)
        print(error_message)

        return 0


def left_wheel_parameter():
    try:
        global node
        # PDO Communication

        # TPDO COMMUNICATION

        node.tpdo.read()

        node.tpdo[2].clear()
        node.tpdo[2].add_variable("Statusword")
        node.tpdo[2].add_variable("Position_actual_value")

        node.tpdo[2].trans_type = 254
        node.tpdo[2].enabled = True

        node.tpdo.save()

        # RPDO COMMUNICATION
        node.rpdo.read()
        node.rpdo[1].clear()
        node.rpdo[1].add_variable("Controlword")
        node.rpdo[1].add_variable("Modes_of_operation")
        node.rpdo[1].add_variable("Target_velocity")
        node.rpdo[1].enabled = True
        node.rpdo[1].trans_type = 254
        node.rpdo.save()

        time.sleep(0.5)

        node.rpdo[1]["Controlword"].phys = 15
        node.rpdo[1]["Modes_of_operation"].phys = 3
        node.rpdo[1].transmit()

        time.sleep(0.5)

        return 1

    except KeyboardInterrupt:
        return 0

    except subprocess.CalledProcessError as e:
        error_message = f"left_wheel_parameter_config_error: {e}"
        publish_error(error_message)
        print(error_message)


def right_wheel_node_config():
    try:
        global node1

        time.sleep(0.5)
        print("node1 quick stop")
        node1.state = "QUICK STOP ACTIVE"
        time.sleep(1)

        node1.state = "READY TO SWITCH ON"
        print("node1 booted up")

        timeout = time.time() + 10
        while node1.state != "READY TO SWITCH ON":
            if time.time() > timeout:
                raise Exception("Timeout when trying to change state")
        time.sleep(0.5)

        node1.state = "SWITCHED ON"
        timeout = time.time() + 10
        while node1.state != "SWITCHED ON":
            if time.time() > timeout:
                raise Exception("Timeout when trying to change state")
        time.sleep(0.5)

        # driver parameters
        node1.nmt.state = "PRE-OPERATIONAL"
        time.sleep(0.5)
        node1.nmt.state = "OPERATIONAL"
        time.sleep(0.5)

        node1.sdo["Target_velocity"].raw = 0

        time.sleep(0.1)

        # Setting acceleration and deceleration
        node1.sdo["Profile_acceleration"].raw = (acceleration * 65536 * 16384) / 4000000
        node1.sdo["Profile_deceleration"].raw = (deceleration * 65536 * 16384) / 4000000

        time.sleep(0.1)

        node1.sdo["Target_velocity"].raw = 0

        time.sleep(0.1)

        emergency = node1.sdo[0x60FB][1].raw

        node1.sdo[0x60FB][
            1
        ].raw = 10  # # change the kp value for arrest the motor motor vibration

        emergency = node1.sdo[0x60FB][1].raw

        time.sleep(0.1)

        return 1

    except subprocess.CalledProcessError as e:
        error_message = f"left_wheel_node_config_error: {e}"
        publish_error(error_message)
        print(error_message)

        return 0


def right_wheel_parameter():
    try:
        global node1

        # PDO Communication

        # TPDO COMMUNICATION
        node1.tpdo.read()

        node1.tpdo[2].clear()
        node1.tpdo[2].add_variable("Statusword")
        node1.tpdo[2].add_variable("Position_actual_value")

        node1.tpdo[2].trans_type = 254
        node1.tpdo[2].enabled = True

        node1.tpdo.save()

        # RPDO COMMUNICATION
        node1.rpdo.read()
        node1.rpdo[1].clear()
        node1.rpdo[1].add_variable("Controlword")
        node1.rpdo[1].add_variable("Modes_of_operation")
        node1.rpdo[1].add_variable("Target_velocity")
        node1.rpdo[1].enabled = True
        node1.rpdo[1].trans_type = 254
        node1.rpdo.save()

        time.sleep(0.5)

        node1.rpdo[1]["Controlword"].phys = 15
        node1.rpdo[1]["Modes_of_operation"].phys = 3
        node1.rpdo[1].transmit()

        time.sleep(0.5)

        return 1

    except KeyboardInterrupt:
        return 0

    except subprocess.CalledProcessError as e:
        error_message = f"right_wheel_parameter_config_error: {e}"
        publish_error(error_message)
        print(error_message)


def left_wheel_set_velocity(velocity):

    global node

    node.sdo["Target_velocity"].raw = 4473.92 * velocity


def left_wheel_velocityCallback(msg):
    left_wheel_set_velocity(msg.data)


def left_wheel_encoder_ticks(msg):
    global node, left_pub

    try:
        ticks = node.tpdo[2]["Position_actual_value"].raw
        # ticks= node.sdo['Position_actual_value'].phys
        left_pub.publish(ticks)

        # return ticks

    except subprocess.CalledProcessError as e:
        error_message = f"left_wheel_encoder_errror: {e}"
        publish_error(error_message)
        print(error_message)


def rightwheel_set_velocity(velocity):

    global node1

    node1.sdo["Target_velocity"].raw = 4473.92 * velocity


def right_wheel_velocityCallback(msg):
    rightwheel_set_velocity(msg.data)


def right_wheel_encoder_ticks(msg):
    global node1, right_pub
    try:
        ticks1 = node1.tpdo[2]["Position_actual_value"].raw
        # ticks1= node1.sdo['Position_actual_value'].phys

        right_pub.publish(ticks1)

        # return ticks1

    except subprocess.CalledProcessError as e:
        error_message = f"right_wheel_encoder_errror: {e}"
        publish_error(error_message)
        print(error_message)


def __leftwheel_stop__():

    global node

    node.sdo["Target_velocity"].raw = 0
    time.sleep(0.5)
    # node.rpdo[1]['Controlword'].phys = 6
    # node.rpdo[1].transmit()

    node.state = "QUICK STOP ACTIVE"
    time.sleep(0.2)

    return


def __rightwheel_stop__():
    global node1

    node1.sdo["Target_velocity"].raw = 0

    time.sleep(0.5)

    # node1.rpdo[1]['Controlword'].phys = 6
    # node1.rpdo[1].transmit()
    node1.state = "QUICK STOP ACTIVE"
    time.sleep(0.2)

    return


def __stop__():

    global node1, node

    node.sdo["Target_velocity"].raw = 0
    node1.sdo["Target_velocity"].raw = 0

    time.sleep(0.5)

    node1.state = "QUICK STOP ACTIVE"
    time.sleep(0.2)
    node.state = "QUICK STOP ACTIVE"
    time.sleep(0.2)

    # node.rpdo[1]['Controlword'].phys = 6
    # node.rpdo[1].transmit()

    # node1.rpdo[1]['Controlword'].phys = 6
    # node1.rpdo[1].transmit()

    return


def motor_signal_callback(msg):
    global start_please_received
    rospy.loginfo("Received message: %s", msg.data)
    if msg.data == "start_please":
        start_please_received = (
            True  # Set the flag to True when start_please message is received
        )
        rospy.loginfo(
            "Received 'start_please' message. Ready to proceed."
        )  # For debugging
        # Add your processing logic here


try:
    # # Robot wheel node configuration
    left_wheel_node_config()
    right_wheel_node_config()

    # # Robot wheel parameter configuration
    right_wheel_parameter()
    left_wheel_parameter()

    # # Robot wheel config finish status sending
    custom_msg_pub = rospy.Publisher(
        "/seirios_custom_msg", String, queue_size=10, latch=True
    )
    custom_msg_pub.publish(
        String(data="LET LOCALISE AND ENABLE THE START BUTTON TO DRIVE")
    )

except canopen.sdo.exceptions.SdoCommunicationError:
    error_message = f"driver communication failure or relase the break switch"
    print(error_message)
    publish_error(error_message)
    custom_msg_pub = rospy.Publisher(
        "/seirios_custom_msg", String, queue_size=10, latch=True
    )
    custom_msg_pub.publish(
        String(data="Driver communication failure or release the brake switch")
    )
    rospy.sleep(1)
    sys.exit(0)

except Exception as e:
    if "process has died" in str(e):
        sys.exit()

    else:
        error_message = f"driver_parameter: {e}"
        print(error_message)
        publish_error(error_message)
        sys.exit()

topic = left_wheel_velacity_topic
topic1 = right_wheel_velacity_topic


def __init__():

    try:
        # Subscribe to 'robot_start' topic
        rospy.Subscriber("robot_start", String, motor_signal_callback)
        ip_address = subprocess.check_output(["iwgetid", "-r"]).decode().strip()

        right = rospy.Timer(rospy.Duration(0.3), right_wheel_encoder_ticks)
        left = rospy.Timer(rospy.Duration(0.3), left_wheel_encoder_ticks)

        while (
            not start_please_received
        ):  # Wait until 'start_please' message is received
            try:
                node.sdo["Target_velocity"].raw = 0
                node1.sdo["Target_velocity"].raw = 0

                rospy.loginfo("Waiting for 'start_please' message...")
                rospy.sleep(1)  # Sleep for 1 second before checking again

            except KeyboardInterrupt:
                break

            except subprocess.CalledProcessError as e:
                error_message = f"Waiting for 'start_please' message exit error: {e}"
                print(error_message)

        try:
            subprocess.run(
                [
                    "python3",
                    "/home/fldec/nissan_ws/src/mobile_robot_autonomous_navigation/script/read_last_pose.py",
                ],
                check=True,
            )
            print("read_amcl ")
        except subprocess.CalledProcessError as e:
            rospy.logerr(f"Failed to execute read_last_pose.py: {e}")

        if ip_address == ssid and start_please_received:
            print("network connect and launched ")

            custom_msg_pub = rospy.Publisher(
                "/seirios_custom_msg", String, queue_size=10, latch=True
            )
            custom_msg_pub.publish(
                String(data="ROBOT READY TO DRIVE LET PROCEED THE NAVIGATION")
            )

            rospy.Subscriber(topic, Float32, left_wheel_velocityCallback)
            rospy.Subscriber(topic1, Float32, right_wheel_velocityCallback)
            try:
                subprocess.run(
                    [
                        "python3",
                        "/home/fldec/nissan_ws/src/mobile_robot_autonomous_navigation/script/amcl_last_pose.py",
                    ],
                    check=True,
                )
                print("amcl_store ")
            except subprocess.CalledProcessError as e:
                rospy.logerr(f"Failed to execute read_last_pose.py: {e}")

            rospy.on_shutdown(__stop__)  # # need to check how its workin
            rospy.spin()

            right.shutdown()
            left.shutdown()

        else:
            __stop__()

    except KeyboardInterrupt():
        # rospy.Timer(rospy.Duration(0.1), __leftwheel_stop__)
        # rospy.Timer(rospy.Duration(0.1), __rightwheel_stop__)
        __stop__()

    except subprocess.CalledProcessError as e:
        error_message = f"Error checking network: {e}"
        print(error_message)
        __stop__()


__init__()
print("stop")
