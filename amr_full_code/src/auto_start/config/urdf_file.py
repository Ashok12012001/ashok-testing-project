#!/usr/bin/env python3

import subprocess
import time
# Start the ROS launch file
# Wait for 30 seconds
time.sleep(3)
process = subprocess.Popen(["roslaunch", "demopurposeurdf", "display.launch"])
time.sleep(3)
