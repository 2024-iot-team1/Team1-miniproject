using System;
using System.Windows;
using System.Windows.Controls;
using System.Diagnostics;
using System.IO.Ports;


namespace Monitoring.Views
{
    /// <summary>
    /// Setting.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class Setting : UserControl
    {
        private Process _flaskProcess;

        private SerialPort port01;

        MainWindow MainWindow { get; set; }

        public Setting()
        {
            InitializeComponent();
        }

        public Setting(MainWindow e)
        {
            InitializeComponent();
            MainWindow = e;
            port01 = MainWindow._serialPort01;
        }

        private void OnButton_Click(object sender, RoutedEventArgs e)
        {
            if (_flaskProcess == null)
            {
                StartFlaskServer();
            }

            ChromeWeb.Address = "http://210.119.12.59:18088/";
        }

        private void OffButton_Click(object sender, RoutedEventArgs e)
        {
            if (_flaskProcess != null)
            {
                StopFlaskServer();
            }

            ChromeWeb.Address = "about:blank";
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (port01 == null)
                {
                    MessageBox.Show("Serial port is not initialized.");
                    return;
                }

                if (!port01.IsOpen)
                {
                    MessageBox.Show("Serial port is not open.");
                    return;
                }

                string temp = TempNum.Value.ToString();
                string humid = HumidNum.Value.ToString();

                var buzzStatus = SwitchBuzz.IsOn ? "1" : "0";
                var fanStatus = SwitchFan.IsOn ? "1" : "0";
                var lightStatus = SwitchLight.IsOn ? "1" : "0";

                var setting_data = $"{temp},{humid},{fanStatus},{buzzStatus},{lightStatus}";
                port01.WriteLine(setting_data);
            }
            catch (Exception ex)
            {
                MessageBox.Show("데이터 전송 실패 : " + ex.Message);
            }
        }

        // Flask 서버를 시작하는 메서드
        private void StartFlaskServer()
        {
            // 프로세스 시작 정보를 설정합니다.
            var startInfo = new ProcessStartInfo
            {
                // 실행 파일 이름을 설정합니다. 여기서는 파이썬 인터프리터를 사용합니다.
                FileName = "python",
                // 실행 파일에 전달할 인수를 설정합니다. 여기서는 Flask 서버를 실행하는 파이썬 스크립트의 경로를 지정합니다.
                Arguments = "\"C:\\Sources\\Team1-miniproject\\CCTV\\gdsb_cctv_project\\cctv#3 flask webcam with text.py\"",
                // 새 창을 열지 않고 명령줄 창을 숨깁니다.
                UseShellExecute = false,
                // 프로세스의 표준 출력을 리디렉션합니다.
                RedirectStandardOutput = true,
                // 프로세스의 표준 오류를 리디렉션합니다.
                RedirectStandardError = true,
                // 프로세스를 숨깁니다(명령줄 창을 표시하지 않습니다).
                CreateNoWindow = true,
            };

            // 새로운 프로세스 인스턴스를 생성하고 시작 정보를 설정합니다.
            _flaskProcess = new Process
            {
                StartInfo = startInfo
            };

            // 프로세스의 표준 출력 데이터를 수신하기 위한 이벤트 핸들러를 설정합니다.
            _flaskProcess.OutputDataReceived += (sender, args) => Debug.WriteLine(args.Data);
            // 프로세스의 표준 오류 데이터를 수신하기 위한 이벤트 핸들러를 설정합니다.
            _flaskProcess.ErrorDataReceived += (sender, args) => Debug.WriteLine(args.Data);

            // 프로세스를 시작합니다.
            _flaskProcess.Start();
            // 비동기적으로 표준 출력 읽기를 시작합니다.
            _flaskProcess.BeginOutputReadLine();
            // 비동기적으로 표준 오류 읽기를 시작합니다.
            _flaskProcess.BeginErrorReadLine();
        }

        // Flask 서버를 중지하는 메서드
        private void StopFlaskServer()
        {
            // 프로세스가 null이 아니고 종료되지 않은 경우
            if (_flaskProcess != null && !_flaskProcess.HasExited)
            {
                // 프로세스를 강제 종료합니다.
                _flaskProcess.Kill();
                // 프로세스와 관련된 모든 리소스를 해제합니다.
                _flaskProcess.Dispose();
                // 프로세스 변수를 null로 초기화합니다.
                _flaskProcess = null;
            }
        }
    }
}
