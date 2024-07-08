using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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

namespace Monitoring.Views
{
    /// <summary>
    /// Inventory.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class Inventory : UserControl
    {
        public Inventory()
        {
            InitializeComponent();
        }
        private string CONNSTRING = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            InitDateFormDB();
        }

        private void InitDateFormDB()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(CONNSTRING))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("SELECT i.*, p.* FROM [Inventory] i " +
                                                        "INNER JOIN [Product] p ON i.[ProductCode] = p.[ProductCode]",
                                                        connection);
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    GrdResult.ItemsSource = dataTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
