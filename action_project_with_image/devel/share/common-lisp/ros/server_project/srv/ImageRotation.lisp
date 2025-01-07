; Auto-generated. Do not edit!


(cl:in-package server_project-srv)


;//! \htmlinclude ImageRotation-request.msg.html

(cl:defclass <ImageRotation-request> (roslisp-msg-protocol:ros-message)
  ((input_image
    :reader input_image
    :initarg :input_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (rotation_angle
    :reader rotation_angle
    :initarg :rotation_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass ImageRotation-request (<ImageRotation-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImageRotation-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImageRotation-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name server_project-srv:<ImageRotation-request> is deprecated: use server_project-srv:ImageRotation-request instead.")))

(cl:ensure-generic-function 'input_image-val :lambda-list '(m))
(cl:defmethod input_image-val ((m <ImageRotation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader server_project-srv:input_image-val is deprecated.  Use server_project-srv:input_image instead.")
  (input_image m))

(cl:ensure-generic-function 'rotation_angle-val :lambda-list '(m))
(cl:defmethod rotation_angle-val ((m <ImageRotation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader server_project-srv:rotation_angle-val is deprecated.  Use server_project-srv:rotation_angle instead.")
  (rotation_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImageRotation-request>) ostream)
  "Serializes a message object of type '<ImageRotation-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'input_image) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'rotation_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImageRotation-request>) istream)
  "Deserializes a message object of type '<ImageRotation-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'input_image) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rotation_angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImageRotation-request>)))
  "Returns string type for a service object of type '<ImageRotation-request>"
  "server_project/ImageRotationRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageRotation-request)))
  "Returns string type for a service object of type 'ImageRotation-request"
  "server_project/ImageRotationRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImageRotation-request>)))
  "Returns md5sum for a message object of type '<ImageRotation-request>"
  "9819b8903a9f0ce8015de560a2f07e7e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImageRotation-request)))
  "Returns md5sum for a message object of type 'ImageRotation-request"
  "9819b8903a9f0ce8015de560a2f07e7e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImageRotation-request>)))
  "Returns full string definition for message of type '<ImageRotation-request>"
  (cl:format cl:nil "sensor_msgs/Image input_image~%float64 rotation_angle~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImageRotation-request)))
  "Returns full string definition for message of type 'ImageRotation-request"
  (cl:format cl:nil "sensor_msgs/Image input_image~%float64 rotation_angle~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImageRotation-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'input_image))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImageRotation-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ImageRotation-request
    (cl:cons ':input_image (input_image msg))
    (cl:cons ':rotation_angle (rotation_angle msg))
))
;//! \htmlinclude ImageRotation-response.msg.html

(cl:defclass <ImageRotation-response> (roslisp-msg-protocol:ros-message)
  ((output_image
    :reader output_image
    :initarg :output_image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass ImageRotation-response (<ImageRotation-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImageRotation-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImageRotation-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name server_project-srv:<ImageRotation-response> is deprecated: use server_project-srv:ImageRotation-response instead.")))

(cl:ensure-generic-function 'output_image-val :lambda-list '(m))
(cl:defmethod output_image-val ((m <ImageRotation-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader server_project-srv:output_image-val is deprecated.  Use server_project-srv:output_image instead.")
  (output_image m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImageRotation-response>) ostream)
  "Serializes a message object of type '<ImageRotation-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'output_image) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImageRotation-response>) istream)
  "Deserializes a message object of type '<ImageRotation-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'output_image) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImageRotation-response>)))
  "Returns string type for a service object of type '<ImageRotation-response>"
  "server_project/ImageRotationResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageRotation-response)))
  "Returns string type for a service object of type 'ImageRotation-response"
  "server_project/ImageRotationResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImageRotation-response>)))
  "Returns md5sum for a message object of type '<ImageRotation-response>"
  "9819b8903a9f0ce8015de560a2f07e7e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImageRotation-response)))
  "Returns md5sum for a message object of type 'ImageRotation-response"
  "9819b8903a9f0ce8015de560a2f07e7e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImageRotation-response>)))
  "Returns full string definition for message of type '<ImageRotation-response>"
  (cl:format cl:nil "sensor_msgs/Image output_image~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImageRotation-response)))
  "Returns full string definition for message of type 'ImageRotation-response"
  (cl:format cl:nil "sensor_msgs/Image output_image~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImageRotation-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'output_image))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImageRotation-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ImageRotation-response
    (cl:cons ':output_image (output_image msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ImageRotation)))
  'ImageRotation-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ImageRotation)))
  'ImageRotation-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageRotation)))
  "Returns string type for a service object of type '<ImageRotation>"
  "server_project/ImageRotation")