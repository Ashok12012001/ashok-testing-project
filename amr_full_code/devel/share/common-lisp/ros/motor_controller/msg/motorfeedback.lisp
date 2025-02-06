; Auto-generated. Do not edit!


(cl:in-package motor_controller-msg)


;//! \htmlinclude motorfeedback.msg.html

(cl:defclass <motorfeedback> (roslisp-msg-protocol:ros-message)
  ((rotates
    :reader rotates
    :initarg :rotates
    :type cl:float
    :initform 0.0)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (left_wheel_tickes
    :reader left_wheel_tickes
    :initarg :left_wheel_tickes
    :type cl:fixnum
    :initform 0)
   (right_wheel_tickes
    :reader right_wheel_tickes
    :initarg :right_wheel_tickes
    :type cl:fixnum
    :initform 0))
)

(cl:defclass motorfeedback (<motorfeedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <motorfeedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'motorfeedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name motor_controller-msg:<motorfeedback> is deprecated: use motor_controller-msg:motorfeedback instead.")))

(cl:ensure-generic-function 'rotates-val :lambda-list '(m))
(cl:defmethod rotates-val ((m <motorfeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_controller-msg:rotates-val is deprecated.  Use motor_controller-msg:rotates instead.")
  (rotates m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <motorfeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_controller-msg:speed-val is deprecated.  Use motor_controller-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'left_wheel_tickes-val :lambda-list '(m))
(cl:defmethod left_wheel_tickes-val ((m <motorfeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_controller-msg:left_wheel_tickes-val is deprecated.  Use motor_controller-msg:left_wheel_tickes instead.")
  (left_wheel_tickes m))

(cl:ensure-generic-function 'right_wheel_tickes-val :lambda-list '(m))
(cl:defmethod right_wheel_tickes-val ((m <motorfeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader motor_controller-msg:right_wheel_tickes-val is deprecated.  Use motor_controller-msg:right_wheel_tickes instead.")
  (right_wheel_tickes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <motorfeedback>) ostream)
  "Serializes a message object of type '<motorfeedback>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rotates))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'left_wheel_tickes)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'right_wheel_tickes)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <motorfeedback>) istream)
  "Deserializes a message object of type '<motorfeedback>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rotates) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'left_wheel_tickes) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'right_wheel_tickes) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<motorfeedback>)))
  "Returns string type for a message object of type '<motorfeedback>"
  "motor_controller/motorfeedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'motorfeedback)))
  "Returns string type for a message object of type 'motorfeedback"
  "motor_controller/motorfeedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<motorfeedback>)))
  "Returns md5sum for a message object of type '<motorfeedback>"
  "8dc03d848f56907041b4a626e48c93fa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'motorfeedback)))
  "Returns md5sum for a message object of type 'motorfeedback"
  "8dc03d848f56907041b4a626e48c93fa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<motorfeedback>)))
  "Returns full string definition for message of type '<motorfeedback>"
  (cl:format cl:nil "float32 rotates~%float32 speed~%int16 left_wheel_tickes~%int16 right_wheel_tickes~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'motorfeedback)))
  "Returns full string definition for message of type 'motorfeedback"
  (cl:format cl:nil "float32 rotates~%float32 speed~%int16 left_wheel_tickes~%int16 right_wheel_tickes~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <motorfeedback>))
  (cl:+ 0
     4
     4
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <motorfeedback>))
  "Converts a ROS message object to a list"
  (cl:list 'motorfeedback
    (cl:cons ':rotates (rotates msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':left_wheel_tickes (left_wheel_tickes msg))
    (cl:cons ':right_wheel_tickes (right_wheel_tickes msg))
))
