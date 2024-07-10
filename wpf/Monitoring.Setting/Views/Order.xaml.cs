using System;
using System.Collections.Generic;
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
using System.Data.SqlClient;
using System.Data;
using Monitoring.Models;
using System.Diagnostics;

namespace Monitoring.Views
{
    public partial class Order : UserControl
    {
        private string connectionString = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";
        private DataTable dataTable; // 데이터 테이블을 클래스 레벨 변수로 선언

        public Order()
        {
            InitializeComponent();
            // 데이터 테이블 초기화
            dataTable = new DataTable();
        }

        private void LoadData()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Orders 테이블과 Delivery 테이블을 INNER JOIN하고 Product 테이블도 INNER JOIN하여 데이터 가져오는 쿼리
                    string query = Orderlist.SELECT_QUERY;

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



        private void Save_Click(object sender, RoutedEventArgs e)
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

                    SqlDataAdapter deliveryAdapter = new SqlDataAdapter();
                    SqlCommand updateDeliveryCommand = new SqlCommand(updateDeliveryQuery, connection);
                    updateDeliveryCommand.Parameters.Add("@DeliveryStatus", SqlDbType.NVarChar, 50, "DeliveryStatus");
                    updateDeliveryCommand.Parameters.Add("@DeliveryNum", SqlDbType.Int, 0, "DeliveryNum");
                    deliveryAdapter.UpdateCommand = updateDeliveryCommand;

                    // Orders 테이블 업데이트
                    string updateOrdersQuery = @"UPDATE Orders
                                         SET Quantity = @Quantity,
                                             OrderDT = @OrderDT,
                                             CancelOrNot = @CancelOrNot
                                         WHERE OrderNum = @OrderNum";

                    SqlDataAdapter ordersAdapter = new SqlDataAdapter();
                    SqlCommand updateOrdersCommand = new SqlCommand(updateOrdersQuery, connection);
                    updateOrdersCommand.Parameters.Add("@Quantity", SqlDbType.Int, 0, "Quantity");
                    updateOrdersCommand.Parameters.Add("@OrderDT", SqlDbType.DateTime, 0, "OrderDT");
                    updateOrdersCommand.Parameters.Add("@CancelOrNot", SqlDbType.NVarChar, 1, "CancelOrNot");
                    updateOrdersCommand.Parameters.Add("@OrderNum", SqlDbType.Int, 0, "OrderNum");
                    ordersAdapter.UpdateCommand = updateOrdersCommand;

                    // 변경 사항 확인 후 처리
                    foreach (DataRow row in dataTable.Rows)
                    {
                        if (row.RowState == DataRowState.Modified)
                        {
                            if (row.Table.Columns.Contains("DeliveryStatus") && row.Table.Columns.Contains("DeliveryNum"))
                            {
                                deliveryAdapter.Update(new DataRow[] { row });
                            }
                            else if (row.Table.Columns.Contains("Quantity") && row.Table.Columns.Contains("OrderDT") && row.Table.Columns.Contains("CancelOrNot"))
                            {
                                // 주문 취소 여부를 업데이트하기 위해 실제 데이터에서 가져와서 변경합니다.
                                DataRow originalRow = dataTable.AsEnumerable().FirstOrDefault(r => r.Field<int>("OrderNum") == row.Field<int>("OrderNum"));
                                if (originalRow != null)
                                {
                                    row["CancelOrNot"] = originalRow["CancelOrNot"];
                                }
                                ordersAdapter.Update(new DataRow[] { row });
                            }
                        }
                    }

                    // 데이터베이스에 변경 사항을 반영
                    deliveryAdapter.Update(dataTable.Select(null, null, DataViewRowState.ModifiedCurrent));
                    ordersAdapter.Update(dataTable.Select(null, null, DataViewRowState.ModifiedCurrent));

                    // 데이터 그리드를 업데이트하여 변경 사항을 화면에 반영
                    OrderDataGrid.Items.Refresh();

                    MessageBox.Show("변경 사항이 저장되었습니다.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("변경 사항을 저장하는 동안 오류가 발생했습니다: " + ex.Message);
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
                OrderDT.Text = selectedRow["OrderDT"].ToString();
                DeliveryStatus.Text = selectedRow["DeliveryStatus"].ToString();
                CancelOrNot.Text = selectedRow["CancelOrNot"].ToString();
            }
        }
    }
}