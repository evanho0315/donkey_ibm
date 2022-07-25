#!/usr/bin/python3.6
import rospy
from evanhateros.msg import car_control
import time
from pynput.keyboard import Key, Listener
speed=0;
rotation=0;

def on_press(key):
    if hasattr(key, 'char'):
        global speed, rotation,shutdown
        if(key.char=='w'):
            speed=min(speed+0.05,1);
        if(key.char=='s'):
            speed = max(speed-0.05, -1);
        if (key.char == 'd'):
            rotation=max(rotation-0.05,-1);
        if (key.char == 'a'):
            rotation = min(rotation+0.05, 1);
        if(key.chr=='q'):
            shutdown=True
            listener.stop()





print("Test Start")
def talker():
    global listener, speed, rotation,shutdown
    shutdown=False
    speed = 0;
    rotation = 0;
    keyboard_listener = Listener(on_press=on_press)
    keyboard_listener.start()
    pub = rospy.Publisher('chatter', car_control, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        car_control=car_control()
        car_control.velocity=speed
        car_control.ratation=rotation
        car_control.shutdown=shutdown
        rospy.loginfo(car_control)
        pub.publish(car_control)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass

