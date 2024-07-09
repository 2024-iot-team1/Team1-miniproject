from flask import Flask, render_template, Response
import cv2
from picamera2 import Picamera2
from PIL import ImageDraw, Image
import numpy as np
import datetime

app = Flask(__name__)

width = 640
height = 480
middle = ((width/2),(height/2))

SCALE = 1
COLOR =(255,255,255)
THINKNESS = 1

cam = Picamera2()
cam.configure(cam.create_video_configuration(main={'format': 'XRGB8888', 'size': (width,height)}))
cam.start()

def gen_frames():  
    while True:
        frame = cam.capture_array()
        now = datetime.datetime.now()
        nowDatetime = now.strftime('%Y-%m-%d %H:%M:%S')

        currDate = 'Current Time :' + nowDatetime

        cv2.putText(img=frame, text=currDate,
                org=(20,50), fontFace=cv2.FONT_HERSHEY_SIMPLEX, 
                fontScale=SCALE, color=COLOR, thickness=THINKNESS)
        
        # frame_pil = Image.fromarray(frame)   
        # draw = ImageDraw.Draw(frame_pil)    
        # # xy는 텍스트 시작위치, text는 출력할 문자열, font는 글꼴, fill은 글자색(파랑,초록,빨강)
        # draw.text((10, 15),  text="현 시각: " + nowDatetime, fill=(255, 255, 255))
        # frame = np.array(frame_pil)
        
        ref, buffer = cv2.imencode('.jpg', frame)            
        frame = buffer.tobytes()
        yield (b'--frame\r\n'
                b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')  # 그림 파일들을 쌓아두고 호출을 기다림

@app.route('/')
def index():
    return render_template('index.html')             # index4#2.html의 형식대로 웹페이지를 보여줌

@app.route('/video_feed')
def video_feed():
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame') # 그림파일들을 쌓아서 보여줌

if __name__ == "__main__":  # 웹사이트를 호스팅항 접속자에게 보여주기 위한 부분
   app.run(host="192.168.5.3", port = "8081")
   # host는 현재 라즈베리파이의 내부 IP, port는 임의로 설정
   # 해당 내부 IP와 port를 포트포워딩 해두면 외부에서도 접속가능