using System;
using System.IO.Ports;
using System.Text;
using System.Windows;
using System.Windows.Threading;

namespace btTest
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private SerialPort _serialPort;
        private StringBuilder _dataBuffer = new StringBuilder();

        public MainWindow()
        {
            InitializeComponent();
        }

        private void ConnectButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                _serialPort = new SerialPort("COM6", 9600); // COM 포트와 보드레이트 설정
                _serialPort.DataReceived += SerialPort_DataReceived;
                _serialPort.Open();
                StatusTextBlock.Text = "연결됨";
            }
            catch (Exception ex)
            {
                StatusTextBlock.Text = $"연결 실패: {ex.Message}";
            }
        }

        private void SerialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                string data = _serialPort.ReadExisting();
                _dataBuffer.Append(data);
                Dispatcher.Invoke(() => ProcessData());
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => StatusTextBlock.Text = $"데이터 수신 오류: {ex.Message}");
            }
        }

        private void ProcessData()
        {
            string data = _dataBuffer.ToString();
            ReceivedTextBlock.Text = data;
            _dataBuffer.Clear();
        }
        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort != null && _serialPort.IsOpen)
            {
                var message = MessageTextBox.Text;
                _serialPort.WriteLine(message);
            }
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            if (_serialPort != null && _serialPort.IsOpen)
            {
                _serialPort.Close();
            }
        }

        private void BtnFanOn_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort != null && _serialPort.IsOpen)
            {
                _serialPort.WriteLine("3");
            }
        }

        private void BtnFanOff_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort != null && _serialPort.IsOpen)
            {
                _serialPort.WriteLine("4");
            }
        }
    }
}