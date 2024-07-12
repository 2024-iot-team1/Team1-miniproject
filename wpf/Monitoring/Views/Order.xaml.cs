using System;
using System.Windows;
using System.Windows.Controls;
using MahApps.Metro.Controls.Dialogs;
using System.Data.SqlClient;
using System.Data;
using Monitoring.Models;
using System.Linq;

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
    }
}
