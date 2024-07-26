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
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Brushes = System.Windows.Media.Brushes;
using Monitoring.Views.Models;

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

        public bool AlreadyDone { get; set; }
        MainWindow MainWindow { get; set; }

        public ObservableCollection<DestClassifications> Destinations { get; set; }

        private DestClassifications _selectedDestination;

        public DestClassifications SelectedDestination
        {
            get { return _selectedDestination; }
            set
            {
                _selectedDestination = value;
                OnPropertyChanged(nameof(SelectedDestination));
            }
        }
        public ProcessMonitoring(MainWindow e)
        {
            InitializeComponent();
            MainWindow = e;

            if (MainWindow._serialPort01 != null && MainWindow._serialPort01.IsOpen)
            {
                port01 = MainWindow._serialPort01;
                port01.DataReceived += SerialPort01_DataReceived;
            }
            if (MainWindow._serialPort02 != null && MainWindow._serialPort02.IsOpen)
            {
                port02 = MainWindow._serialPort02;
                port02.DataReceived += SerialPort02_DataReceived;
            }
            if (MainWindow._serialPort03 != null && MainWindow._serialPort03.IsOpen)
            {
                port03 = MainWindow._serialPort03;
                port03.DataReceived += SerialPort03_DataReceived;
            }
            // Destinations 리스트 객체 생성
            Destinations = new ObservableCollection<DestClassifications>();
            DataContext = this;

            // 앵귤러 차트 추가
            CreateChart();

            // 데이터 출력
            LoadData();

            // 지역별 처리량 차트 생성
            UpdateBars();

            // 지역별 처리량을 DB에서 조회하여 지역별 처리량 차트에 넣기
            UpdateValues();

            // 콤보박스에 값 넣기
            setComboBox();
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

                    // 이미 처리한 주문 번호인지(테이블에 존재하는 주문번호인지) 확인
                    string checkQuery1 = ProMonitoring.ORDERNUM_SELECT_QUERY;
                    SqlCommand checkCom = new SqlCommand(checkQuery1, conn);
                    checkCom.Parameters.AddWithValue("@OrderNum", orderNum);
                    int count1 = (int)checkCom.ExecuteScalar();

                    // 이미 배송중이거나 배송완료한 주문 번호인지 확인
                    string checkQuery2 = ProMonitoring.STATUS_SELECT_QUERY;
                    SqlCommand checkCom2 = new SqlCommand(checkQuery2, conn);
                    checkCom2.Parameters.AddWithValue("@OrderNum", orderNum);
                    int count2 = 0;
                    if (checkCom2.ExecuteScalar() == null)
                    {
                        count2 = 0;
                    }
                    else count2 = (int)checkCom2.ExecuteScalar();

                    // 이미 처리한 주문번호가 아니고 배송중이거나 배송완료한 주문이 아닌 경우
                    if(count1 == 0 && count2 == 0)
                    {
                        AlreadyDone = false;
                        // WorkStatus 테이블에 처리결과 삽입
                        DateTime nowDT = DateTime.Now; //ToString("yyyy-MM-dd HH:mm:ss");

                        SqlCommand insertCmd = new SqlCommand(ProMonitoring.INSERT_QUERY, conn);

                        insertCmd.Parameters.AddWithValue("@OrderNum", OrderNum);
                        insertCmd.Parameters.AddWithValue("@DeliveryNum", DeliveryNum);
                        insertCmd.Parameters.AddWithValue("@ProcessDT", nowDT);
                        insertCmd.Parameters.AddWithValue("@CompleteOrNot", 'N');

                        insertCmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            string send_data = "";
            if (destination == "서울") send_data = "2";
            else if(destination == "대구") send_data = "4";
            else if(destination == "부산") send_data = "6";
            port02.Write(send_data);
        }

        private void UpdateDB()
        {
            // 이미 처리된 작업이라면
            if (AlreadyDone == true)
            {
                return;
            }
            // 처리된 작업이 아니라면
            else
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        // WorkStatus 테이블에 처리결과 삽입
                        string query = ProMonitoring.DELIVERY_UPDATE_QUERY;
                        DateTime nowDT = DateTime.Now; //ToString("yyyy-MM-dd HH:mm:ss");

                        SqlCommand updateCmd = new SqlCommand(ProMonitoring.UPDATE_WORKSTATUS, conn);
                        updateCmd.Parameters.AddWithValue("@OrderNum", OrderNum);

                        updateCmd.ExecuteNonQuery();

                        SqlCommand updateCom = new SqlCommand(query, conn);
                        updateCom.Parameters.AddWithValue("@OrderNum", OrderNum);
                        updateCom.Parameters.AddWithValue("@StartDT", nowDT);

                        updateCom.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                AlreadyDone = true;
            }
            LoadData();
            UpdateValues();
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
            HumidNeedle = new NeedleVisual { Value = 50 };   // 차트 바늘의 초기값이 50

            // 앵귤러 차트를 그리기 위한 속성들
            HumidVisualElements = new VisualElement<SkiaSharpDrawingContext>[]
            {
                new AngularTicksVisual
                {
                    // 앵귤러 차트를 꾸미는 속성들
                    LabelsSize = 12,
                    LabelsOuterOffset = 15,
                    OuterOffset = 40, // 차트 선이 퍼져있는 정도
                    TicksLength = 12, // 차트 실선 길이
                },
                HumidNeedle
            };

            //위에서 만든 차트 화면 디자인을 실제 화면의 차트에 적용
            ChtHumid.VisualElements = HumidVisualElements;
        }
        public void UpdateChart(string data)
        {
            this.Invoke(() =>
            {
                string[] values = data.Split(',');

                var temp = Convert.ToDouble(values[0]);
                var humid = Convert.ToDouble(values[1]);
                var warningSign = Convert.ToDouble(values[2]);

                TempNeedle.Value = temp;
                HumidNeedle.Value = humid;
                if (warningSign == 1) 
                {
                    MainWindow.StartWarningAnimation();
                }
                else
                {
                     MainWindow.StopWarningAnimation();
                }

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

        private string connectionString = Common.CONNSTRING;
        private void LoadData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
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

        private void LoadData(string dest)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
                {
                    conn.Open();

                    string query = ProMonitoring.FILTER_SELECT_QUERY;
                    SqlCommand comm = new SqlCommand(query, conn);
                    comm.Parameters.AddWithValue("@Destination", dest);

                    SqlDataAdapter adapter= new SqlDataAdapter(comm);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    DrdWorkStatus.ItemsSource= dataTable.DefaultView;
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
        private ObservableCollection<ISeries> _destinationSeries;
        public ObservableCollection<ISeries> DestinationSeries
        {
            get => _destinationSeries;
            set
            {
                _destinationSeries = value;
                OnPropertyChanged();
            }
        }

        private ObservableCollection<Axis> _destinationXAxes;
        public ObservableCollection<Axis> DestinationXAxes
        {
            get => _destinationXAxes;
            set
            {
                _destinationXAxes = value;
                OnPropertyChanged();
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void UpdateBars()
        {
            DestinationSeries = new ObservableCollection<ISeries>
            {
                new ColumnSeries<double>
                {
                    Name = "Count",
                    Values = new double[] { 2, 5, 4 },
                    MaxBarWidth = 100,
                    DataLabelsSize = 15,
                    Padding = 10
                }
            };

            DestinationXAxes = new ObservableCollection<Axis>
            {
                new Axis
                {
                    Labels = new string[] { "Seoul", "Busan", "Daegu" },
                    LabelsRotation = 0,

                    SeparatorsPaint = new SolidColorPaint(new SKColor(200, 200, 200)),
                    ShowSeparatorLines = false,
                    SeparatorsAtCenter = false,
                    ForceStepToMin = true,
                }
            };

            ChtDestination.Series = DestinationSeries;
            ChtDestination.XAxes = DestinationXAxes;
        }

        public int SeoulValue { get; set; }
        public int BusanValue { get; set; }
        public int DaeguValue { get; set; }

        private void UpdateValues()
        {
            // 값을 업데이트 하기 위한 sql 파트
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = ProMonitoring.GROUP_BY_DES_SELECT_QUERY;
                    SqlCommand com = new SqlCommand(query, conn);
                    SqlDataReader reader = com.ExecuteReader();

                    while (reader.Read())
                    {
                        string cityName = reader["Destination"].ToString();
                        int sumValue = Convert.ToInt32(reader["SUM"]);

                        switch (cityName)
                        {
                            case "서울":
                                SeoulValue = sumValue;
                                break;
                            case "부산":
                                BusanValue = sumValue;
                                break;
                            case "대구":
                                DaeguValue = sumValue;
                                break;
                        }
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            // 새로운 값으로 업데이트
            DestinationSeries[0].Values = new double[] { SeoulValue, BusanValue, DaeguValue };
        }
        #endregion


        #region 배송지 분류 콤보박스
        // 콤보박스에 값 진어넣기
        private void setComboBox()
        {
            Destinations.Add(new DestClassifications
            {
                Dest = "(전지역)"
            });

            try
            {
                using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
                {
                    conn.Open();

                    SqlCommand com1 = new SqlCommand(Orderlist.DESTINATION_SELECT_QUERY, conn);
                    SqlDataReader reader1 = com1.ExecuteReader();
                    while (reader1.Read())
                    {
                        Destinations.Add(new DestClassifications
                        {
                            Dest = reader1["Destination"].ToString()
                        });
                    }

                    reader1.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"오류 발생: {ex.Message}", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void CboDest_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(CboDest.SelectedIndex == 0)
            {
                LoadData();
            }
            else
            {
                LoadData(CboDest.SelectedValue.ToString());
            }
        }
        #endregion

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            CboDest.SelectedIndex = 0;
        }
    }
    public class DestClassifications
    {
        public string Dest { get; set; }
    }
}
