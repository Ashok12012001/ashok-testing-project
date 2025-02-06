#!/usr/bin/env python3

import rospy
import requests
import json
from movel_seirios_msgs.msg import UnifiedTaskActionGoal

class RESTHandler:
    def __init__(self, base_url, username, password):
        self.base_url = base_url
        self.username = username
        self.password = password
        self.token = None
        self.headers = None
        self.authenticate()

    def authenticate(self):
        """Authenticate and retrieve token."""
        url = f'{self.base_url}/user/token'
        headers = {
            'accept': 'application/json',
            'Content-Type': 'application/json',
        }
        payload = {
            "username": self.username,
            "password": self.password,
        }
        response = requests.post(url, data=json.dumps(payload), headers=headers)
        response.raise_for_status()  # Raise an exception if the request fails
        self.token = response.json().get('token')
        self.headers = {
            'Content-Type': 'application/json',
            'authorization': self.token,  # Use the token here
        }

    def queue_pause(self):
        """Trigger the pause action via REST API."""
        url = f"{self.base_url}/queue/pause"
        response = requests.post(url, headers=self.headers)
        return self._handle_response(response)

    def queue_resume(self):
        """Trigger the resume action via REST API."""
        url = f"{self.base_url}/queue/resume"
        response = requests.post(url, headers=self.headers)
        return self._handle_response(response)

    def _handle_response(self, response):
        """Handle the REST API response."""
        if response.status_code in [200, 204]:
            try:
                return response.json()
            except ValueError:
                # If response is not JSON, return the text content
                return response.text
        else:
            response.raise_for_status()

def callback(msg):
    # Check if any task has type == 3
    for task in msg.goal.task_list.tasks:
        if task.type == 3:
            rospy.loginfo("Task with type 3 received. Triggering pause and resume via REST API...")
            
            try:
                # Trigger pause
                rest_handler.queue_pause()
                rospy.loginfo("Pause triggered via REST API.")
                
                rospy.sleep(1)  # Wait for 1 second
                
                # Trigger resume
                rest_handler.queue_resume()
                rospy.loginfo("Resume triggered via REST API.")
            except requests.RequestException as e:
                rospy.logerr(f"Failed to trigger pause/resume via REST API: {e}")
            
            break  # Exit loop after handling type 3 task

def listener():
    rospy.init_node('universal_handler_auto_pause_resume_node', anonymous=True)
    
    # Subscribe to /universal_handler/goal
    rospy.Subscriber('/universal_handler/goal', UnifiedTaskActionGoal, callback)
    
    rospy.spin()

if __name__ == '__main__':
    # Configure REST API handler
    base_url = "http://localhost:8000/api/v1" 
    username = "admin"
    password = "admin"
    rest_handler = RESTHandler(base_url, username, password)
    
    try:
        listener()
    except rospy.ROSInterruptException:
        pass

