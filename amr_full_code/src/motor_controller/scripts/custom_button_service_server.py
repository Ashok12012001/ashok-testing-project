#!/usr/bin/env python3
import rospy
import threading
from movel_seirios_msgs.srv import StringTrigger, StringTriggerResponse # like setbool
from std_msgs.msg import Bool, UInt8

class ButtonServiceServer:

    def __init__(self):
        print('starting button_service_server node')
        self.node = rospy.init_node('button_service_server_node')

        self.service_start = rospy.Service('/external_process/start_waiting_for_button', StringTrigger, self.start_handler)
        self.service_stop = rospy.Service('/external_process/stop_waiting_for_button', StringTrigger, self.stop_handler)
        rospy.Subscriber("/button", Bool, self.button_callback)
        self.topic_process_cancel = rospy.Subscriber('/external_process/cancel_publish', Bool, self.handle_publish_cancel)
        
        self.button_pressed = False
        self.reset = False
        self.waiting = False
        # Event for synchronizing the button press
        self.button_pressed_event = threading.Event()

    def button_callback(self, data):
        if data.data and self.waiting:  # If the button is pressed, set the event
            rospy.loginfo("Button has been pressed!")
            self.button_pressed_event.set()
            self.button_pressed = True
        
    def start_handler(self, req):
        rospy.loginfo('Start waiting for button to be pressed')
        
        self.waiting = True
        self.button_pressed = False
        self.reset = False

        # Wait for the button to be pressed: blocking call.
        # It will update the self.reset and self.button_pressed variables
        self.button_pressed_event.wait()

        if self.reset:
            self.reset = False

            # Clear the event for the next service call
            self.button_pressed_event.clear()
            return StringTriggerResponse(success=False, message="Stop waiting for button")
        
        while not self.button_pressed:
            pass

        # Clear the event for the next service call
        self.button_pressed_event.clear()
        rospy.loginfo("Button has been pressed. Returning...")

        self.waiting = False
        start_msg = StringTriggerResponse() 
        start_msg.success = True
        start_msg.message = 'Button has been pressed!'

        return start_msg # return must be [success, message format]

    def stop_handler(self, req):
        rospy.loginfo("Stop waiting for button")

        stop_msg = StringTriggerResponse()
        stop_msg.success = False
        stop_msg.message = 'Stop'

        return stop_msg
    
    def handle_publish_cancel(self, req):
        rospy.loginfo("Received cancel %d", req.data)

        if req.data:
            print('executing cancel stuff') # replace print statement
            if self.waiting:
                rospy.loginfo("Cancelling waiting for button")
                self.reset = True
                self.button_pressed = False
                self.button_pressed_event.set()
                rospy.loginfo("Cancelled")
    
if __name__ == '__main__':
    button_service_server = ButtonServiceServer()

    rospy.spin()
