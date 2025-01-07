
(cl:in-package :asdf)

(defsystem "asho-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "ActionNameAction" :depends-on ("_package_ActionNameAction"))
    (:file "_package_ActionNameAction" :depends-on ("_package"))
    (:file "ActionNameActionFeedback" :depends-on ("_package_ActionNameActionFeedback"))
    (:file "_package_ActionNameActionFeedback" :depends-on ("_package"))
    (:file "ActionNameActionGoal" :depends-on ("_package_ActionNameActionGoal"))
    (:file "_package_ActionNameActionGoal" :depends-on ("_package"))
    (:file "ActionNameActionResult" :depends-on ("_package_ActionNameActionResult"))
    (:file "_package_ActionNameActionResult" :depends-on ("_package"))
    (:file "ActionNameFeedback" :depends-on ("_package_ActionNameFeedback"))
    (:file "_package_ActionNameFeedback" :depends-on ("_package"))
    (:file "ActionNameGoal" :depends-on ("_package_ActionNameGoal"))
    (:file "_package_ActionNameGoal" :depends-on ("_package"))
    (:file "ActionNameResult" :depends-on ("_package_ActionNameResult"))
    (:file "_package_ActionNameResult" :depends-on ("_package"))
  ))