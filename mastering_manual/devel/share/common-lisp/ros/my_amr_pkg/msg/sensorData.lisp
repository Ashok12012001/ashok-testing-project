; Auto-generated. Do not edit!


(cl:in-package my_amr_pkg-msg)


;//! \htmlinclude sensorData.msg.html

(cl:defclass <sensorData> (roslisp-msg-protocol:ros-message)
  ((temperature
    :reader temperature
    :initarg :temperature
    :type cl:float
    :initform 0.0)
   (humidity
    :reader humidity
    :initarg :humidity
    :type cl:float
    :initform 0.0))
)

(cl:defclass sensorData (<sensorData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sensorData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sensorData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name my_amr_pkg-msg:<sensorData> is deprecated: use my_amr_pkg-msg:sensorData instead.")))

(cl:ensure-generic-function 'temperature-val :lambda-list '(m))
(cl:defmethod temperature-val ((m <sensorData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader my_amr_pkg-msg:temperature-val is deprecated.  Use my_amr_pkg-msg:temperature instead.")
  (temperature m))

(cl:ensure-generic-function 'humidity-val :lambda-list '(m))
(cl:defmethod humidity-val ((m <sensorData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader my_amr_pkg-msg:humidity-val is deprecated.  Use my_amr_pkg-msg:humidity instead.")
  (humidity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sensorData>) ostream)
  "Serializes a message object of type '<sensorData>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'humidity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sensorData>) istream)
  "Deserializes a message object of type '<sensorData>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'temperature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'humidity) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sensorData>)))
  "Returns string type for a message object of type '<sensorData>"
  "my_amr_pkg/sensorData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sensorData)))
  "Returns string type for a message object of type 'sensorData"
  "my_amr_pkg/sensorData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sensorData>)))
  "Returns md5sum for a message object of type '<sensorData>"
  "e2e8758e18c44f444f3fa51a1c5be723")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sensorData)))
  "Returns md5sum for a message object of type 'sensorData"
  "e2e8758e18c44f444f3fa51a1c5be723")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sensorData>)))
  "Returns full string definition for message of type '<sensorData>"
  (cl:format cl:nil "float32 temperature ~%float32 humidity ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sensorData)))
  "Returns full string definition for message of type 'sensorData"
  (cl:format cl:nil "float32 temperature ~%float32 humidity ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sensorData>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sensorData>))
  "Converts a ROS message object to a list"
  (cl:list 'sensorData
    (cl:cons ':temperature (temperature msg))
    (cl:cons ':humidity (humidity msg))
))
