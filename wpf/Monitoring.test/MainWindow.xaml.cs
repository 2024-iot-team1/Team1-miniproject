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
using MahApps.Metro.Controls;

namespace Monitoring
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        // 온습도 정보 수신용 블루투스 연결
        internal SerialPort _serialPort01;   // COM10, 9600

        // 컨베이어 벨트 블루투스 연결
        internal SerialPort _serialPort02;   // COM12, 9600

        // usb 포트를 위한 블루트스 연결
        internal SerialPort _serialPort03;
        public MainWindow()
        {
            InitializeComponent();
            //ActiveItem.Content = new Views.ProcessMonitoring();
            //StsSelScreen.Content = "모니터링";

            try
            {
                _serialPort01 = new SerialPort("COM10", 9600); // COM 포트와 보드레이트 설정
                _serialPort01.Open();

                _serialPort02 = new SerialPort("COM12", 9600); // COM 포트와 보드레이트 설정
                _serialPort02.Open();

                StsResult.Content = "연결됨";
            }
            catch (Exception ex)
            {
                MessageBox.Show($"블루투스 연결 실패: {ex.Message}");
            }
        }

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

        private void Product_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Product();
            StsSelScreen.Content = "상품 목록 모니터링";
        }

        private void Inventory_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Inventory();
            StsSelScreen.Content = "재고 목록 모니터링";
        }

        private void Setting_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Setting();
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
