from flask import Flask, render_template, Response
from PIL import ImageFont, ImageDraw, Image
import datetime
import cv2
import numpy as np


app = Flask(__name__)
capture = cv2.VideoCapture(-1)
capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
font = ImageFont.truetype('fonts/SCDream6.otf', 20)

def gen_frames():  
    while True:
        now = datetime.datetime.now()
        nowDatetime = now.strftime('%Y-%m-%d %H:%M:%S')
        ref, frame = capture.read()  
        if not ref:
            break
        else:
            frame = Image.fromarray(frame)    
            draw = ImageDraw.Draw(frame)    
            # xy는 텍스트 시작위치, text는 출력할 문자열, font는 글꼴, fill은 글자색(파랑,초록,빨강)   
            draw.text(xy=(10, 15),  text="Live CCTV"+nowDatetime, font=font, fill=(255, 255, 255))
            frame = np.array(frame)
            ref, buffer = cv2.imencode('.jpg', frame)            
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')  

@app.route('/')
def index():
    return render_template('index4#2.html')             

@app.route('/video_feed')
def video_feed():
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == "__main__":  
   app.run(host="192.168.1.116", port = "18001")
      