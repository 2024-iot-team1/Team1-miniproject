using System;
using System.Collections.Generic;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;


namespace Monitoring.Views
{
    /// <summary>
    /// ProcessMonitoring.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class ProcessMonitoring : UserControl
    {
        private SerialPort _serialPort;
        private StringBuilder _dataBuffer = new StringBuilder();

        public ProcessMonitoring()
        {
            InitializeComponent();
            try
            {
                _serialPort = new SerialPort("COM10", 9600); // COM 포트와 보드레이트 설정
                _serialPort.DataReceived += SerialPort_DataReceived;
                _serialPort.Open();
                MessageBox.Show("연결됨");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"연결 실패: {ex.Message}");
            }

        }

        private void SerialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                string data = _serialPort.ReadLine();
                //_dataBuffer.Append(data);
                Dispatcher.Invoke(() => ProcessData(data));
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => MessageBox.Show($"데이터 수신 오류: {ex.Message}"));
            }
        }
        private void ProcessData(string data)
        {
            string[] values = data.Split(',');
            if (values.Length == 2)
            {
                TbxTemp.Text = $"{values[0]}";
                TbxHumid.Text = $"{values[1]}";
            }
            else
            {
                MessageTextBox.Text = "데이터 형식 오류";
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort != null && _serialPort.IsOpen)
            {
                _serialPort.Close();
            }
        }

        private void BtnSend_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort != null && _serialPort.IsOpen)
            {
                var message = MessageTextBox.Text;
                _serialPort.WriteLine(message);
            }
        }
    }
}
