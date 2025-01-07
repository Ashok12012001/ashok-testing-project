; Auto-generated. Do not edit!


(cl:in-package server_project-srv)


;//! \htmlinclude CameraControl-request.msg.html

(cl:defclass <CameraControl-request> (roslisp-msg-protocol:ros-message)
  ((angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass CameraControl-request (<CameraControl-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraControl-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraControl-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name server_project-srv:<CameraControl-request> is deprecated: use server_project-srv:CameraControl-request instead.")))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <CameraControl-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader server_project-srv:angle-val is deprecated.  Use server_project-srv:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraControl-request>) ostream)
  "Serializes a message object of type '<CameraControl-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraControl-request>) istream)
  "Deserializes a message object of type '<CameraControl-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraControl-request>)))
  "Returns string type for a service object of type '<CameraControl-request>"
  "server_project/CameraControlRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraControl-request)))
  "Returns string type for a service object of type 'CameraControl-request"
  "server_project/CameraControlRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraControl-request>)))
  "Returns md5sum for a message object of type '<CameraControl-request>"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraControl-request)))
  "Returns md5sum for a message object of type 'CameraControl-request"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraControl-request>)))
  "Returns full string definition for message of type '<CameraControl-request>"
  (cl:format cl:nil "# CameraControl.srv~%float32 angle   # Requested camera angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraControl-request)))
  "Returns full string definition for message of type 'CameraControl-request"
  (cl:format cl:nil "# CameraControl.srv~%float32 angle   # Requested camera angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraControl-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraControl-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraControl-request
    (cl:cons ':angle (angle msg))
))
;//! \htmlinclude CameraControl-response.msg.html

(cl:defclass <CameraControl-response> (roslisp-msg-protocol:ros-message)
  ((image
    :reader image
    :initarg :image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass CameraControl-response (<CameraControl-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraControl-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraControl-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name server_project-srv:<CameraControl-response> is deprecated: use server_project-srv:CameraControl-response instead.")))

(cl:ensure-generic-function 'image-val :lambda-list '(m))
(cl:defmethod image-val ((m <CameraControl-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader server_project-srv:image-val is deprecated.  Use server_project-srv:image instead.")
  (image m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraControl-response>) ostream)
  "Serializes a message object of type '<CameraControl-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraControl-response>) istream)
  "Deserializes a message object of type '<CameraControl-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraControl-response>)))
  "Returns string type for a service object of type '<CameraControl-response>"
  "server_project/CameraControlResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraControl-response)))
  "Returns string type for a service object of type 'CameraControl-response"
  "server_project/CameraControlResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraControl-response>)))
  "Returns md5sum for a message object of type '<CameraControl-response>"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraControl-response)))
  "Returns md5sum for a message object of type 'CameraControl-response"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraControl-response>)))
  "Returns full string definition for message of type '<CameraControl-response>"
  (cl:format cl:nil "sensor_msgs/Image image   # Response: Pre-taken image~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraControl-response)))
  "Returns full string definition for message of type 'CameraControl-response"
  (cl:format cl:nil "sensor_msgs/Image image   # Response: Pre-taken image~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraControl-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraControl-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraControl-response
    (cl:cons ':image (image msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CameraControl)))
  'CameraControl-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CameraControl)))
  'CameraControl-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraControl)))
  "Returns string type for a service object of type '<CameraControl>"
  "server_project/CameraControl")