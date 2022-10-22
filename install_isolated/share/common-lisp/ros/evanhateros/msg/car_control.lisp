; Auto-generated. Do not edit!


(cl:in-package evanhateros-msg)


;//! \htmlinclude car_control.msg.html

(cl:defclass <car_control> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (shutdown
    :reader shutdown
    :initarg :shutdown
    :type cl:boolean
    :initform cl:nil)
   (velocity
    :reader velocity
    :initarg :velocity
    :type cl:float
    :initform 0.0)
   (rotation
    :reader rotation
    :initarg :rotation
    :type cl:float
    :initform 0.0))
)

(cl:defclass car_control (<car_control>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <car_control>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'car_control)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name evanhateros-msg:<car_control> is deprecated: use evanhateros-msg:car_control instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <car_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader evanhateros-msg:id-val is deprecated.  Use evanhateros-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'shutdown-val :lambda-list '(m))
(cl:defmethod shutdown-val ((m <car_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader evanhateros-msg:shutdown-val is deprecated.  Use evanhateros-msg:shutdown instead.")
  (shutdown m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <car_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader evanhateros-msg:velocity-val is deprecated.  Use evanhateros-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'rotation-val :lambda-list '(m))
(cl:defmethod rotation-val ((m <car_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader evanhateros-msg:rotation-val is deprecated.  Use evanhateros-msg:rotation instead.")
  (rotation m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <car_control>) ostream)
  "Serializes a message object of type '<car_control>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'shutdown) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rotation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <car_control>) istream)
  "Deserializes a message object of type '<car_control>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'shutdown) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'velocity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rotation) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<car_control>)))
  "Returns string type for a message object of type '<car_control>"
  "evanhateros/car_control")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'car_control)))
  "Returns string type for a message object of type 'car_control"
  "evanhateros/car_control")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<car_control>)))
  "Returns md5sum for a message object of type '<car_control>"
  "5d2cc03a4196a5dac5509c8ff21f0969")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'car_control)))
  "Returns md5sum for a message object of type 'car_control"
  "5d2cc03a4196a5dac5509c8ff21f0969")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<car_control>)))
  "Returns full string definition for message of type '<car_control>"
  (cl:format cl:nil "int32 id~%bool shutdown~%float32 velocity~%float32 rotation~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'car_control)))
  "Returns full string definition for message of type 'car_control"
  (cl:format cl:nil "int32 id~%bool shutdown~%float32 velocity~%float32 rotation~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <car_control>))
  (cl:+ 0
     4
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <car_control>))
  "Converts a ROS message object to a list"
  (cl:list 'car_control
    (cl:cons ':id (id msg))
    (cl:cons ':shutdown (shutdown msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':rotation (rotation msg))
))
