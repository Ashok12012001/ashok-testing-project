
(cl:in-package :asdf)

(defsystem "server_project-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "ImageRotation" :depends-on ("_package_ImageRotation"))
    (:file "_package_ImageRotation" :depends-on ("_package"))
  ))