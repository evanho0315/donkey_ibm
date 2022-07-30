#!/usr/bin/env python

from __future__ import print_function

import threading

import rospy

from evanhateros.msg import car_control

import sys
from select import select

if sys.platform == 'win32':
    import msvcrt
else:
    import termios
    import tty


controlMsg = car_control

#todo modify msg
msg = """
Reading from the keyboard  and Publishing to Twist!
---------------------------
Moving around:
   u    i    o
   j    k    l
   m    ,    .
For Holonomic mode (strafing), hold down the shift key:
---------------------------
   U    I    O
   J    K    L
   M    <    >
t : up (+z)
b : down (-z)
anything else : stop
q/z : increase/decrease max velocitys by 10%
w/x : increase/decrease only linear velocity by 10%
e/c : increase/decrease only angular velocity by 10%
CTRL-C to quit
"""



class PublishThread(threading.Thread):
    def __init__(self, rate):
        super(PublishThread, self).__init__()
        self.publisher = rospy.Publisher('control_msg', controlMsg, queue_size = 10)
        self.velocity = 0.0
        self.rotation = 0.0
        self.condition = threading.Condition()
        self.shutdown=False

        # Set timeout to None if rate is 0 (causes new_message to wait forever
        # for new data to publish)
        if rate != 0.0:
            self.timeout = 1.0 / rate
        else:
            self.timeout = None

        self.start()

    def wait_for_subscribers(self):
        i = 0
        while not rospy.is_shutdown() and self.publisher.get_num_connections() == 0:
            if i == 4:
                print("Waiting for subscriber to connect to {}".format(self.publisher.name))
            rospy.sleep(0.5)
            i += 1
            i = i % 5
        if rospy.is_shutdown():
            raise Exception("Got shutdown request before subscribers connected")

    def update(self, velocity, rotation,shutdown):
        self.condition.acquire()
        self.velocity = velocity
        self.rotation = rotation
        self.shutdown = shutdown
        # Notify publish thread that we have a new message.
        self.condition.notify()
        self.condition.release()

    def stop(self):
        self.update(0, 0,True)
        self.join()

    def run(self):
        control_msg = controlMsg()

        while not self.shutdown:
            self.condition.acquire()
            # Wait for a new message or timeout.
            self.condition.wait(self.timeout)

            # Copy state into twist message.
            control_msg.velocity = self.velocity
            control_msg.rotation = self.rotation
            control_msg.shutdown= self.shutdown

            self.condition.release()

            # Publish.
            self.publisher.publish(control_msg)

        self.publisher.publish(control_msg)


def getKey(settings, timeout):
    if sys.platform == 'win32':
        # getwch() returns a string on Windows
        key = msvcrt.getwch()
    else:
        tty.setraw(sys.stdin.fileno())
        # sys.stdin.read() returns a string on Linux
        rlist, _, _ = select([sys.stdin], [], [], timeout)
        if rlist:
            key = sys.stdin.read(1)
        else:
            key = ''
        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
    return key

def saveTerminalSettings():
    if sys.platform == 'win32':
        return None
    return termios.tcgetattr(sys.stdin)

def restoreTerminalSettings(old_settings):
    if sys.platform == 'win32':
        return
    termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_settings)

def vels(velocity, rotation,shutdown):
    return "currently:\tvelocity %s\trotation %s %s" % (velocity,rotation,shutdown)

if __name__=="__main__":
    settings = saveTerminalSettings()

    rospy.init_node('teleop_twist_keyboard')

    velocity = 0
    rotation = 0
    shutdown=False
    repeat = 10 #=rate

    pub_thread = PublishThread(repeat)

    try:
        pub_thread.wait_for_subscribers()
        pub_thread.update(velocity, rotation,shutdown)

        print(msg)
        print(vels(velocity,rotation,shutdown))
        while(shutdown==False):
            key = getKey(settings, 0.5)
            if(key=='w'):
                velocity=round(min(velocity+0.05,1),2);
            elif(key=='s'):
                velocity = round(max(velocity-0.05, -1),2);
            elif (key == 'd'):
                rotation=round(max(rotation-0.05,-1),2);
            elif (key == 'a'):
                rotation = round(min(rotation+0.05, 1),2);
            elif(key=='q'):
                shutdown=True
            print(vels(velocity,rotation,shutdown))
            pub_thread.update(velocity, rotation,shutdown)

    except Exception as e:
        print(e)

    finally:
        pub_thread.stop()
        restoreTerminalSettings(settings)
