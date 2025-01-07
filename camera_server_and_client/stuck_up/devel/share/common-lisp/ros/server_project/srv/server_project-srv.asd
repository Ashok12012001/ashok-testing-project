
(cl:in-package :asdf)

(defsystem "server_project-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "CameraControl" :depends-on ("_package_CameraControl"))
    (:file "_package_CameraControl" :depends-on ("_package"))
  ))