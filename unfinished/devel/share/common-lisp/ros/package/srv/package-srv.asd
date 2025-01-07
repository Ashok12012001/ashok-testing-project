
(cl:in-package :asdf)

(defsystem "package-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "ImageProcessing" :depends-on ("_package_ImageProcessing"))
    (:file "_package_ImageProcessing" :depends-on ("_package"))
  ))