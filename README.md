# Team1-miniproject
부경대학교 2024 IoT 개발자 과정 1조 미니프로젝트 : 스마트 물류 시스템

## 팀원 소개
<table>
    <tbody>
        <tr>
            <td align="center"><a href=""><br/><b>팀장 : 고병학</b></a><br/></td>
            <td align="center"><a href=""><br/><b>부팀장 : 유왕권</b></a><br/></td>
            <td align="center"><a href=""><br/><b>팀원 : 김동주</b></a><br/></td>
            <td align="center"><a href=""><br/><b>팀원 : 황지환</b></a><br/></td>
            <td align="center"><a href=""><br/><b>팀원 : 홍승욱</b></a><br/></td>
        <tr/>
            <td align="center"><a href="https://github.com/znah54/"><br/><b>@znah54</b></a><br/></td>
            <td align="center"><a href="https://github.com/YooWangGwon"><br/><b>@YooWangGwon</b></a><br/></td>
            <td align="center"><a href="https://github.com/kimdongju1"><br/><b>@kimdongju1</b></a><br/></td>
            <td align="center"><a href="https://github.com/Hwangji99"><br/><b>@Hwangji99</b></a><br/></td>
            <td align="center"><a href="https://github.com/sungouk1457"><br/><b>@sungouk1457</b></a><br/></td>
        <tr/>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b>DB 구축</b></a><br/></td>
            <td align="center"><a href=""><br/><b>CCTV 시스템 구현</b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
        <tr/>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b>아두이노 자동 분류 시스템 구현</b></a><br/></td>
            <td align="center"><a href=""><br/><b>더미 데이터 세팅</b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
        <tr/>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b>아두이노 실내 환경 모니터링 시스템 구현</b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
        <tr/>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b>아두이노와 WPF 블루투스 통신 연결</b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
            <td align="center"><a href=""><br/><b> </b></a><br/></td>
        </tr>
    </tbody>
</table>


## 진행 현황
### 2024.07.02
- 스마트 팩토리 키트 조립
- 아두이노 회로 연결 및 모터 작동 시험

### 2024.07.03
- WPF
    - 로그인 화면 구현
- Arduino
    - 아두이노간 통신 테스트 성공
    - 환경 모니터링 아두이노 코드 구현

### 2024.07.04
- WPF
    - 메인화면 프레임 구현

- Arduino
    - 컨베이어 벨트 아두이노와 환경 모니터링 아두이노간 통신 연결
        - 환경 모니터링에서 특정 신호를 보낼 경우 컨베이어 벨트 아두이노 작동 중지
    
    - 개별 상자마다 적외선 센서를 부착하여 상자에 물건이 들어갈 때마다 감지하여 신호 전송
    - 컨베이어 벨트 위에 적외선 센서 2개를 부착하여 각 단계마다 일정 시간동안 정지 기능 구현
    - 아두이노의 블루투스 모듈을 연결하여 PC의 WPF와 통신 구현
    <img src="https://raw.githubusercontent.com/2024-iot-team1/Team1-miniproject/main/images/teamProject001.jpg">

- 데이터베이스
    - 초기 데이터 베이스에 더미 데이터 추가

- 라즈베리파이
    - CCTV 구현 준비

### 2024.07.05