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

namespace Monitoring.Views
{
    /// <summary>
    /// Order.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class Order : UserControl
    {
        private string connectionString = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";

        public Order()
        {
            InitializeComponent();
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
                    string query = @"SELECT O.OrderNum, P.ProductCode, P.ProductName, P.Price,
                                    O.InventoryNum, O.Quantity, O.OrderDT, 
                                    D.DeliveryNum, D.DeliveryStatus, D.StartDT, D.CompleteDT, D.Destination
                             FROM Orders O
                             INNER JOIN Delivery D ON O.OrderNum = D.OrderNum
                             INNER JOIN Product P ON O.InventoryNum = P.InventoryNum";

                    SqlCommand command = new SqlCommand(query, connection);
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    OrderDataGrid.ItemsSource = dataTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }


        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            // 현재 선택된 항목이 있는지 확인
            if (OrderDataGrid.SelectedItem != null)
            {
                // 선택된 항목을 DataRowView로 캐스팅
                DataRowView selectedRow = (DataRowView)OrderDataGrid.SelectedItem;

                // 배송 상태 열의 값을 "배송 취소"로 변경
                selectedRow["DeliveryStatus"] = "배송취소";

                // 변경 사항을 데이터 그리드에 반영
                OrderDataGrid.Items.Refresh();
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

                    // 데이터 그리드에서 변경된 데이터를 가져오기
                    DataTable changedDataTable = ((DataView)OrderDataGrid.ItemsSource).Table;

                    // SqlDataAdapter를 사용하여 변경 사항을 데이터베이스에 반영
                    SqlDataAdapter adapter = new SqlDataAdapter();

                    // UpdateCommand를 설정하여 변경 사항을 데이터베이스에 반영
                    string updateQuery = @"UPDATE Delivery
                                   SET DeliveryStatus = @DeliveryStatus
                                   WHERE OrderNum = @OrderNum";

                    adapter.UpdateCommand = new SqlCommand(updateQuery, connection);
                    adapter.UpdateCommand.Parameters.Add("@DeliveryStatus", SqlDbType.NVarChar, 50, "DeliveryStatus");
                    adapter.UpdateCommand.Parameters.Add("@OrderNum", SqlDbType.Int, 0, "OrderNum");

                    // 변경된 데이터를 SqlDataAdapter에 적용하여 데이터베이스에 업데이트
                    adapter.Update(changedDataTable);

                    MessageBox.Show("변경 사항이 저장되었습니다.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("변경 사항을 저장하는 동안 오류가 발생했습니다: " + ex.Message);
            }
        }
    }
}
