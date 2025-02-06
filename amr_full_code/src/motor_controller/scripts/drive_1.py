#!/usr/bin/python3
import canopen
import sys
import os
import time
import rospy
import roslib
from std_msgs.msg import Int32
from std_msgs.msg import Float32
from geometry_msgs.msg import Twist
from pathlib import Path

# Add the 'config' directory to the Python path
motor_controller_dir = Path(__file__).resolve().parent.parent
sys.path.append(str(motor_controller_dir))

from config.config_txt import (
    username,
    EDS_PATH,
    ssid,
    right_can_interface,
    left_can_interface,
    right_motor,
    left_motor,
    left_wheel_velacity_topic,
    right_wheel_velacity_topic,
    right_wheel_encoder_ticks,
    left_wheel_encoder_ticks,
    motor_driver_error_topic,
    acceleration_value,
    deacceleration_value,
)

node = None
node1 = None

rospy.init_node("listener", anonymous=True)

right_pub = rospy.Publisher(right_wheel_encoder_ticks, Int32, queue_size=10)
left_pub = rospy.Publisher(left_wheel_encoder_ticks, Int32, queue_size=10)

acceleration = acceleration_value  # in RPM/s
deceleration = deacceleration_value  # in RPM/s


def publish_error(error_message):
    error_publisher = rospy.Publisher(motor_driver_error_topic, String, queue_size=10)
    error_publisher.publish(error_message)


def print_exception(e):
    print(f"Error: {e}")


try:

    # Connect Motor 1 to CAN1  ######## right motor
    network1 = canopen.Network()
    network1.connect(bustype="socketcan", channel=right_can_interface, bitrate=500000)
    network1.check()
    node1 = canopen.BaseNode402(right_motor, EDS_PATH)
    network1.add_node(node1)

    # Connect Motor 2 to CAN0  ######## left motor
    network = canopen.Network()
    network.connect(bustype="socketcan", channel=left_can_interface, bitrate=500000)
    network.check()
    node = canopen.BaseNode402(left_motor, EDS_PATH)
    network.add_node(node)

    # Check the network connection

except Exception as e:

    error_message = "can0 interfacing error"
    print(error_message)


def left_wheel_parameter():
    global node

    ##################### driver parameters
    node.nmt.state = "PRE-OPERATIONAL"
    time.sleep(0.5)
    node.nmt.state = "OPERATIONAL"
    time.sleep(0.5)

    ##################################### PDO Communication

    ################################## TPDO COMMUNICATION

    node.tpdo.read()

    node.tpdo[2].clear()
    node.tpdo[2].add_variable("Statusword")
    node.tpdo[2].add_variable("Position_actual_value")

    node.tpdo[2].trans_type = 254
    node.tpdo[2].enabled = True

    node.tpdo.save()

    ################################## RPDO COMMUNICATION

    node.rpdo.read()

    node.rpdo[1].clear()
    node.rpdo[1].add_variable("Controlword")
    node.rpdo[1].add_variable("Modes_of_operation")
    node.rpdo[1].add_variable("Target_velocity")
    node.rpdo[1].enabled = True
    node.tpdo[1].trans_type = 254
    node.rpdo.save()

    time.sleep(0.5)

    node.rpdo[1]["Controlword"].phys = 15
    node.rpdo[1]["Modes_of_operation"].phys = 3
    node.rpdo[1].transmit()

    node.sdo["Profile_acceleration"].raw = (
        acceleration * 65536 * 16384
    ) / 4000000  # DEC=[(rps/s*65536*Encoder_Resolution)/4000000]
    node.sdo["Profile_deceleration"].raw = (deceleration * 65536 * 16384) / 4000000

    emergency = node.sdo[0x60fb][1].raw
    print("kpp data", emergency)
        
    node.sdo[0x60fb][1].raw = 10
        
    emergency = node.sdo[0x60fb][1].raw
    print("kpp data", emergency)
        
    time.sleep(0.1)

    return


def right_wheel_parameter():

    global node1

    ##################### driver parameters
    node1.nmt.state = "PRE-OPERATIONAL"
    time.sleep(0.5)
    node1.nmt.state = "OPERATIONAL"
    time.sleep(0.5)

    ##################################### PDO Communication

    ################################## TPDO COMMUNICATION

    node1.tpdo.read()

    node1.tpdo[2].clear()
    node1.tpdo[2].add_variable("Statusword")
    node1.tpdo[2].add_variable("Position_actual_value")

    node1.tpdo[2].trans_type = 254
    node1.tpdo[2].enabled = True

    node1.tpdo.save()

    ################################## RPDO COMMUNICATION

    node1.rpdo.read()

    node1.rpdo[1].clear()
    node1.rpdo[1].add_variable("Controlword")
    node1.rpdo[1].add_variable("Modes_of_operation")
    node1.rpdo[1].add_variable("Target_velocity")
    node1.rpdo[1].enabled = True
    node1.tpdo[1].trans_type = 254
    node1.rpdo.save()

    time.sleep(0.5)

    node1.rpdo[1]["Controlword"].phys = 15
    node1.rpdo[1]["Modes_of_operation"].phys = 3
    node1.rpdo[1].transmit()

    node1.sdo["Profile_acceleration"].raw = (
        acceleration * 65536 * 16384
    ) / 4000000  # DEC=[(rps/s*65536*Encoder_Resolution)/4000000]
    node1.sdo["Profile_deceleration"].raw = (deceleration * 65536 * 16384) / 4000000

    emergency = node1.sdo[0x60fb][1].raw
    print("kpp data", emergency)
        
    node1.sdo[0x60fb][1].raw = 10
        
    emergency = node1.sdo[0x60fb][1].raw
    print("kpp data", emergency)
        
    time.sleep(0.1)

    return


def left_wheel_set_velocity(velocity):

    global node

    node.sdo["Target_velocity"].raw = (
        4473.92 * velocity
    )  # # (DEC=(RPM × 512×encoder resolution / 1875​)  DEC for ((1 RPM * 512 * 16384)/1875)​=4473.92)  #example :encoder resolution ppr = 4096 for one quterent , four querenrt = 4096 *4 = 16384 ppr)


def left_wheel_velocityCallback(msg):
    left_wheel_set_velocity(msg.data)


def left_wheel_encoder_ticks(msg):
    global node, left_pub

    ticks = node.tpdo[2]["Position_actual_value"].raw
    # ticks= node.sdo['Position_actual_value'].phys
    left_pub.publish(ticks)

    # return ticks


def rightwheel_set_velocity(velocity):

    global node1

    node1.sdo["Target_velocity"].raw = (
        4473.92 * velocity
    )  # # (DEC=(RPM × 512×encoder resolution / 1875​)  DEC for ((1 RPM * 512 * 16384)/1875)​=4473.92) #example :encoder resolution ppr = 4096 for one quterent , four querenrt = 4096 *4 = 16384 ppr)


def right_wheel_velocityCallback(msg):
    rightwheel_set_velocity(msg.data)


def right_wheel_encoder_ticks(msg):
    global node1, right_pub

    ticks1 = node1.tpdo[2]["Position_actual_value"].raw
    # ticks1= node1.sdo['Position_actual_value'].phys

    right_pub.publish(ticks1)

    # return ticks1


def __leftwheel_stop__():

    global node

    node.sdo["Target_velocity"].raw = 0
    time.sleep(0.5)
    node.rpdo[1]["Controlword"].phys = 6
    node.rpdo[1].transmit()

    return


def __rightwheel_stop__():
    global node1

    node1.sdo["Target_velocity"].raw = 0

    time.sleep(0.5)

    node1.rpdo[1]["Controlword"].phys = 6
    node1.rpdo[1].transmit()

    return


def __stop__():

    global node1, node

    node.sdo["Target_velocity"].raw = 0

    node1.sdo["Target_velocity"].raw = 0

    time.sleep(0.5)

    node.rpdo[1]["Controlword"].phys = 6
    node.rpdo[1].transmit()

    node1.rpdo[1]["Controlword"].phys = 6
    node1.rpdo[1].transmit()

    return


def break_check():
    global node1, node

    node.rpdo[1]["Controlword"].phys = 15
    node1.rpdo[1]["Controlword"].phys = 15

    return


try:

    left_wheel_parameter()
    right_wheel_parameter()


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

        print("network connect and launched ")
        rospy.Subscriber(topic, Float32, left_wheel_velocityCallback)
        rospy.Subscriber(topic1, Float32, right_wheel_velocityCallback)

        right = rospy.Timer(rospy.Duration(0.3), right_wheel_encoder_ticks)
        left = rospy.Timer(rospy.Duration(0.3), left_wheel_encoder_ticks)

        rospy.on_shutdown(__stop__)  ## need to check how its working
        rospy.spin()

        right.shutdown()
        left.shutdown()

        # else :
        # 	__stop__()

    except KeyboardInterrupt():
        rospy.Timer(rospy.Duration(0.1), __leftwheel_stop__)
        rospy.Timer(rospy.Duration(0.1), __rightwheel_stop__)
        __stop__()

    except subprocess.CalledProcessError as e:
        error_message = f"Error checking network: {e}"
        print(error_message)
        __stop__()


__init__()
print("stop")
