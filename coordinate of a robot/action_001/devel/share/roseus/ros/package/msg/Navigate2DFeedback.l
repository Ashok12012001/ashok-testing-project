;; Auto-generated. Do not edit!


(when (boundp 'package::Navigate2DFeedback)
  (if (not (find-package "PACKAGE"))
    (make-package "PACKAGE"))
  (shadow 'Navigate2DFeedback (find-package "PACKAGE")))
(unless (find-package "PACKAGE::NAVIGATE2DFEEDBACK")
  (make-package "PACKAGE::NAVIGATE2DFEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude Navigate2DFeedback.msg.html


(defclass package::Navigate2DFeedback
  :super ros::object
  :slots (_distance_to_point ))

(defmethod package::Navigate2DFeedback
  (:init
   (&key
    ((:distance_to_point __distance_to_point) 0.0)
    )
   (send-super :init)
   (setq _distance_to_point (float __distance_to_point))
   self)
  (:distance_to_point
   (&optional __distance_to_point)
   (if __distance_to_point (setq _distance_to_point __distance_to_point)) _distance_to_point)
  (:serialization-length
   ()
   (+
    ;; float32 _distance_to_point
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _distance_to_point
       (sys::poke _distance_to_point (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _distance_to_point
     (setq _distance_to_point (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get package::Navigate2DFeedback :md5sum-) "c9bb2981926f85b65fe1e8c193c945d5")
(setf (get package::Navigate2DFeedback :datatype-) "package/Navigate2DFeedback")
(setf (get package::Navigate2DFeedback :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
float32 distance_to_point

")



(provide :package/Navigate2DFeedback "c9bb2981926f85b65fe1e8c193c945d5")


