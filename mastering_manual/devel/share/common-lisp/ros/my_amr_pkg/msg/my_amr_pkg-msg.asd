
(cl:in-package :asdf)

(defsystem "my_amr_pkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "sensorData" :depends-on ("_package_sensorData"))
    (:file "_package_sensorData" :depends-on ("_package"))
  ))