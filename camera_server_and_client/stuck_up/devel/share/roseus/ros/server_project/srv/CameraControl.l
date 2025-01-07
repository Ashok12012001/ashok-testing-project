;; Auto-generated. Do not edit!


(when (boundp 'server_project::CameraControl)
  (if (not (find-package "SERVER_PROJECT"))
    (make-package "SERVER_PROJECT"))
  (shadow 'CameraControl (find-package "SERVER_PROJECT")))
(unless (find-package "SERVER_PROJECT::CAMERACONTROL")
  (make-package "SERVER_PROJECT::CAMERACONTROL"))
(unless (find-package "SERVER_PROJECT::CAMERACONTROLREQUEST")
  (make-package "SERVER_PROJECT::CAMERACONTROLREQUEST"))
(unless (find-package "SERVER_PROJECT::CAMERACONTROLRESPONSE")
  (make-package "SERVER_PROJECT::CAMERACONTROLRESPONSE"))

(in-package "ROS")



(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass server_project::CameraControlRequest
  :super ros::object
  :slots (_angle ))

(defmethod server_project::CameraControlRequest
  (:init
   (&key
    ((:angle __angle) 0.0)
    )
   (send-super :init)
   (setq _angle (float __angle))
   self)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:serialization-length
   ()
   (+
    ;; float32 _angle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass server_project::CameraControlResponse
  :super ros::object
  :slots (_image ))

(defmethod server_project::CameraControlResponse
  (:init
   (&key
    ((:image __image) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _image __image)
   self)
  (:image
   (&rest __image)
   (if (keywordp (car __image))
       (send* _image __image)
     (progn
       (if __image (setq _image (car __image)))
       _image)))
  (:serialization-length
   ()
   (+
    ;; sensor_msgs/Image _image
    (send _image :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sensor_msgs/Image _image
       (send _image :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sensor_msgs/Image _image
     (send _image :deserialize buf ptr-) (incf ptr- (send _image :serialization-length))
   ;;
   self)
  )

(defclass server_project::CameraControl
  :super ros::object
  :slots ())

(setf (get server_project::CameraControl :md5sum-) "e5775eef75e8eba6b10486d9b6b6d54e")
(setf (get server_project::CameraControl :datatype-) "server_project/CameraControl")
(setf (get server_project::CameraControl :request) server_project::CameraControlRequest)
(setf (get server_project::CameraControl :response) server_project::CameraControlResponse)

(defmethod server_project::CameraControlRequest
  (:response () (instance server_project::CameraControlResponse :init)))

(setf (get server_project::CameraControlRequest :md5sum-) "e5775eef75e8eba6b10486d9b6b6d54e")
(setf (get server_project::CameraControlRequest :datatype-) "server_project/CameraControlRequest")
(setf (get server_project::CameraControlRequest :definition-)
      "# CameraControl.srv
float32 angle   # Requested camera angle
---
sensor_msgs/Image image   # Response: Pre-taken image



================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id
")

(setf (get server_project::CameraControlResponse :md5sum-) "e5775eef75e8eba6b10486d9b6b6d54e")
(setf (get server_project::CameraControlResponse :datatype-) "server_project/CameraControlResponse")
(setf (get server_project::CameraControlResponse :definition-)
      "# CameraControl.srv
float32 angle   # Requested camera angle
---
sensor_msgs/Image image   # Response: Pre-taken image



================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id
")



(provide :server_project/CameraControl "e5775eef75e8eba6b10486d9b6b6d54e")


