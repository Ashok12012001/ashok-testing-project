;; Auto-generated. Do not edit!


(when (boundp 'sick_safetyscanners::ScanPointMsg)
  (if (not (find-package "SICK_SAFETYSCANNERS"))
    (make-package "SICK_SAFETYSCANNERS"))
  (shadow 'ScanPointMsg (find-package "SICK_SAFETYSCANNERS")))
(unless (find-package "SICK_SAFETYSCANNERS::SCANPOINTMSG")
  (make-package "SICK_SAFETYSCANNERS::SCANPOINTMSG"))

(in-package "ROS")
;;//! \htmlinclude ScanPointMsg.msg.html


(defclass sick_safetyscanners::ScanPointMsg
  :super ros::object
  :slots (_angle _distance _reflectivity _valid _infinite _glare _reflector _contamination _contamination_warning ))

(defmethod sick_safetyscanners::ScanPointMsg
  (:init
   (&key
    ((:angle __angle) 0.0)
    ((:distance __distance) 0)
    ((:reflectivity __reflectivity) 0)
    ((:valid __valid) nil)
    ((:infinite __infinite) nil)
    ((:glare __glare) nil)
    ((:reflector __reflector) nil)
    ((:contamination __contamination) nil)
    ((:contamination_warning __contamination_warning) nil)
    )
   (send-super :init)
   (setq _angle (float __angle))
   (setq _distance (round __distance))
   (setq _reflectivity (round __reflectivity))
   (setq _valid __valid)
   (setq _infinite __infinite)
   (setq _glare __glare)
   (setq _reflector __reflector)
   (setq _contamination __contamination)
   (setq _contamination_warning __contamination_warning)
   self)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:reflectivity
   (&optional __reflectivity)
   (if __reflectivity (setq _reflectivity __reflectivity)) _reflectivity)
  (:valid
   (&optional (__valid :null))
   (if (not (eq __valid :null)) (setq _valid __valid)) _valid)
  (:infinite
   (&optional (__infinite :null))
   (if (not (eq __infinite :null)) (setq _infinite __infinite)) _infinite)
  (:glare
   (&optional (__glare :null))
   (if (not (eq __glare :null)) (setq _glare __glare)) _glare)
  (:reflector
   (&optional (__reflector :null))
   (if (not (eq __reflector :null)) (setq _reflector __reflector)) _reflector)
  (:contamination
   (&optional (__contamination :null))
   (if (not (eq __contamination :null)) (setq _contamination __contamination)) _contamination)
  (:contamination_warning
   (&optional (__contamination_warning :null))
   (if (not (eq __contamination_warning :null)) (setq _contamination_warning __contamination_warning)) _contamination_warning)
  (:serialization-length
   ()
   (+
    ;; float32 _angle
    4
    ;; uint16 _distance
    2
    ;; uint8 _reflectivity
    1
    ;; bool _valid
    1
    ;; bool _infinite
    1
    ;; bool _glare
    1
    ;; bool _reflector
    1
    ;; bool _contamination
    1
    ;; bool _contamination_warning
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint16 _distance
       (write-word _distance s)
     ;; uint8 _reflectivity
       (write-byte _reflectivity s)
     ;; bool _valid
       (if _valid (write-byte -1 s) (write-byte 0 s))
     ;; bool _infinite
       (if _infinite (write-byte -1 s) (write-byte 0 s))
     ;; bool _glare
       (if _glare (write-byte -1 s) (write-byte 0 s))
     ;; bool _reflector
       (if _reflector (write-byte -1 s) (write-byte 0 s))
     ;; bool _contamination
       (if _contamination (write-byte -1 s) (write-byte 0 s))
     ;; bool _contamination_warning
       (if _contamination_warning (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint16 _distance
     (setq _distance (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _reflectivity
     (setq _reflectivity (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _valid
     (setq _valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _infinite
     (setq _infinite (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _glare
     (setq _glare (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _reflector
     (setq _reflector (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _contamination
     (setq _contamination (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _contamination_warning
     (setq _contamination_warning (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get sick_safetyscanners::ScanPointMsg :md5sum-) "a01759b77f0ee80f572c218c25f9954e")
(setf (get sick_safetyscanners::ScanPointMsg :datatype-) "sick_safetyscanners/ScanPointMsg")
(setf (get sick_safetyscanners::ScanPointMsg :definition-)
      "float32 angle
uint16 distance
uint8 reflectivity
bool valid
bool infinite
bool glare
bool reflector
bool contamination
bool contamination_warning

")



(provide :sick_safetyscanners/ScanPointMsg "a01759b77f0ee80f572c218c25f9954e")


