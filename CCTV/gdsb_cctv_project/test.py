import cv2
import numpy as np
from picamera2 import Picamera2

width = 640
height = 480
middle = ((width/2),(height/2))

SCALE = 1
COLOR =(255,255,255)
THINKNESS = 1

cam = Picamera2()
cam.configure(cam.create_video_configuration(main={'format': 'XRGB8888', 'size': (width,height)}))
cam.start()

while True:
    frame = cam.capture_array()
    # cv2.circle(frame, middle, 10, (255, 0, 255,), -1)
    temp = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    cv2.putText(img=temp, text="Simple Text",
                org=(20,50), fontFace=cv2.FONT_HERSHEY_SIMPLEX, 
                fontScale=SCALE, color=COLOR, thickness=THINKNESS)

    cv2.imshow('video', temp)
    if cv2.waitKey(1) == ord('q'):
        break

cam.release()
cv2.destroyAllWindows()

