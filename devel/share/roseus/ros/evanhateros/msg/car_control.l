;; Auto-generated. Do not edit!


(when (boundp 'evanhateros::car_control)
  (if (not (find-package "EVANHATEROS"))
    (make-package "EVANHATEROS"))
  (shadow 'car_control (find-package "EVANHATEROS")))
(unless (find-package "EVANHATEROS::CAR_CONTROL")
  (make-package "EVANHATEROS::CAR_CONTROL"))

(in-package "ROS")
;;//! \htmlinclude car_control.msg.html


(defclass evanhateros::car_control
  :super ros::object
  :slots (_id _shutdown _velocity _rotation ))

(defmethod evanhateros::car_control
  (:init
   (&key
    ((:id __id) 0)
    ((:shutdown __shutdown) nil)
    ((:velocity __velocity) 0.0)
    ((:rotation __rotation) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _shutdown __shutdown)
   (setq _velocity (float __velocity))
   (setq _rotation (float __rotation))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:shutdown
   (&optional __shutdown)
   (if __shutdown (setq _shutdown __shutdown)) _shutdown)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:rotation
   (&optional __rotation)
   (if __rotation (setq _rotation __rotation)) _rotation)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; bool _shutdown
    1
    ;; float32 _velocity
    4
    ;; float32 _rotation
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; bool _shutdown
       (if _shutdown (write-byte -1 s) (write-byte 0 s))
     ;; float32 _velocity
       (sys::poke _velocity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rotation
       (sys::poke _rotation (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _shutdown
     (setq _shutdown (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _velocity
     (setq _velocity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rotation
     (setq _rotation (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get evanhateros::car_control :md5sum-) "5d2cc03a4196a5dac5509c8ff21f0969")
(setf (get evanhateros::car_control :datatype-) "evanhateros/car_control")
(setf (get evanhateros::car_control :definition-)
      "int32 id
bool shutdown
float32 velocity
float32 rotation

")



(provide :evanhateros/car_control "5d2cc03a4196a5dac5509c8ff21f0969")


