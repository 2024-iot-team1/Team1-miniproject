﻿using System;
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
                    string query = @"SELECT O.OrderNum, P.ProductCode, P.ProductName,
                                    O.Quantity, O.OrderDT, 
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
                MessageBox.Show("데이터를 로드하는 동안 오류가 발생했습니다: " + ex.Message);
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (OrderDataGrid.SelectedItem != null)
            {
                DataRowView selectedRow = (DataRowView)OrderDataGrid.SelectedItem;
                selectedRow["DeliveryStatus"] = "배송취소";
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

                    DataTable changedDataTable = ((DataView)OrderDataGrid.ItemsSource).Table;

                    SqlDataAdapter adapter = new SqlDataAdapter();

                    // Delivery 테이블 업데이트
                    string updateDeliveryQuery = @"UPDATE Delivery
                                                   SET DeliveryStatus = @DeliveryStatus
                                                   WHERE DeliveryNum = @DeliveryNum";

                    adapter.UpdateCommand = new SqlCommand(updateDeliveryQuery, connection);
                    adapter.UpdateCommand.Parameters.Add("@DeliveryStatus", SqlDbType.NVarChar, 50, "DeliveryStatus");
                    adapter.UpdateCommand.Parameters.Add("@DeliveryNum", SqlDbType.Int, 0, "DeliveryNum");

                    // Orders 테이블 업데이트
                    string updateOrdersQuery = @"UPDATE Orders
                                                 SET Quantity = @Quantity,
                                                     OrderDT = @OrderDT
                                                 WHERE OrderNum = @OrderNum";

                    adapter.InsertCommand = new SqlCommand(updateOrdersQuery, connection);
                    adapter.InsertCommand.Parameters.Add("@Quantity", SqlDbType.Int, 0, "Quantity");
                    adapter.InsertCommand.Parameters.Add("@OrderDT", SqlDbType.DateTime, 0, "OrderDT");
                    adapter.InsertCommand.Parameters.Add("@OrderNum", SqlDbType.Int, 0, "OrderNum");

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
