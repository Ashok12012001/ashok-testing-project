;; Auto-generated. Do not edit!


(when (boundp 'package::MyMessage)
  (if (not (find-package "PACKAGE"))
    (make-package "PACKAGE"))
  (shadow 'MyMessage (find-package "PACKAGE")))
(unless (find-package "PACKAGE::MYMESSAGE")
  (make-package "PACKAGE::MYMESSAGE"))

(in-package "ROS")
;;//! \htmlinclude MyMessage.msg.html


(defclass package::MyMessage
  :super ros::object
  :slots (_name _id _values ))

(defmethod package::MyMessage
  (:init
   (&key
    ((:name __name) "")
    ((:id __id) 0)
    ((:values __values) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _id (round __id))
   (setq _values __values)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:values
   (&optional __values)
   (if __values (setq _values __values)) _values)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; int32 _id
    4
    ;; float32[] _values
    (* 4    (length _values)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; int32 _id
       (write-long _id s)
     ;; float32[] _values
     (write-long (length _values) s)
     (dotimes (i (length _values))
       (sys::poke (elt _values i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _values
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _values (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _values i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get package::MyMessage :md5sum-) "b2c3af80379375679a75f5d26c24ce1b")
(setf (get package::MyMessage :datatype-) "package/MyMessage")
(setf (get package::MyMessage :definition-)
      "#MyMessage.msg

string name
int32 id
float32[] values

")



(provide :package/MyMessage "b2c3af80379375679a75f5d26c24ce1b")


