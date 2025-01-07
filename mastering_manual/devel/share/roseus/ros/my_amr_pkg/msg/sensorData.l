;; Auto-generated. Do not edit!


(when (boundp 'my_amr_pkg::sensorData)
  (if (not (find-package "MY_AMR_PKG"))
    (make-package "MY_AMR_PKG"))
  (shadow 'sensorData (find-package "MY_AMR_PKG")))
(unless (find-package "MY_AMR_PKG::SENSORDATA")
  (make-package "MY_AMR_PKG::SENSORDATA"))

(in-package "ROS")
;;//! \htmlinclude sensorData.msg.html


(defclass my_amr_pkg::sensorData
  :super ros::object
  :slots (_temperature _humidity ))

(defmethod my_amr_pkg::sensorData
  (:init
   (&key
    ((:temperature __temperature) 0.0)
    ((:humidity __humidity) 0.0)
    )
   (send-super :init)
   (setq _temperature (float __temperature))
   (setq _humidity (float __humidity))
   self)
  (:temperature
   (&optional __temperature)
   (if __temperature (setq _temperature __temperature)) _temperature)
  (:humidity
   (&optional __humidity)
   (if __humidity (setq _humidity __humidity)) _humidity)
  (:serialization-length
   ()
   (+
    ;; float32 _temperature
    4
    ;; float32 _humidity
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _temperature
       (sys::poke _temperature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _humidity
       (sys::poke _humidity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _temperature
     (setq _temperature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _humidity
     (setq _humidity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get my_amr_pkg::sensorData :md5sum-) "e2e8758e18c44f444f3fa51a1c5be723")
(setf (get my_amr_pkg::sensorData :datatype-) "my_amr_pkg/sensorData")
(setf (get my_amr_pkg::sensorData :definition-)
      "float32 temperature 
float32 humidity 

")



(provide :my_amr_pkg/sensorData "e2e8758e18c44f444f3fa51a1c5be723")


