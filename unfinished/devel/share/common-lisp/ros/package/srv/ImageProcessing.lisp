; Auto-generated. Do not edit!


(cl:in-package package-srv)


;//! \htmlinclude ImageProcessing-request.msg.html

(cl:defclass <ImageProcessing-request> (roslisp-msg-protocol:ros-message)
  ((angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass ImageProcessing-request (<ImageProcessing-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImageProcessing-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImageProcessing-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name package-srv:<ImageProcessing-request> is deprecated: use package-srv:ImageProcessing-request instead.")))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <ImageProcessing-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader package-srv:angle-val is deprecated.  Use package-srv:angle instead.")
  (angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImageProcessing-request>) ostream)
  "Serializes a message object of type '<ImageProcessing-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImageProcessing-request>) istream)
  "Deserializes a message object of type '<ImageProcessing-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImageProcessing-request>)))
  "Returns string type for a service object of type '<ImageProcessing-request>"
  "package/ImageProcessingRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageProcessing-request)))
  "Returns string type for a service object of type 'ImageProcessing-request"
  "package/ImageProcessingRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImageProcessing-request>)))
  "Returns md5sum for a message object of type '<ImageProcessing-request>"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImageProcessing-request)))
  "Returns md5sum for a message object of type 'ImageProcessing-request"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImageProcessing-request>)))
  "Returns full string definition for message of type '<ImageProcessing-request>"
  (cl:format cl:nil "# ImageProcessing.srv~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImageProcessing-request)))
  "Returns full string definition for message of type 'ImageProcessing-request"
  (cl:format cl:nil "# ImageProcessing.srv~%float32 angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImageProcessing-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImageProcessing-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ImageProcessing-request
    (cl:cons ':angle (angle msg))
))
;//! \htmlinclude ImageProcessing-response.msg.html

(cl:defclass <ImageProcessing-response> (roslisp-msg-protocol:ros-message)
  ((image
    :reader image
    :initarg :image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass ImageProcessing-response (<ImageProcessing-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImageProcessing-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImageProcessing-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name package-srv:<ImageProcessing-response> is deprecated: use package-srv:ImageProcessing-response instead.")))

(cl:ensure-generic-function 'image-val :lambda-list '(m))
(cl:defmethod image-val ((m <ImageProcessing-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader package-srv:image-val is deprecated.  Use package-srv:image instead.")
  (image m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImageProcessing-response>) ostream)
  "Serializes a message object of type '<ImageProcessing-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImageProcessing-response>) istream)
  "Deserializes a message object of type '<ImageProcessing-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImageProcessing-response>)))
  "Returns string type for a service object of type '<ImageProcessing-response>"
  "package/ImageProcessingResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageProcessing-response)))
  "Returns string type for a service object of type 'ImageProcessing-response"
  "package/ImageProcessingResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImageProcessing-response>)))
  "Returns md5sum for a message object of type '<ImageProcessing-response>"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImageProcessing-response)))
  "Returns md5sum for a message object of type 'ImageProcessing-response"
  "e5775eef75e8eba6b10486d9b6b6d54e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImageProcessing-response>)))
  "Returns full string definition for message of type '<ImageProcessing-response>"
  (cl:format cl:nil "sensor_msgs/Image image~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImageProcessing-response)))
  "Returns full string definition for message of type 'ImageProcessing-response"
  (cl:format cl:nil "sensor_msgs/Image image~%~%~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImageProcessing-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImageProcessing-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ImageProcessing-response
    (cl:cons ':image (image msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ImageProcessing)))
  'ImageProcessing-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ImageProcessing)))
  'ImageProcessing-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageProcessing)))
  "Returns string type for a service object of type '<ImageProcessing>"
  "package/ImageProcessing")