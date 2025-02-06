;; Auto-generated. Do not edit!


(when (boundp 'motor_controller::motorfeedback)
  (if (not (find-package "MOTOR_CONTROLLER"))
    (make-package "MOTOR_CONTROLLER"))
  (shadow 'motorfeedback (find-package "MOTOR_CONTROLLER")))
(unless (find-package "MOTOR_CONTROLLER::MOTORFEEDBACK")
  (make-package "MOTOR_CONTROLLER::MOTORFEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude motorfeedback.msg.html


(defclass motor_controller::motorfeedback
  :super ros::object
  :slots (_rotates _speed _left_wheel_tickes _right_wheel_tickes ))

(defmethod motor_controller::motorfeedback
  (:init
   (&key
    ((:rotates __rotates) 0.0)
    ((:speed __speed) 0.0)
    ((:left_wheel_tickes __left_wheel_tickes) 0)
    ((:right_wheel_tickes __right_wheel_tickes) 0)
    )
   (send-super :init)
   (setq _rotates (float __rotates))
   (setq _speed (float __speed))
   (setq _left_wheel_tickes (round __left_wheel_tickes))
   (setq _right_wheel_tickes (round __right_wheel_tickes))
   self)
  (:rotates
   (&optional __rotates)
   (if __rotates (setq _rotates __rotates)) _rotates)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:left_wheel_tickes
   (&optional __left_wheel_tickes)
   (if __left_wheel_tickes (setq _left_wheel_tickes __left_wheel_tickes)) _left_wheel_tickes)
  (:right_wheel_tickes
   (&optional __right_wheel_tickes)
   (if __right_wheel_tickes (setq _right_wheel_tickes __right_wheel_tickes)) _right_wheel_tickes)
  (:serialization-length
   ()
   (+
    ;; float32 _rotates
    4
    ;; float32 _speed
    4
    ;; int16 _left_wheel_tickes
    2
    ;; int16 _right_wheel_tickes
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _rotates
       (sys::poke _rotates (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int16 _left_wheel_tickes
       (write-word _left_wheel_tickes s)
     ;; int16 _right_wheel_tickes
       (write-word _right_wheel_tickes s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _rotates
     (setq _rotates (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int16 _left_wheel_tickes
     (setq _left_wheel_tickes (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _right_wheel_tickes
     (setq _right_wheel_tickes (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get motor_controller::motorfeedback :md5sum-) "8dc03d848f56907041b4a626e48c93fa")
(setf (get motor_controller::motorfeedback :datatype-) "motor_controller/motorfeedback")
(setf (get motor_controller::motorfeedback :definition-)
      "float32 rotates
float32 speed
int16 left_wheel_tickes
int16 right_wheel_tickes


")



(provide :motor_controller/motorfeedback "8dc03d848f56907041b4a626e48c93fa")


