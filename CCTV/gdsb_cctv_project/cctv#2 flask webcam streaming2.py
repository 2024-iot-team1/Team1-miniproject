from flask import Flask, render_template, Response
import cv2
from picamera2 import Picamera2

app = Flask(__name__)

# 카메라 설정
width = 640
height = 480
middle = ((width/2),(height/2))

cam = Picamera2()
cam.configure(cam.create_video_configuration(main={'format': 'XRGB8888', 'size': (width,height)}))
cam.start()

def gen_frames():  
    while True:
        frame = cam.capture_array()
        
        ret, buffer = cv2.imencode('.jpg', frame)   # 프레임을 JPEG 포맷으로 인코딩
        frame = buffer.tobytes()
        yield (b'--frame\r\n'
                b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')  # 프레임을 바이트로 변환

@app.route('/')
def index():
    return render_template('index.html')    # 메인 페이지 렌더링

@app.route('/video_feed')
def video_feed():
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame') # 비디오 스트리밍

if __name__ == "__main__":  # 웹사이트를 호스팅항 접속자에게 보여주기 위한 부분
   app.run(host="192.168.5.3", port = "8080")
   # host는 현재 라즈베리파이의 내부 IP, port는 임의로 설정
   # 해당 내부 IP와 port를 포트포워딩 해두면 외부에서도 접속가능