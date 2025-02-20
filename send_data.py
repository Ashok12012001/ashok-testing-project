import serial
import time

ser = serial.Serial('/dev/ttyUSB0', 115200, timeout=1)  # Change port as needed
time.sleep(2)  # Allow ESP32 to initialize

while True:
    if ser.in_waiting > 0:
        data = ser.readline().decode('utf-8').strip()  # Read & decode
        print(data)
