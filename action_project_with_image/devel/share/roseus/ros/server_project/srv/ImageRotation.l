;; Auto-generated. Do not edit!


(when (boundp 'server_project::ImageRotation)
  (if (not (find-package "SERVER_PROJECT"))
    (make-package "SERVER_PROJECT"))
  (shadow 'ImageRotation (find-package "SERVER_PROJECT")))
(unless (find-package "SERVER_PROJECT::IMAGEROTATION")
  (make-package "SERVER_PROJECT::IMAGEROTATION"))
(unless (find-package "SERVER_PROJECT::IMAGEROTATIONREQUEST")
  (make-package "SERVER_PROJECT::IMAGEROTATIONREQUEST"))
(unless (find-package "SERVER_PROJECT::IMAGEROTATIONRESPONSE")
  (make-package "SERVER_PROJECT::IMAGEROTATIONRESPONSE"))

(in-package "ROS")

(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass server_project::ImageRotationRequest
  :super ros::object
  :slots (_input_image _rotation_angle ))

(defmethod server_project::ImageRotationRequest
  (:init
   (&key
    ((:input_image __input_image) (instance sensor_msgs::Image :init))
    ((:rotation_angle __rotation_angle) 0.0)
    )
   (send-super :init)
   (setq _input_image __input_image)
   (setq _rotation_angle (float __rotation_angle))
   self)
  (:input_image
   (&rest __input_image)
   (if (keywordp (car __input_image))
       (send* _input_image __input_image)
     (progn
       (if __input_image (setq _input_image (car __input_image)))
       _input_image)))
  (:rotation_angle
   (&optional __rotation_angle)
   (if __rotation_angle (setq _rotation_angle __rotation_angle)) _rotation_angle)
  (:serialization-length
   ()
   (+
    ;; sensor_msgs/Image _input_image
    (send _input_image :serialization-length)
    ;; float64 _rotation_angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sensor_msgs/Image _input_image
       (send _input_image :serialize s)
     ;; float64 _rotation_angle
       (sys::poke _rotation_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sensor_msgs/Image _input_image
     (send _input_image :deserialize buf ptr-) (incf ptr- (send _input_image :serialization-length))
   ;; float64 _rotation_angle
     (setq _rotation_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass server_project::ImageRotationResponse
  :super ros::object
  :slots (_output_image ))

(defmethod server_project::ImageRotationResponse
  (:init
   (&key
    ((:output_image __output_image) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _output_image __output_image)
   self)
  (:output_image
   (&rest __output_image)
   (if (keywordp (car __output_image))
       (send* _output_image __output_image)
     (progn
       (if __output_image (setq _output_image (car __output_image)))
       _output_image)))
  (:serialization-length
   ()
   (+
    ;; sensor_msgs/Image _output_image
    (send _output_image :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sensor_msgs/Image _output_image
       (send _output_image :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sensor_msgs/Image _output_image
     (send _output_image :deserialize buf ptr-) (incf ptr- (send _output_image :serialization-length))
   ;;
   self)
  )

(defclass server_project::ImageRotation
  :super ros::object
  :slots ())

(setf (get server_project::ImageRotation :md5sum-) "9819b8903a9f0ce8015de560a2f07e7e")
(setf (get server_project::ImageRotation :datatype-) "server_project/ImageRotation")
(setf (get server_project::ImageRotation :request) server_project::ImageRotationRequest)
(setf (get server_project::ImageRotation :response) server_project::ImageRotationResponse)

(defmethod server_project::ImageRotationRequest
  (:response () (instance server_project::ImageRotationResponse :init)))

(setf (get server_project::ImageRotationRequest :md5sum-) "9819b8903a9f0ce8015de560a2f07e7e")
(setf (get server_project::ImageRotationRequest :datatype-) "server_project/ImageRotationRequest")
(setf (get server_project::ImageRotationRequest :definition-)
      "sensor_msgs/Image input_image
float64 rotation_angle

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
---
sensor_msgs/Image output_image



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

(setf (get server_project::ImageRotationResponse :md5sum-) "9819b8903a9f0ce8015de560a2f07e7e")
(setf (get server_project::ImageRotationResponse :datatype-) "server_project/ImageRotationResponse")
(setf (get server_project::ImageRotationResponse :definition-)
      "sensor_msgs/Image input_image
float64 rotation_angle

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
---
sensor_msgs/Image output_image



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



(provide :server_project/ImageRotation "9819b8903a9f0ce8015de560a2f07e7e")


