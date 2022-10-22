
(cl:in-package :asdf)

(defsystem "evanhateros-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "car_control" :depends-on ("_package_car_control"))
    (:file "_package_car_control" :depends-on ("_package"))
  ))