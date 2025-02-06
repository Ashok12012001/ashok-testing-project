#!/usr/bin/python3
import subprocess
import time

def is_interface_present(interface_name):
    """Check if the specified network interface is present."""
    try:
        result = subprocess.run(['ifconfig'], capture_output=True, text=True)
        return interface_name in result.stdout
    except Exception as e:
        print(f"An error occurred while checking the interface: {e}")
        return False

def is_connected_to_ssid(interface_name, ssid_to_check):
    """Check if the specified network interface is connected to the given SSID."""
    try:
        result = subprocess.run(['iwgetid', '-r', interface_name], capture_output=True, text=True)
        connected_ssid = result.stdout.strip()
        return connected_ssid == ssid_to_check
    except Exception as e:
        print(f"An error occurred while checking the SSID: {e}")
        return False

def is_ros_running():
    """Check if ROS is running."""
    try:
        subprocess.check_output(["rosnode", "list"])
        return True
    except subprocess.CalledProcessError:
        return False

def run_script_on_disconnect():
    """Run a specific script when disconnection count exceeds the threshold."""
    script_path = "/home/j1/a_robot_ws/src/motor_controller/scripts/can_node_quick_stop_call.py"
    try:
        subprocess.run(["python3", script_path], check=True)
        print(f"Executed {script_path} due to multiple disconnections.")
    except FileNotFoundError:
        print(f"The file {script_path} was not found.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running {script_path}: {e}")
        
def systemd_script_on_disconnect():
    """Systemd Run a specific script when disconnection count exceeds the threshold."""
    script_path = "/home/j1/demo_ws/src/error_pkg/script/systemd_stop.py"
    try:
        subprocess.run(["python3", script_path], check=True)
        print(f"Executed {script_path}  systemd_stop.py due to multiple disconnections.")
    except FileNotFoundError:
        print(f"The file {script_path} was not found.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running {script_path}: {e}")

def main():
    interface_name = 'wlx90de80c45856'
    ssid_to_check = "Nibav Lifts_IGK"
    check_interval = 10  # Time in seconds between checks
    disconnect_count = 0  # Count consecutive network disconnections
    max_disconnect_count = 5  # Threshold for executing the disconnect script

    # Track previous statuses
    script_executed = False
    previously_connected = False  # Assume disconnected at the start
    time.sleep(30)
    print("going to the loop ")

    while True:
        # Current statuses
        current_network_connected = is_connected_to_ssid(interface_name, ssid_to_check)
        current_ros_running = is_ros_running()

        # Print current status
        if current_network_connected:
            print(f"Connected to SSID '{ssid_to_check}'.")
            if current_ros_running:
                print("ROS is running on the system.")
                disconnect_count = 0  # Reset disconnect count on successful connection and ROS running
            else:
                print("ROS is not running on the system.")
        else:
            print(f"Not connected to SSID '{ssid_to_check}'.")
            print("Cannot check ROS status because the network is not connected.")
            disconnect_count += 1  # Increment the disconnect counter

        # Handle reconnection and reset states
        if current_network_connected and not previously_connected:
            disconnect_count = 0
            script_executed = False  # Allow the script to run again after reconnection
            print("Reconnected to network, resetting script execution state.")
            
        # Execute a disconnect script if disconnection count exceeds threshold and script not executed
        if disconnect_count > max_disconnect_count and not script_executed:
            run_script_on_disconnect()
            time.sleep(1)
            systemd_script_on_disconnect()
            script_executed = True  # Ensure it only runs once per disconnection

        # Update previous connection status
        previously_connected = current_network_connected

        # Wait before the next check
        time.sleep(check_interval)

if __name__ == '__main__':
    main()
