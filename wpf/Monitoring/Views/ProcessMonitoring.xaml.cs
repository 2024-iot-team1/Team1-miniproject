using LiveChartsCore;
using LiveChartsCore.Defaults;
using LiveChartsCore.SkiaSharpView;
using LiveChartsCore.SkiaSharpView.Drawing;
using LiveChartsCore.SkiaSharpView.Extensions;
using LiveChartsCore.SkiaSharpView.VisualElements;
using LiveChartsCore.VisualElements;
using MahApps.Metro.Controls;
using Monitoring.Models;
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
        // 온습도 정보 수신용 블루투스 연결
        private SerialPort _serialPort01;

        // 컨베이어 벨트 블루투스 연결
        private SerialPort _serialPort02;

        // usb 포트를 위한 블루트스 연결
        private SerialPort _serialPort03;

        private StringBuilder _dataBuffer = new StringBuilder();
        public IEnumerable<VisualElement<SkiaSharpDrawingContext>> VisualElements { get; set; }
        public NeedleVisual Needle { get; set; }
        public IEnumerable<ISeries> HumidSeries { get; set; }

        public ProcessMonitoring()
        {
            // 블루투스 연결
            InitializeComponent();
            try
            {
                _serialPort01 = new SerialPort("COM10", 9600); // COM 포트와 보드레이트 설정
                _serialPort01.DataReceived += SerialPort_DataReceived;
                _serialPort01.Open();
                MessageBox.Show("연결됨");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"블루투스 연결 실패: {ex.Message}");
            }

            // 타이머 설정
            DispatcherTimer timer = new DispatcherTimer();
            timer.Interval = new TimeSpan(0, 0, 1);   // 1초마다
            timer.Tick += Timer_Tick;
            timer.Start();
        }
        private void Timer_Tick(object sender, EventArgs e)
        {
            LblSensingDt.Content = DateTime.Now.ToString("yyyy년 MM월 dd일 HH:mm:ss");
        }

        private void SerialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)  // 블루투스에서 데이터를 수신받음
        {
            try
            {
                string data = _serialPort01.ReadLine();
                //_dataBuffer.Append(data);
                Dispatcher.Invoke(() => UpdateChart(data));
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => MessageBox.Show($"데이터 수신 오류: {ex.Message}"));
            }
        }
        private void ProcessData(string data)   // 수신받은 데이터를 처리
        {
            string[] values = data.Split(',');
            if (values.Length == 2)
            {
                //TbxTemp.Text = $"{values[0]}";
                //TbxHumid.Text = $"{values[1]}";
            }
            else
            {
                MessageTextBox.Text = "데이터 형식 오류";
            }
        }
        private static void SetStyle(double sectionsOuter, double sectionsWidth, PieSeries<ObservableValue> series)
        {
            series.OuterRadiusOffset = sectionsOuter;
            series.MaxRadialColumnWidth = sectionsWidth;
        }
        private void UpdateChart(string data)
        {
            this.Invoke(() =>
            {
                string[] values = data.Split(',');

                var temp = Convert.ToDouble(values[0]);
                var humid = Convert.ToDouble(values[1]);

                // 온도차트 값
                var tempVal = GaugeGenerator.BuildSolidGauge(new GaugeItem(
                    temp,
                    series =>
                    {
                        series.MaxRadialColumnWidth = 30;
                        series.DataLabelsSize = 50;
                    }
                ));

                ChtTemp.Series = tempVal;

                //위에서 만든 차트 화면 디자인을 실제 화면의 차트에 적용

                var sectionsOuter = 130;
                var sectionsWidth = 20;
                // 습도 차트 값 할당
                HumidSeries = GaugeGenerator.BuildAngularGaugeSections(
                    new GaugeItem(humid,
                    s => SetStyle(sectionsOuter, sectionsWidth, s))
                );

                // 습도를 나타낼 앵귤러차트를 초기화
                Needle = new NeedleVisual { Value = humid };   // 차트 바늘의 초기값이 20
                // 앵귤러 차트를 그리기 위한 속성들
                VisualElements = new VisualElement<SkiaSharpDrawingContext>[]
                {
                new AngularTicksVisual
                {
                    // 앵귤러 차트를 꾸미는 속성들
                    LabelsSize = 12,
                    LabelsOuterOffset = 15,
                    OuterOffset = 65, // 차트 선이 퍼져있는 정도
                    TicksLength = 15 // 차트 실선 길이
                },
                Needle
                };

                //위에서 만든 차트 화면 디자인을 실제 화면의 차트에 적용
                ChtHumid.VisualElements = VisualElements;
            });
        }

        private void BtnDisconnect_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort01 != null && _serialPort01.IsOpen)
            {
                // Disconnect 버튼 클릭시 블루투스 연결 종료
                _serialPort01.Close();
            }
        }

        private void BtnSend_Click(object sender, RoutedEventArgs e)
        {
            if (_serialPort01 != null && _serialPort01.IsOpen)
            {
                var message = MessageTextBox.Text;
                _serialPort01.WriteLine(message);
            }
        }

        private void BtnStart_Click(object sender, RoutedEventArgs e)
        {

        }

        private void BtnStop_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
