;; Auto-generated. Do not edit!


(when (boundp 'sick_safetyscanners::FieldMsg)
  (if (not (find-package "SICK_SAFETYSCANNERS"))
    (make-package "SICK_SAFETYSCANNERS"))
  (shadow 'FieldMsg (find-package "SICK_SAFETYSCANNERS")))
(unless (find-package "SICK_SAFETYSCANNERS::FIELDMSG")
  (make-package "SICK_SAFETYSCANNERS::FIELDMSG"))

(in-package "ROS")
;;//! \htmlinclude FieldMsg.msg.html


(defclass sick_safetyscanners::FieldMsg
  :super ros::object
  :slots (_ranges _start_angle _angular_resolution _protective_field ))

(defmethod sick_safetyscanners::FieldMsg
  (:init
   (&key
    ((:ranges __ranges) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:start_angle __start_angle) 0.0)
    ((:angular_resolution __angular_resolution) 0.0)
    ((:protective_field __protective_field) nil)
    )
   (send-super :init)
   (setq _ranges __ranges)
   (setq _start_angle (float __start_angle))
   (setq _angular_resolution (float __angular_resolution))
   (setq _protective_field __protective_field)
   self)
  (:ranges
   (&optional __ranges)
   (if __ranges (setq _ranges __ranges)) _ranges)
  (:start_angle
   (&optional __start_angle)
   (if __start_angle (setq _start_angle __start_angle)) _start_angle)
  (:angular_resolution
   (&optional __angular_resolution)
   (if __angular_resolution (setq _angular_resolution __angular_resolution)) _angular_resolution)
  (:protective_field
   (&optional (__protective_field :null))
   (if (not (eq __protective_field :null)) (setq _protective_field __protective_field)) _protective_field)
  (:serialization-length
   ()
   (+
    ;; float32[] _ranges
    (* 4    (length _ranges)) 4
    ;; float32 _start_angle
    4
    ;; float32 _angular_resolution
    4
    ;; bool _protective_field
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _ranges
     (write-long (length _ranges) s)
     (dotimes (i (length _ranges))
       (sys::poke (elt _ranges i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _start_angle
       (sys::poke _start_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angular_resolution
       (sys::poke _angular_resolution (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _protective_field
       (if _protective_field (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _ranges
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ranges (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ranges i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _start_angle
     (setq _start_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angular_resolution
     (setq _angular_resolution (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _protective_field
     (setq _protective_field (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get sick_safetyscanners::FieldMsg :md5sum-) "d92cc93fdff8827129e1f6fd20b75f7e")
(setf (get sick_safetyscanners::FieldMsg :datatype-) "sick_safetyscanners/FieldMsg")
(setf (get sick_safetyscanners::FieldMsg :definition-)
      "float32[] ranges
float32 start_angle
float32 angular_resolution
bool protective_field

")



(provide :sick_safetyscanners/FieldMsg "d92cc93fdff8827129e1f6fd20b75f7e")


