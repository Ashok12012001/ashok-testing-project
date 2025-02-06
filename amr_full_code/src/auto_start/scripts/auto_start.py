#!/usr/bin/env python3
import time
import rospy
import select
import subprocess
import netifaces
import usb.core
import usb.util
import sys

from sensor_msgs.msg import LaserScan
from datetime import datetime
from std_msgs.msg import String

from pathlib import Path

# Add the 'config' directory to the Python path
auto_start_file_dir = Path(__file__).resolve().parent.parent
sys.path.append(str(auto_start_file_dir))

from config.config_txt_auto_start import (
    AUTO_START_3D_LIDAR_PATH,
    AUTO_START_MOTOR_DRIVER_PATH,
    AUTO_START_CAMERA_PATH,
    AUTO_START_URDF_PATH,
    vendor_id,
    product_id,
    desired_ssid,
    network_interface,
    ip_to_check,
    ethernet_interface_name,
)

import sys
from pathlib import Path

# Add motor_controller/scripts directory to the Python path
motor_controller_dir = (
    Path(__file__).resolve().parents[2] / "motor_controller" / "scripts"
)
sys.path.append(str(motor_controller_dir))

import canopen_node_initiliazation

node = canopen_node_initiliazation.can_node_configuration()
node1 = canopen_node_initiliazation.can_node1_configuration()

one_time_launch = 0
should_exit = False


def wifi_status_checking():
    # Check the Wi-Fi driver status
    try:
        wifi_status = subprocess.check_output(["iwconfig", network_interface]).decode("utf-8")
        if "no wireless extensions" in wifi_status:
            connected = False
        wifi_scan = subprocess.check_output(["iwlist", network_interface, "scan"]).decode("utf-8")
        if desired_ssid in wifi_scan:
            connected = True
            if desired_ssid in wifi_status:
                return 1
            else:
                connected = False
        else:

            # print(f"{desired_ssid} not found in available networks")
            connected = False
            return 0

    except subprocess.CalledProcessError as e:

        # print("Error checking Wi-Fi status:", e)
        return 0


####################### ethernet hardware connection checking
def is_ethernet_connected(interface_name):
    try:
        addrs = netifaces.ifaddresses(interface_name)
        if netifaces.AF_LINK in addrs and netifaces.AF_INET in addrs:
            return True
    except ValueError:
        return False


def ethernet_hardware_checking(ip_to_check):
    interface_name = ethernet_interface_name
    if is_ethernet_connected(interface_name):
        addrs = netifaces.ifaddresses(interface_name)
        if ( netifaces.AF_INET in addrs and "addr" in addrs[netifaces.AF_INET][0] and addrs[netifaces.AF_INET][0]["addr"] == ip_to_check):
            # print(f"Ethernet hardware connected, IP address: {ip_to_check}")
            return 1
    else:
        return 0


###################### camera usb checking
def camera_checking():

    total_wait_time = 0.01  # Wait for 1 second in total
    start_time = time.time()

    # Find the device
    device = usb.core.find(idVendor=vendor_id, idProduct=product_id)

    if device is None:
        # print("camera Device not found.")
        elapsed_time = time.time() - start_time

        if elapsed_time >= total_wait_time:
            # print("Device not found within the specified time.")
            return 0

    else:
        # Print information about the device
        # print("camera Device found:")
        # print(f"  Vendor ID: {hex(device.idVendor)}")
        # print(f"  Product ID: {hex(device.idProduct)}")

        try:
            device.reset()
            # print("Device reset.")
            return 1

        except usb.core.USBError as e:
            elapsed_time = time.time() - start_time
            if elapsed_time >= total_wait_time:
                # print(f"Error resetting device: {e}")
                return 0


########################## canopen driver checking
def is_can_interface_present(interface_name):
    try:
        subprocess.check_output(["ip", "a", "show", interface_name])
        return True
    except subprocess.CalledProcessError:
        return False


def can_driver_presend():

    can_interface_names = ["can1", "can0"]  # List of CAN interface names

    for can_interface_name in can_interface_names:
        if is_can_interface_present(can_interface_name):
            print(f"{can_interface_name} is present.")
            return 1
        else:
            print(f"{can_interface_name} is not present.")
            return 0


########################## canopen hardware connection checking
def canopen_hardware_candump():
    try:
        interfaces = ["can0", "can1"]  # List of CAN interfaces to check
        results = {}  # Dictionary to hold the counts of unique nodes for each interface

        for interface in interfaces:
            try:
                # Run the candump command in the background for the specified interface
                process = subprocess.Popen(["candump", interface],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,)

                # Allow some time for the candump process to capture data
                total_wait_time = 3  # Total wait time in seconds
                start_time = time.time()

                # Initialize a counter for the number of lines read
                line_count = 0

                # Set the interval for printing lines and checking the timer
                check_interval = 1  # Check the timer every 1 second

                # Initialize a set to store unique nodes
                unique_nodes = set()

                # Read and print the output, limit to 20 lines or until the timer expires
                while time.time() - start_time < total_wait_time:
                    ready, _, _ = select.select(
                        [process.stdout], [], [], 0.1
                    )  # Non-blocking read
                    if ready:
                        line = process.stdout.readline().strip()
                        line_count += 1

                    # Extract the node from the line (assuming a simple pattern)
                    if line.startswith(interface) and line.split()[1].startswith("7"):
                        can_node = line.split()[1]
                        unique_nodes.add(can_node)

                    if line_count >= 20:
                        break

                # Terminate the candump process
                process.terminate()

                # Capture the output (remaining lines)
                remaining_output, error = process.communicate()

                # Store the count of unique nodes for the current interface
                results[interface] = len(unique_nodes)

            except Exception as e:
                print("Error:", str(e))
                results[interface] = 0  # Set to 0 in case of an error

        # Check the conditions for returning or printing counts
        if results["can0"] == 1 and results["can1"] == 1:
            print("Both can0 and can1 detected one unique node.")
            return 2  # Return the count of unique nodes if both detected one
        else:
            print("Unique nodes detected:")
            print(f"can0: {results['can0']}, can1: {results['can1']}")
            return results  # Return the dictionary with counts for each interface

    except Exception as e:
        print("Error:", str(e))


def switch_case_and_publish(value):
    switch_dict = {
        1: "Fault 1 : CAMERA CABLE WIRE DISCONNECTED",
        2: "Fault 2 : ETHERNET CABLE WIRE DISCONNECTED",
        3: "Fault 3 : CANOPEN CABLE WIRE DISCONNECTED ",
        4: "Fault 4 : CAN NODE COMMUNICATION ERROR BY MOTOR ",
        5: "Fault 5 : CANOPEN COMMUNICATION CRROR RESTART AND CHECK, ONLY TWO TIME MORE THEN THAT CONTACT TO SERVICE PERSON",
        6: "Fault 6 : RIGHT WHEEL ENCODER OR LEFT WHEEL ENCODER WIRE DISCONNECTED",
        7: "Fault 7 : LIDAR DATA NOT PUBLISHED",
        8: "Fault 8 : EMCY BREAK ENABLE",
        9: "Fault 9 : NO HARDWARE ERROR",
        10: "Fault 10 : NO ERROR, FILE STARTED",
        11: "Fault 11 : BEFORE, FILE STARTED",
        12: "Fault 12 : SOCKETCAN DRIVE NOT PRESENT",
        13: "Fault 13 : START",
        14: "check",
    }

    # Create a publisher for the common topic
    pub = rospy.Publisher("error_topic", String, queue_size=100)

    # Publish the specified case
    result = switch_dict.get(value, "Default Case")
    pub.publish(result)
    # print("result", result)


def hardware_checking_part():

    try:
        can_one_time_sto_relese_check = 0

        while 1:
            try:
                wifi_status = wifi_status_checking()

                if wifi_status:

                    print("wifi connected")

                    ############# ros listener initialization

                    rospy.init_node("home_listener", anonymous=True)
                    custom_msg_pub = rospy.Publisher("/seirios_custom_msg",String,queue_size=10,latch=True,)
                    custom_msg_pub.publish(String(data="RELESE THE MOTOR BREAK SWITCH THEN ONLY POWER ON ROBOT"))

                    time.sleep(5)
                    switch_case_and_publish(13)
                    urdf_process = subprocess.run(AUTO_START_URDF_PATH, shell=True)
                    #camer_hardware_check = camera_checking() # At present now no camera
                    canopen_hardware_driver_checking = can_driver_presend()

                    ethernet_hardware_check = ethernet_hardware_checking(ip_to_check)
                    
                    '''
                    ############ camera checking
                    if camer_hardware_check == 1:
                         print("\033[92m" + "CAMERA IS CONNECTED, CONTINUE" + "\033[0m")
                         camera_process = subprocess.call(AUTO_START_CAMERA_PATH , shell=True)
                    else:
                         error_message = ("CAMERA IS NOT CONNECTED, CHECK BELOW ROBOT OBSTACLE")
                         print("\033[91m" + error_message + "\033[0m")
                         switch_case_and_publish(1)
                    '''

                    ############ ethernet checking
                    if ethernet_hardware_check == 1:
                        print("\033[92m" + "ETHERNET IS CONNECTED, CONTINUE" + "\033[0m")

                    else:
                        error_message = "CHECK THE ETHERNET HARDWARE CONNECTION"
                        print("\033[91m" + error_message + "\033[0m")
                        switch_case_and_publish(2)

                    if canopen_hardware_driver_checking:
                        ###################### can hardware connection
                        canopen_hardware_checking = 2 #canopen_hardware_candump()
                        if canopen_hardware_checking == 2:
                            print("\033[92m"+ "HARDWARE CONNECTION FOR CANOPEN IS OKAY"+ "\033[0m")

                        else:
                            error_message = "HARDWARE CONNECTION DISCONNECT FAILURE, CONTACT TO SERVICE PERSON"
                            print("\033[91m" + error_message + "\033[0m")
                            switch_case_and_publish(3)
                    else:
                        error_message = ("CANOPEN DRIVER FAILURE, CONTACT TO SERVICE PERSON")
                        print("\033[91m" + error_message + "\033[0m")
                        switch_case_and_publish(12)

                    #if ((canopen_hardware_checking >= 2) and camer_hardware_check and ethernet_hardware_check):
                    if ((canopen_hardware_checking >= 2) and ethernet_hardware_check):
                        print("\033[91m" + "before start file" + "\033[0m")
                        custom_msg_pub = rospy.Publisher("/seirios_custom_msg", String, queue_size=10, latch=True)
                        custom_msg_pub.publish(
                            String(data="PLEASE DELETED THE PREVIOUS TASK OR PAUSE THE PREVIOUS TASK AND LOCALISED THE ROBOT AND PROCEED THE START BUTTON IN AUXIALLARY "))
                        switch_case_and_publish(9)
                        time.sleep(2)
                        break

                else:
                    error_message = "WIFI NOT CONNECTED"
                    print("\033[91m" + error_message + "\033[0m")
            except KeyboardInterrupt:
                break
                sys.exit(0)
        return 0
    except KeyboardInterrupt:
        print("hardware exit")
        sys.exit(0)


# Process laser scan data here
def laser_check():
    global laser_data_received
    try:
        # Wait for a LaserScan message with a 10-second timeout
        message = rospy.wait_for_message("/scan", LaserScan, timeout=10)
        #rospy.loginfo("Received LaserScan message.")
        return True  # Laser data is being received
    except rospy.ROSException:
        rospy.logwarn("Timeout exceeded while waiting for a LaserScan message.")
        return False  # No data received within the timeout



######## Motor quick stop enable
def break_enable():

    global node, node1

    node.state = "QUICK STOP ACTIVE"
    time.sleep(0.3)
    node1.state = "QUICK STOP ACTIVE"
    time.sleep(0.3)

    return


# Function to log errors to error.txt file with date and time
def log_error(error_message):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open("/home/j1/error.txt", "a") as error_file:
        error_file.write(f"{timestamp} - {error_message}\n")



def main():
    try:
        global one_time_launch, should_exit
        hardware_checking_part()
        ethernet_hardware_check_one_time = 0
        ethernet_hardware_check = ethernet_hardware_checking(ip_to_check)

        if ethernet_hardware_check == 1:
            print("ETHERNET IS CONNECTED, READY TO LAUNCH LIDER FILES ")
            lidar_process = subprocess.call(AUTO_START_3D_LIDAR_PATH, shell=True)
            # lidar_process.wait()

        else:
            error_message = "CHECK THE ETHERNET HARDWARE CONNECTION"
            switch_case_and_publish(2)
            print("\033[91m" + error_message + "\033[0m")

        ######################

        rate = rospy.Rate(1)  # Adjust the rate according to your needs

        while True:
            try:
                wifi_check_status = wifi_status_checking()
                laser_data_received = laser_check()
                can_node_status = 2 #canopen_hardware_candump()

                if wifi_check_status == 1:

                    if laser_data_received:

                        if can_node_status >= 2 and laser_data_received:
                            if one_time_launch == 0:
                                one_time_launch = one_time_launch + 1
                                switch_case_and_publish(10)
                                print("\033[92m" "MOTOR DONE" + "\033[0m")
                                motor_process = subprocess.run(AUTO_START_MOTOR_DRIVER_PATH, shell=True)
                            else:
                                switch_case_and_publish(14)
                        else:
                            break_enable()
                            error_message = "CAN NODE CONNECTION ERROR"
                            print("\033[91m" + error_message + "\033[0m")
                            one_time_launch = 0
                            switch_case_and_publish(4)
                            break
                            
                        laser_data_not_receive = 0
                    else:
                        print("No Laser data .")
                        laser_data_not_receive+=1
                        if laser_data_not_receive > 2 :
                            switch_case_and_publish(13) 
                        if one_time_launch is not False and laser_data_not_receive == 2:
                            break_enable()
                            break 
                else:
                    custom_msg_pub = rospy.Publisher("/seirios_custom_msg",String,queue_size=10,latch=True,)
                    custom_msg_pub.publish(String(data="WIFI SIGNAL STRENTH LOW"))
                    error_message = "WIFI SIGNAL STRENTH LOW"
                    print("\033[91m" + error_message + "\033[0m")

            except Exception as e:
                if one_time_launch:
                    # canopen_parameters_config.reset()
                    print("need add canopen motor break")
                error_message = "communication error so need check the break switch"
                print("\033[91m" + error_message + "\033[0m")
                log_error(error_message)
                break

            except KeyboardInterrupt:
                print("\033[91mMain exit (Ctrl+C pressed)\033[0m")

    except KeyboardInterrupt:
        print("\033[91mMain exit (Ctrl+C pressed)\033[0m")

    finally:
        # Ensure that subprocesses are terminated if running
        try:
            # Clean up processes
            if lidar_process is not None:
                # lidar_process.terminate()
                # lidar_process.wait()  # Wait for the process to terminate
                print("sick_generic_laser: exit (line 221)")

            if motor_process is not None:
                # motor_process.terminate()
                # motor_process.wait()  # Wait for the process to terminate
                print("sick_generic_laser: exit (line 223)")
            sys.exit(0)

        except NameError:
            pass  # subprocess not started
        except Exception as e:
            print(f"Error terminating subprocess: {e}")


if __name__ == "__main__":
    main()
