using System;
using System.Windows;
using System.Windows.Controls;
using MahApps.Metro.Controls.Dialogs;
using System.Data.SqlClient;
using System.Data;
using Monitoring.Models;
using System.Linq;
using LiveChartsCore.SkiaSharpView;
using LiveChartsCore.SkiaSharpView.Eto;
using LiveChartsCore;
using LiveChartsCore.SkiaSharpView.Painting;
using SkiaSharp;
using LiveChartsCore.SkiaSharpView.VisualElements;
using LiveChartsCore.SkiaSharpView.WPF;
using LiveChartsCore.SkiaSharpView.SKCharts;
using System.Collections.ObjectModel;
using Monitoring.Views.Models;
using System.Collections.Generic;

namespace Monitoring.Views
{
    public partial class Order : UserControl
    {
        private string connectionString = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";
        private DataTable dataTable; // 데이터 테이블을 클래스 레벨 변수로 선언
        private IDialogCoordinator _dialogCoordinator;

        public Order()
        {
            InitializeComponent();
            // 데이터 테이블 초기화
            dataTable = new DataTable();
            LoadData();
            CreateOrderChart();
        }

        private void LoadData()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Orders 테이블과 Delivery 테이블을 INNER JOIN하고 Product 테이블도 INNER JOIN하여 데이터 가져오는 쿼리
                    string query = Models.Orderlist.SELECT_QUERY;

                    SqlCommand command = new SqlCommand(query, connection);
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    // DataGrid에 데이터 바인딩
                    OrderDataGrid.ItemsSource = dataTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("데이터를 로드하는 동안 오류가 발생했습니다: " + ex.Message);
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (OrderDataGrid.SelectedItem != null)
            {
                DataRowView selectedRow = (DataRowView)OrderDataGrid.SelectedItem;
                string currentStatus = selectedRow["DeliveryStatus"].ToString();

                MessageBoxResult result = MessageBox.Show("정말 취소하시겠습니까?", "취소 확인", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    if (currentStatus == "배송준비중")
                    {
                        // 배송 상태 변경
                        selectedRow["DeliveryStatus"] = "배송취소";
                        // 주문 취소 여부 변경
                        selectedRow["CancelOrNot"] = "Y";

                        // 데이터 그리드를 업데이트하여 변경 사항을 화면에 반영
                        OrderDataGrid.Items.Refresh();

                        // DB에 즉시 반영
                        SaveChangesToDatabase(selectedRow);
                    }
                    else if (currentStatus == "배송완료" || currentStatus == "배송중")
                    {
                        MessageBox.Show("취소불가: 배송완료 또는 배송중 상태에서는 취소할 수 없습니다.");
                    }
                    else
                    {
                        MessageBox.Show("취소불가: 알 수 없는 배송 상태입니다.");
                    }
                }
            }
            else
            {
                MessageBox.Show("취소할 항목을 선택해주세요.");
            }
        }

        private void SaveChangesToDatabase(DataRowView selectedRow)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Delivery 테이블 업데이트
                    string updateDeliveryQuery = @"UPDATE Delivery
                                           SET DeliveryStatus = @DeliveryStatus
                                           WHERE DeliveryNum = @DeliveryNum";

                    SqlCommand updateDeliveryCommand = new SqlCommand(updateDeliveryQuery, connection);
                    updateDeliveryCommand.Parameters.AddWithValue("@DeliveryStatus", selectedRow["DeliveryStatus"]);
                    updateDeliveryCommand.Parameters.AddWithValue("@DeliveryNum", selectedRow["DeliveryNum"]);
                    updateDeliveryCommand.ExecuteNonQuery();

                    // Orders 테이블 업데이트
                    string updateOrdersQuery = @"UPDATE Orders
                                         SET CancelOrNot = @CancelOrNot, OrderDT = @OrderDT
                                         WHERE OrderNum = @OrderNum";

                    SqlCommand updateOrdersCommand = new SqlCommand(updateOrdersQuery, connection);
                    updateOrdersCommand.Parameters.AddWithValue("@CancelOrNot", selectedRow["CancelOrNot"]);
                    updateOrdersCommand.Parameters.AddWithValue("@OrderNum", selectedRow["OrderNum"]);
                    updateOrdersCommand.Parameters.AddWithValue("@OrderDT", selectedRow["OrderDT"]);
                    updateOrdersCommand.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("변경 내용을 저장하는 동안 오류가 발생했습니다: " + ex.Message);
            }
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            if (OrderDataGrid.SelectedItem != null)
            {
                DataRowView selectedRow = (DataRowView)OrderDataGrid.SelectedItem;

                // 데이터 업데이트
                if (OrderDT.SelectedDate.HasValue)
                {
                    selectedRow["OrderDT"] = OrderDT.SelectedDate.Value.ToString("yyyy-MM-dd");
                }

                if (DeliveryStatus.SelectedItem != null)
                {
                    selectedRow["DeliveryStatus"] = ((ComboBoxItem)DeliveryStatus.SelectedItem).Content.ToString();
                }

                selectedRow["CancelOrNot"] = CancelOrNot.Text;

                // DB에 즉시 반영
                SaveChangesToDatabase(selectedRow);

                // 데이터 그리드를 업데이트하여 변경 사항을 화면에 반영
                OrderDataGrid.Items.Refresh();
            }
            else
            {
                MessageBox.Show("저장할 항목을 선택해주세요.");
            }
        }


        private void Check_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // 데이터 테이블 초기화
                dataTable.Clear();

                // 데이터 다시 로드
                LoadData();
            }
            catch (Exception ex)
            {
                MessageBox.Show("데이터를 로드하는 동안 오류가 발생했습니다: " + ex.Message);
            }
        }

        private void OrderDataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (OrderDataGrid.SelectedItem != null)
            {
                // 선택된 행의 데이터 가져오기
                DataRowView selectedRow = (DataRowView)OrderDataGrid.SelectedItem;

                // 각각의 필드에 데이터 바인딩
                OrderNum.Text = selectedRow["OrderNum"].ToString();
                ProductName.Text = selectedRow["ProductName"].ToString();
                OrderDT.SelectedDate = DateTime.Parse(selectedRow["OrderDT"].ToString());
                DeliveryStatus.SelectedItem = DeliveryStatus.Items.Cast<ComboBoxItem>()
                    .FirstOrDefault(item => item.Content.ToString() == selectedRow["DeliveryStatus"].ToString());
                CancelOrNot.Text = selectedRow["CancelOrNot"].ToString();

                // DeliveryNum 가져오기
                string deliveryNum = selectedRow["DeliveryNum"].ToString();
            }
        }

        #region 주문 추이 그래프 영역

        private ObservableCollection<ISeries> OrderQuantities { get; set; }

        private ObservableCollection<Axis> OrderDates { get; set; }

        private string[] Dates { get; set; } 
        private List<OrderQuantity> GetOrderChartInfo()
        {
            var tempList = new List<OrderQuantity>();

            using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
            {
                conn.Open();
                string query = Orderlist.QUANTITY_SELECT_QUERY;
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    tempList.Add(new OrderQuantity()
                    {
                        OrderDT = reader["OrderDT"].ToString(),
                        Quantity = Convert.ToInt32(reader["Quantity"])
                    });
                }
            }
            return tempList;
        }
        private void CreateOrderChart()
        {
            var OrderList = GetOrderChartInfo();
                
            OrderQuantities = new ObservableCollection<ISeries>
            {

                new LineSeries<int>
                {
                    Values = new List<int>(OrderList.Select(ps => ps.Quantity)),
                    Fill = null,
                    //Name = "주문량",
                    YToolTipLabelFormatter = point => $"주문량: {point.PrimaryValue}개",
                }
            };

            Dates = OrderList.Select(ps => ps.OrderDT).ToArray();

            OrderDates = new ObservableCollection<Axis>
            {
                new Axis
                {
                    Labels = Dates,
                    TextSize = 10,
                    LabelsPaint = new SolidColorPaint
                    {
                        Color = SKColors.Black,
                        FontFamily = "NanumGothic"
                    },
                }
            };

            OrderChart.Series = OrderQuantities;
            OrderChart.XAxes = OrderDates;
            OrderChart.TooltipTextPaint = new SolidColorPaint
            {
                Color = SKColors.Black,
                FontFamily = "NanumGothic"
            };
        }
        #endregion
    }

    public class OrderQuantity
    {
        public string OrderDT { get; set; }
        public int Quantity { get; set; }
    }
}
