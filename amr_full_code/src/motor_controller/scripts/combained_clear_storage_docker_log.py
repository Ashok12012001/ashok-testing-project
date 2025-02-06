#!/usr/bin/env python3

import os
import subprocess
import re
import rospy
from std_msgs.msg import String

def get_docker_memory_usage():
    try:
        result = subprocess.run(['docker', 'system', 'df'], 
                                capture_output=True, text=True, check=True)
        output = result.stdout
        lines = output.splitlines()
        usage_info = "\n".join(lines[1:])  # Skip the header line
        return usage_info
    except subprocess.CalledProcessError as e:
        rospy.logerr(f"Error retrieving Docker memory usage: {e}")
        return "Error retrieving Docker memory usage."

def get_directory_size(directory):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(directory):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            if os.path.exists(fp):
                total_size += os.path.getsize(fp)
    return total_size

def clear_directory(directory):
    try:
        for dirpath, dirnames, filenames in os.walk(directory):
            for f in filenames:
                fp = os.path.join(dirpath, f)
                if os.path.exists(fp):
                    os.remove(fp)
        return True
    except Exception as e:
        return False

def bytes_to_gb(size_in_bytes):
    return size_in_bytes / (1024 ** 3)

def get_journalctl_size():
    journal_size_gb = 0.0
    try:
        journalctl_output = subprocess.check_output(['journalctl', '--disk-usage']).decode('utf-8').strip()
        match = re.search(r'(\d+(\.\d+)?)G', journalctl_output)
        if match:
            journal_size_gb = float(match.group(1))
    except subprocess.CalledProcessError:
        pass
    except Exception:
        pass
    return journal_size_gb

def clear_journalctl_logs():
    try:
        subprocess.check_call(['sudo', 'journalctl', '--rotate'])
        subprocess.check_call(['sudo', 'journalctl', '--vacuum-time=1s'])
        return True
    except subprocess.CalledProcessError:
        return False

def main():
    rospy.init_node('combained_docker_ros_cleaner', anonymous=True)
    pub = rospy.Publisher('seirios_custom_msg', String, queue_size=10)
    
    rospy.loginfo("CLEANING DOCKER VOLUMES AND ROS LOGS...")

    # Docker Volume Cleaning
    ps = subprocess.Popen(
        "docker volume ls | awk '{print $2}'",
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    )
    stdout, stderr = ps.communicate()
    out = stdout.decode("utf-8")
    to_delete = [line for line in out.split("\n") if len(line) == 64]
    if len(to_delete) > 0: 
        rospy.loginfo(f"DELETING {len(to_delete)} VOLUMES")
        ps = subprocess.Popen(f"docker volume rm {' '.join(to_delete)}", shell=True)
        ps.wait()
    
    # Get Docker Memory Usage
    docker_memory_usage = get_docker_memory_usage()

    # ROS Log and Journalctl Cleaning
    ros_log_dir = os.path.expanduser('~/.ros/log')
    ros_cache_dir = os.path.expanduser('~/.ros')

    # Get the initial size of the ROS log and cache directories, and journalctl logs
    ros_log_size_before = get_directory_size(ros_log_dir)
    ros_cache_size_before = get_directory_size(ros_cache_dir)
    journal_size_before = get_journalctl_size()

    # Convert sizes to GB
    ros_log_size_gb_before = bytes_to_gb(ros_log_size_before)
    ros_cache_size_gb_before = bytes_to_gb(ros_cache_size_before)

    # Publish the sizes before clearing
    message_before = (f"BEFORE CLEARING:\n"
                      f"ROS Log Size: {ros_log_size_gb_before:.2f} GB\n"
                      f"ROS Cache Size: {ros_cache_size_gb_before:.2f} GB\n"
                      f"Journalctl Log Size: {journal_size_before:.2f} GB\n"
                      f"Docker Memory Usage:\n{docker_memory_usage}\n")
    
    pub.publish(String(data=message_before))
    rospy.loginfo("Published sizes before clearing.")
    
    # Clear the ROS log, cache directories, and journalctl logs
    clear_directory(ros_log_dir)
    clear_directory(ros_cache_dir)
    clear_journalctl_logs()

    # Recalculate sizes after clearing
    ros_log_size_after = get_directory_size(ros_log_dir)
    ros_cache_size_after = get_directory_size(ros_cache_dir)
    journal_size_after = get_journalctl_size()

    # Convert sizes to GB
    ros_log_size_gb_after = bytes_to_gb(ros_log_size_after)
    ros_cache_size_gb_after = bytes_to_gb(ros_cache_size_after)

    # Publish the sizes after clearing
    message_after = (f"AFTER CLEARING:\n"
                     f"ROS Log Size: {ros_log_size_gb_after:.2f} GB\n"
                     f"ROS Cache Size: {ros_cache_size_gb_after:.2f} GB\n"
                     f"Journalctl Log Size: {journal_size_after:.2f} GB\n"
                     f"Docker Memory Usage:\n{docker_memory_usage}\n")

    pub.publish(String(data=message_after))
    rospy.loginfo("Published sizes after clearing.")

if __name__ == "__main__":
    try:
        main()
    except rospy.ROSInterruptException:
        pass
