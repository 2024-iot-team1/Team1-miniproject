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
using System.Data.SqlClient;
using System.Data;
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
using Monitoring.Models;
using LiveChartsCore.SkiaSharpView.Painting;
using SkiaSharp;
using System.Drawing;
using LiveChartsCore.SkiaSharpView.WPF;

namespace Monitoring.Views
{
    /// <summary>
    /// ProcessMonitoring.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class ProcessMonitoring : UserControl
    {
        // 온습도 정보 수신용 블루투스 연결
        private SerialPort port01;   // COM10, 9600

        // 컨베이어 벨트 블루투스 연결
        private SerialPort port02;   // COM12, 9600

        // usb 포트를 위한 블루트스 연결
        private SerialPort port03;

        // private StringBuilder _dataBuffer = new StringBuilder();

        #region 온습도 정보 출력을 위한 프로퍼티 선언
        public IEnumerable<VisualElement<SkiaSharpDrawingContext>> TempVisualElements { get; set; }
        public IEnumerable<VisualElement<SkiaSharpDrawingContext>> HumidVisualElements { get; set; }

        public NeedleVisual TempNeedle { get; set; }
        public NeedleVisual HumidNeedle { get; set; }
        public IEnumerable<ISeries> TempSeries { get; set; }
        public IEnumerable<ISeries> HumidSeries { get; set; }

        #endregion
        public int OrderNum { get; set; }
        public int DeliveryNum { get; set; }
        MainWindow MainWindow { get; set; }
        public ProcessMonitoring(MainWindow e)
        {
            InitializeComponent();
            MainWindow = e;

            port01 = MainWindow._serialPort01;
            port01.DataReceived += SerialPort01_DataReceived;

            port02 = MainWindow._serialPort02;
            port02.DataReceived += SerialPort02_DataReceived;

            port03 = MainWindow._serialPort03;
            port03.DataReceived += SerialPort03_DataReceived;
            // 앵귤러 차트 추가
            CreateChart();

            // 데이터 출력
            LoadData();
            UpdateDoughnut();
            UpdateBars();
        }
        public ProcessMonitoring()
        {
            InitializeComponent();
        }


        // 실내 환경 모니터링 아두이노
        private void SerialPort01_DataReceived(object sender, SerialDataReceivedEventArgs e)  // 블루투스에서 데이터를 수신받음
        {
            try
            {
                string data1 = port01.ReadLine();
                Dispatcher.Invoke(() => UpdateChart(data1));
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => MessageBox.Show($"데이터 수신 오류: {ex.Message}"));
            }
        }

        // 컨베이어 벨트 분류기 아두이노
        private void SerialPort02_DataReceived(object sender, SerialDataReceivedEventArgs e)  // 블루투스에서 데이터를 수신받음
        {
            try
            {
                string data = port02.ReadLine();
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
                string data3 = port03.ReadLine();
                OrderNum = Convert.ToInt32(data3);
                Dispatcher.Invoke(() => SendData(data3));
            }
            catch (Exception ex)
            {
                Dispatcher.Invoke(() => MessageBox.Show($"데이터 송수신 오류: {ex.Message}"));
            }
        }

        // 바코드에서 얻은 주문번호를 기반으로 목적지 확인 -> 컨베이어 벨트 아두이노로 전송
        private void SendData(string data)
        {
            int orderNum = Convert.ToInt32(data);
            string destination = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
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
            MainWindow.StsResult.Content = destination;

            string send_data = "";
            if (destination == "서울") send_data = "2";
            else if(destination == "대구") send_data = "4";
            else if(destination == "부산") send_data = "6";
            port02.Write(send_data);
        }

        private void UpdateDB()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
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
            LoadData();
        }

        #region 온습도 앵귤러 차트 영역
        private static void SetStyle(double sectionsOuter, double sectionsWidth, PieSeries<ObservableValue> series)
        {
            series.OuterRadiusOffset = sectionsOuter;
            series.MaxRadialColumnWidth = sectionsWidth;
        }

        private void CreateChart()
        {
            var sectionsOuter = 130;
            var sectionsWidth = 30;

            TempNeedle = new NeedleVisual { Value = 20 };   // 차트 바늘의 초기값이 20
                                                              // 온도 차트 값 할당
            TempSeries = GaugeGenerator.BuildAngularGaugeSections(
                new GaugeItem(25, s => SetStyle(sectionsOuter, sectionsWidth, s)),
                new GaugeItem(75, s => SetStyle(sectionsOuter, sectionsWidth, s))
            );
            ChtTemp.Series = TempSeries;

            // 온도를 나타낼 앵귤러차트를 초기화
            // 앵귤러 차트를 그리기 위한 속성들
            TempVisualElements = new VisualElement<SkiaSharpDrawingContext>[]
            {
                new AngularTicksVisual
                {
                    // 앵귤러 차트를 꾸미는 속성들
                    LabelsSize = 12,
                    LabelsOuterOffset = 10,
                    OuterOffset = 40, // 차트 선이 퍼져있는 정도
                    TicksLength = 12 // 차트 실선 길이
                },
                TempNeedle
            };

            //위에서 만든 차트 화면 디자인을 실제 화면의 차트에 적용
            ChtTemp.VisualElements = TempVisualElements;


            // 습도 차트 값 할당
            HumidSeries = GaugeGenerator.BuildAngularGaugeSections(
                new GaugeItem(70, s => SetStyle(sectionsOuter, sectionsWidth, s)),
                new GaugeItem(20, s => SetStyle(sectionsOuter, sectionsWidth, s)),
                new GaugeItem(10, s => SetStyle(sectionsOuter, sectionsWidth, s))
            );
            ChtHumid.Series = HumidSeries;

            // 습도를 나타낼 앵귤러차트를 초기화
            HumidNeedle = new NeedleVisual { Value = 50, ScalesXAt = 10 };   // 차트 바늘의 초기값이 20
                                                                // 앵귤러 차트를 그리기 위한 속성들
            HumidVisualElements = new VisualElement<SkiaSharpDrawingContext>[]
            {
                new AngularTicksVisual
                {
                    // 앵귤러 차트를 꾸미는 속성들
                    LabelsSize = 12,
                    LabelsOuterOffset = 15,
                    OuterOffset = 50, // 차트 선이 퍼져있는 정도
                    TicksLength = 15, // 차트 실선 길이

                },
                HumidNeedle
            };

            //위에서 만든 차트 화면 디자인을 실제 화면의 차트에 적용
            ChtHumid.VisualElements = HumidVisualElements;
        }
        private void UpdateChart(string data)
        {
            this.Invoke(() =>
            {
                string[] values = data.Split(',');

                var temp = Convert.ToDouble(values[0]);
                var humid = Convert.ToDouble(values[1]);

                TempNeedle.Value = temp;
                HumidNeedle.Value = humid;
            });
        }
        #endregion

        private void BtnStart_Click(object sender, RoutedEventArgs e)
        {
            port02.WriteLine("1");
        }

        private void BtnStop_Click(object sender, RoutedEventArgs e)
        {
            port02.WriteLine("0");
        }

        private string connectionString = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";
        private void LoadData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    // Orders 테이블과 Delivery 테이블을 Inner Join 하여 데이터 가져오는 쿼리
                    string query = ProMonitoring.SELECT_QUERY;

                    SqlCommand com = new SqlCommand(query, conn);
                    SqlDataAdapter adapter = new SqlDataAdapter(com);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    DrdWorkStatus.ItemsSource = dataTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        #region 상품별 처리량 도넛 그래프
        //public IEnumerable<ISeries> ProductSeries { get; set; } =
        //    new[]
        //    {
        //            new PieSeries<int> { Values = new[]{ 2 }, Name = "A", InnerRadius = 30,
        //                                DataLabelsPaint = new SolidColorPaint(SKColors.Black),
        //                                DataLabelsSize = 15,
        //                                DataLabelsPosition = LiveChartsCore.Measure.PolarLabelsPosition.Middle,
        //                                DataLabelsFormatter = point => point.PrimaryValue.ToString("N2")},
        //            new PieSeries<int> { Values = new[]{ 4 }, Name = "B", InnerRadius = 30,
        //                                DataLabelsPaint = new SolidColorPaint(SKColors.Black),
        //                                DataLabelsSize = 15,
        //                                DataLabelsPosition = LiveChartsCore.Measure.PolarLabelsPosition.Middle,
        //                                DataLabelsFormatter = point => point.PrimaryValue.ToString("N2") },
        //            new PieSeries<int> { Values = new[]{ 1 }, Name = "C", InnerRadius = 30,                                
        //                                DataLabelsPaint = new SolidColorPaint(SKColors.Black),
        //                                DataLabelsSize = 15,
        //                                DataLabelsPosition = LiveChartsCore.Measure.PolarLabelsPosition.Middle,
        //                                DataLabelsFormatter = point => point.PrimaryValue.ToString("N2")},
        //            new PieSeries<int> { Values = new[]{ 4 }, Name = "D", InnerRadius = 30,
        //                                DataLabelsPaint = new SolidColorPaint(SKColors.Black),
        //                                DataLabelsSize = 15,
        //                                DataLabelsPosition = LiveChartsCore.Measure.PolarLabelsPosition.Middle,
        //                                DataLabelsFormatter = point => point.PrimaryValue.ToString("N1")},
        //            new PieSeries<int> { Values = new[]{ 3 }, Name = "E", InnerRadius = 30,
        //                                DataLabelsPaint = new SolidColorPaint(SKColors.Black),
        //                                DataLabelsSize = 15,
        //                                DataLabelsPosition = LiveChartsCore.Measure.PolarLabelsPosition.Middle,
        //                                DataLabelsFormatter = point => point.PrimaryValue.ToString("N1") },
        //    };

        //private void UpdateDoughnut()
        //{
        //    ChtProduct.Series = ProductSeries;
        //    ChtProduct.LegendPosition = LiveChartsCore.Measure.LegendPosition.Bottom;
        //}
        #endregion

        #region 지역별 처리량 막대 그래프
        public ISeries[] DestinationSeries { get; set; } =
        {
            new ColumnSeries<double>
            {
                Name = "",
                Values = new double[] { 2, 5, 4 },
                MaxBarWidth = 30,
                DataLabelsSize = 0,
                Padding = 10
            }
        };

        public Axis[] DestinationXAxes { get; set; } =
        {
            new Axis
            {
                Labels = new string[] { "Seoul", "Busan", "Daegu" },
                LabelsRotation = 0,
                SeparatorsPaint = new SolidColorPaint(new SKColor(200, 200, 200)),
                ShowSeparatorLines = false,
                SeparatorsAtCenter = false,
                ForceStepToMin = true,
                MinStep = 1,
            }
        };

        private void UpdateBars()
        {
            ChtDestination.Series = DestinationSeries;
            ChtDestination.XAxes = DestinationXAxes;
        }
#endregion
    }
}
