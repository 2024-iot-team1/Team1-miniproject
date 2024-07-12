# Team1-miniproject
부경대학교 2024 IoT 개발자 과정 1조 미니프로젝트 : 스마트 물류 시스템

## 👷 팀원 소개
<table>
    <tbody>
        <tr>
            <td align="center"><b>팀장 : 고병학</b></td>
            <td align="center"><b>부팀장 : 유왕권</b></td>
            <td align="center"><b>팀원 : 김동주</b></td>
            <td align="center"><b>팀원 : 황지환</b></td>
            <td align="center"><b>팀원 : 홍승욱</b></td>
        <tr/>
            <td align="center"><a href="https://github.com/znah54/"><b>@znah54</b></a></td>
            <td align="center"><a href="https://github.com/YooWangGwon"><b>@YooWangGwon</b></a></td>
            <td align="center"><a href="https://github.com/kimdongju1"><b>@kimdongju1</b></a></td>
            <td align="center"><a href="https://github.com/Hwangji99"><b>@Hwangji99</b></a></td>
            <td align="center"><a href="https://github.com/sungouk1457"><b>@sungouk1457</b></a></td>
        <tr/>
            <td align="center">주문관리 화면 구현 보조</td>
            <td align="center">DB 구축</td>
            <td align="center">CCTV 화면 출력용<br>서버 구축</td>
            <td align="center">로그인 화면 구현</td>
            <td align="center">스마트팩토리 키트 조립</td>
        <tr/>
            <td align="center">재고관리 화면 구현 보조</td>
            <td align="center">아두이노<br>자동 분류 시스템 구현</td>
            <td align="center">더미 데이터 세팅</td>
            <td align="center">메인화면 프레임 구현</td>
            <td align="center">공장 프레임 제작</td>
        <tr/>
            <td align="center"></td>
            <td align="center">아두이노 실내 환경<br>모니터링 시스템 구현</td>
            <td align="center">WPF CCTV 화면 출력</td>
            <td align="center">주문관리<br>화면 및 기능 구현</td>
            <td align="center">재고관리<br>화면 및 기능 구현</td>
        <tr/>
            <td align="center"></td>
            <td align="center">아두이노와 WPF<br>블루투스 통신 연결</td>
            <td align="center">공장 프레임 제작 보조</td>
            <td align="center">주문&배송<br>데이터베이스 관리</td>
            <td align="center">재고&상품<br>데이터베이스 관리</td>
        <tr/>
            <td align="center"></td>
            <td align="center">공정 모니터링<br>화면 및 기능 구현</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
        </tr>
            <td align="center"></td>
            <td align="center">설정 조정<br>화면 및 기능 구현</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
        </tr>        
            <td align="center"></td>
            <td align="center">공정 처리<br>데이터베이스 관리</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
        </tr>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center"></td>
        </tr> 
    </tbody>
</table>

## 🌐 개발 환경
- Language
  
    <img src="https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white"><img src="https://img.shields.io/badge/-Arduino-00979D?style=for-the-badge&logo=Arduino&logoColor=white"><img src="https://img.shields.io/badge/Microsoft_SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white">

- IDE
  
    <img src = "https://img.shields.io/badge/Visual_Studio-5C2D91?style=for-the-badge&logo=visual%20studio&logoColor=white"><img src = "https://img.shields.io/badge/Arduino_IDE-00979D?style=for-the-badge&logo=arduino&logoColor=white">

- Office
  
    <img src = "https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white">

## 🔌 사용 모듈 및 장치
- 아두이노 UNO 호환보드 * 2 + UNO 정품
- 라즈베리파이 4
- L298P 쉴드
- 아두이노 UNO용 USB HOST 쉴드
- HC-06 블루투스 직렬포트 모듈
- DC 기어드 모터
- 적외선 장애물회피 센서 모듈
- 1채널 5V 미니 릴레이 모듈
- 마운트형 CMOS QR코드 스캐너 모듈 2D Barcode Scanner USB (DP8402)
- 미니 서보모터 SG-90
- 라즈베리파이 카메라 모듈 5MP (YR-020)
- LED RGB 모듈 140C05 5V
- DHT11 디지털 온습도 센서 모듈
- 쿨러(CT-5010L05R-2P(5V))
- 아두이노 수동 부저

## 📃 진행 현황

### 📝 2024.07.02

- 스마트 팩토리 키트 조립
- 아두이노 회로 연결 및 모터 작동 시험


### 📝 2024.07.03

- WPF
    - 로그인 화면 구현
- Arduino
    - 아두이노간 통신 테스트 성공
    - 환경 모니터링 아두이노 코드 구현


### 📝 2024.07.04

- WPF
    - 메인화면 프레임 구현

- Arduino
    - 컨베이어 벨트 아두이노와 환경 모니터링 아두이노간 통신 연결
        - 환경 모니터링에서 특정 신호를 보낼 경우 컨베이어 벨트 아두이노 작동 중지
    
    - 개별 상자마다 적외선 센서를 부착하여 상자에 물건이 들어갈 때마다 감지하여 신호 전송
    - 컨베이어 벨트 위에 적외선 센서 2개를 부착하여 각 단계마다 일정 시간동안 정지 기능 구현
    - 아두이노의 블루투스 모듈을 연결하여 PC의 WPF와 통신 구현
    <img src="https://raw.githubusercontent.com/2024-iot-team1/Team1-miniproject/main/images/teamProject001.jpg" width="80%">

- 데이터베이스
    - 초기 데이터 베이스에 더미 데이터 추가

- 라즈베리파이
    - CCTV 구현 준비


### 📝 2024.07.05

- Arduino
    - 바코드 인식기 부착을 위한 보수작업

- WPF
    - 메인 창 페이지 전환 구현 성공
    - 재고 관리 페이지 구현 시작
        - DB 로드
    - 주문 관리 페이지 구현 시작
        - DB 로드
    - 모니터링 페이지 구현 시작
        - 블루투스 통신을 통한 온습도 정보 출력 성공


### 📝 2024.07.08

- Arduino
    - 컨베이어 벨트 담당 아두이노에 블루투스 모듈을 장착하여 WPF에서 제어 가능

- WPF
    - 재고 관리 페이지
        - 창 크기에 따라 내용 크기 조정 기능 구현
    - 주문 관리 페이지
        - 삭제 기능 구현
    - 모니터링 페이지
        - LiveChartsCore를 활용하여 블루투스 통신을 통해 받아온 정보를 Angular Chart로 출력 기능 구현
        - WorkStatus 테이블 로드
        - 버튼을 클릭하면 컨베이어 벨트 이동/정지 구현



### 📝 2024.07.09

- Arduino
    - 바코드&QR 스캐너를 USB 호스트 쉴드에 부착 완료
    - USB 호스트 쉴드에 블루투스 모듈을 연결하여 WPF와 통신 가능

- WPF
    - 재고 관리 페이지
        - 상품 추가 및 상품 정보 수정 기능 구현
    - 주문 관리 페이지
        - 주문 취소 기능 구현
    - 모니터링 페이지
        - LiveChartsCore를 활용하여 상품별, 지역별 처리량 출력 기능 구현
        - 리더기로 바코드나 QR을 읽으면 담겨있던 주문번호에 대한 정보를 기반으로 Delivery 테이블에서 배송지를 조회
        - 조회한 배송지를 기반으로 블루투스 통신을 통해 컨베이어 벨트 아두이노로 데이터를 전송하여 서보모터 각도 조절
        - 


### 📝 2024.07.10

- Arduino
    - 바코드 리더기에서 읽은 데이터를 블루투스 통신을 통해 WPF로 전송
    - WPF에서 블루투스 통신을 통해 받은 데이터를 받아 서보모터 각도 조절
    - 공정 마지막 단계에서 분류된 상품이 담기는 상자에 부착된 적외선 센서에 상품이 들어가는 것이 감지되면 WPF에 신호를 전송하는 기능 구현

- WPF
    - 모니터링 페이지
        - 바코드나 QR코드 정보가 블루투스 통신을 통해 들어오면 DB를 조회하여 해당 바코드나 QR코드의 목적지를 조회하여 아두이노로 데이터 전송하는 기능 구현
    - 재고 페이지
        - 버튼 아이콘 추가
        - 주문 취소 여부가 DB에 저장되도록 구현
    - CCTV & 설정 페이지
        - cefsharp를 이용하여 웹페이지에서 출력되는 라즈베리파이 카메라 화면을 WPF에 출력

- Raspberry Pi
    - flask를 이용하여 웹 페이지에 라즈베리파이 카메라가 촬영한 화면 출력

<img src="https://raw.githubusercontent.com/2024-iot-team1/Team1-miniproject/main/images/teamProject002.jpg" width="80%">



### 📝 2024.07.11

- WPF
    - 모니터링 페이지
        - 지역별 처리량에 따라 막대그래프가 실시간으로 변경되는 기능 구현
        - 버튼 및 데이터 그리드 양식 통일화
    - 주문 페이지
        - 버튼 및 데이터 그리드 양식 통일화
    - 재고 페이지
        - 버튼 및 데이터 그리드 양식 통일화
        - 주문일자 및 배송상태 변경 가능하게 구현
    - CCTV & 설정 페이지
        - CCTV 화면 크기 및 비율 조정
        - 환기팬 ON/OFF, 경고 부저 OFF, 경고 온습도 수준을 설정할 수 있도록 화면 구현
        - 설정 저장 버튼을 누르면 블루투스 통신을 통해 아두이노로 전달되어 설정이 변경되도록 함

<img src="https://raw.githubusercontent.com/2024-iot-team1/Team1-miniproject/main/images/teamProject003.jpg" width="80%">
