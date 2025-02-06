#!/usr/bin/env python3

import subprocess
import time

# Start the ROS launch file
# Wait for 30 seconds
time.sleep(3)
process = subprocess.Popen(
    ["roslaunch", "sick_safetyscanners", "sick_safetyscanners.launch"]
)
# process = subprocess.Popen(['roslaunch', 'sick_scan_xd', 'sick_multiscan.launch'])
time.sleep(5)
