using System;
using System.Data.SqlClient;
using System.IO.Ports;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Threading;
using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;
using Monitoring.Models;
using Monitoring.Views;

namespace Monitoring
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        // 온습도 정보 수신용 블루투스 연결
        internal SerialPort _serialPort01;   // COM11, 9600

        // 컨베이어 벨트 블루투스 연결
        internal SerialPort _serialPort02;   // COM12, 9600

        // 바코드 및 QR코드 스캐너를 위한 블루트스 연결
        internal SerialPort _serialPort03;  // COM15

        internal int UserIdx {  get; set; }

        internal string UserName { get; set; }

        public int OrderNum { get; set; }
        public int DeliveryNum { get; set; }
        public MainWindow()
        {
            InitializeComponent();

            // 비동기적으로 시리얼 포트 초기화 시작
            // 디자인 작업할 때는 아래를 주석처리하고 작업하기
            InitializeSerialPortsAsync();

            // 타이머 설정: 1초마다 현재 시간 업데이트
            DispatcherTimer timer = new DispatcherTimer();
            timer.Interval = new TimeSpan(0, 0, 1);   // 1초마다
            timer.Tick += Timer_Tick;
            timer.Start();
        }

        // 컨베이어 벨트 분류기 아두이노
        private void SerialPort02_DataReceived(object sender, SerialDataReceivedEventArgs e)  // 블루투스에서 데이터를 수신받음
        {
            try
            {
                string data = _serialPort02.ReadLine();
                Dispatcher.Invoke(() => UpdateDB());
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => MessageBox.Show($"데이터 수신 오류: {ex.Message}"));
            }
        }

        // 바코드(QR) 스캐너 아두이노
        private void SerialPort03_DataReceived(object sender, SerialDataReceivedEventArgs e)  // 블루투스에서 데이터를 수신받음
        {
            try
            {
                string data3 = _serialPort03.ReadLine();
                OrderNum = Convert.ToInt32(data3);
                Dispatcher.Invoke(() => SendData(data3));
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => MessageBox.Show($"데이터 송수신 오류: {ex.Message}"));
            }
        }

        private void UpdateDB()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
                {
                    conn.Open();
                    // WorkStatus 테이블에 처리결과 삽입
                    string query2 = ProMonitoring.DELIVERY_UPDATE_QUERY;
                    DateTime nowDT = DateTime.Now; //ToString("yyyy-MM-dd HH:mm:ss");

                    SqlCommand insertCmd = new SqlCommand(ProMonitoring.INSERT_QUERY, conn);

                    insertCmd.Parameters.AddWithValue("@OrderNum", OrderNum);
                    insertCmd.Parameters.AddWithValue("@DeliveryNum", DeliveryNum);
                    insertCmd.Parameters.AddWithValue("@ProcessDT", nowDT);
                    insertCmd.Parameters.AddWithValue("@CompleteOrNot", 'Y');


                    int result = insertCmd.ExecuteNonQuery();

                    SqlCommand updateCom = new SqlCommand(query2, conn);
                    updateCom.Parameters.AddWithValue("@OrderNum", OrderNum);
                    updateCom.Parameters.AddWithValue("@StartDT", nowDT);

                    updateCom.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        // 바코드에서 얻은 주문번호를 기반으로 목적지 확인 -> 컨베이어 벨트 아두이노로 전송
        private void SendData(string data)
        {
            int orderNum = Convert.ToInt32(data);
            string destination = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
                {
                    string query = ProMonitoring.DESTINATION_SELECT_QUERY;

                    SqlCommand com = new SqlCommand(query, conn);
                    com.Parameters.AddWithValue("@OrderNum", orderNum);
                    conn.Open();
                    SqlDataReader reader = com.ExecuteReader();
                    if (reader.Read())
                    {
                        destination = reader["Destination"].ToString();
                        DeliveryNum = reader.GetInt32(reader.GetOrdinal("DeliveryNum"));
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            string send_data = "";
            if (destination == "서울") send_data = "2";
            else if (destination == "대구") send_data = "4";
            else if (destination == "부산") send_data = "6";
            _serialPort02.Write(send_data);
        }

        // 비동기적으로 시리얼 포트를 초기화
        private async void InitializeSerialPortsAsync()
        {
            LoadingOverlay.Visibility = Visibility.Visible;

            // 각 시리얼 포트 초기화 시도
            await TryInitializeSerialPortAsync("COM13", 9600, port => _serialPort01 = port);
            await TryInitializeSerialPortAsync("COM7", 9600, port => _serialPort02 = port);
            await TryInitializeSerialPortAsync("COM10", 9600, port => _serialPort03 = port);


            // 연결 상태 UI 업데이트
            if (_serialPort01 != null && _serialPort02 != null && _serialPort03 != null)
            {
                await this.ShowMessageAsync("블루투스 통신","연결 완료");
            }
            else
            {
                await this.ShowMessageAsync("블루투스 통신", "연결 실패");
            }
            _serialPort02.DataReceived += SerialPort02_DataReceived;
            _serialPort03.DataReceived += SerialPort03_DataReceived;

            LoadingOverlay.Visibility = Visibility.Collapsed;
        }

        // 특정 시리얼 포트를 초기화하고 연결 시도
        private async Task TryInitializeSerialPortAsync(string portName, int baudRate, Action<SerialPort> onSuccess)
        {
            while (true)
            {
                // 시리얼 포트 연결 시도
                var isConnected = await Task.Run(() =>
                {
                    var serialPort = new SerialPort
                    {
                        PortName = portName,
                        BaudRate = baudRate
                        //Parity = Parity.None,
                        //DataBits = 8,
                        //StopBits = StopBits.One,
                        //Handshake = Handshake.None
                    };

                    try
                    {
                        serialPort.Open();
                        onSuccess(serialPort);
                        return true;
                    }
                    catch (Exception)
                    {
                        return false;
                    }
                });

                if (isConnected)
                {
                    break; // 연결 성공 시 루프 종료
                }
                else
                {
                    await this.ShowMessageAsync("연결 오류",$"블루투스 연결 실패: 세마포 제한 시간 만료. {portName} 포트를 5초 후 다시 시도합니다.");
                    await Task.Delay(5000); // 5초 대기 후 재시도
                }
            }
        }

        // 타이머
        private void Timer_Tick(object sender, EventArgs e)
        {
            LblSensingDt.Content = DateTime.Now.ToString("yyyy년 MM월 dd일 HH시 mm분 ss초");
        }

        // 화면 출력
        private void Monitoring_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.ProcessMonitoring(this);
            StsSelScreen.Content = "모니터링";
        }

        private void Order_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Order();
            StsSelScreen.Content = "주문 목록 모니터링";
        }


        private void Inventory_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Inventory();
            StsSelScreen.Content = "재고 목록 모니터링";
        }

        private void Setting_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Setting(this);
            StsSelScreen.Content = "시스템 모니터링";
        }

        // 종료 시 블루투스로 연결한 포트 닫기
        private void Window_Closed(object sender, EventArgs e)
        {
            if (_serialPort01 != null && _serialPort01.IsOpen)
            {
                _serialPort01.Close();
            }
            if (_serialPort02 != null && _serialPort02.IsOpen)
            {
                _serialPort02.Close();
            }
            if (_serialPort03 != null && _serialPort03.IsOpen)
            {
                _serialPort03.Close();
            }
        }
    }
}
