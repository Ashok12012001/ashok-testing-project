
(cl:in-package :asdf)

(defsystem "motor_controller-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "motorfeedback" :depends-on ("_package_motorfeedback"))
    (:file "_package_motorfeedback" :depends-on ("_package"))
  ))