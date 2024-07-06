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
                    // Orders 테이블과 Delivery 테이블을 Inner Join 하여 데이터 가져오는 쿼리
                    string query = @"SELECT O.OrderNum, O.InventoryNum, O.Quantity, O.OrderDT, D.DeliveryDate
                                     FROM Orders O
                                     INNER JOIN Delivery D ON O.OrderNum = D.OrderNum";

                    SqlCommand command = new SqlCommand("SELECT * FROM [Orders]", connection);
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

    }
}
