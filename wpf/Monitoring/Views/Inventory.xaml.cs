using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;

namespace Monitoring.Views
{
    /// <summary>
    /// Inventory.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class Inventory : UserControl
    {
        private string CONNSTRING = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";

        public Inventory()
        {
            InitializeComponent();
        }

        public void GetInventory()
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

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            GetInventory();
        }

        public void SaveInventory()
        {
            bool isNewInventory = string.IsNullOrEmpty(InventoryNum.Text);

            using (SqlConnection conn = new SqlConnection(CONNSTRING))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                if (isNewInventory)
                {
                    // INSERT query
                    cmd.CommandText = "INSERT INTO Inventory (ProductCode, Stock) VALUES (@ProductCode, @Stock)";
                }
                else
                {
                    // UPDATE query
                    cmd.CommandText = "UPDATE Inventory SET Stock = @Stock WHERE ProductCode = @ProductCode";
                    SqlParameter prmProductCode = new SqlParameter("@ProductCode", InventoryNum.Text);
                    cmd.Parameters.Add(prmProductCode);
                }

                SqlParameter prmStock = new SqlParameter("@Stock", int.Parse(Stock.Text));
                cmd.Parameters.Add(prmStock);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    string successMessage = isNewInventory ? "새로운 제고를 s추가했습니다." : "제고 정보를 수정했습니다.";
                    MessageBox.Show(successMessage, "저장 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                else
                {
                    MessageBox.Show("저장 중 오류가 발생했습니다.", "저장 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                }

                GetInventory();
                ClearControls();
            }
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            SaveInventory();
        }

        private void ClearControls()
        {
            InventoryNum.Text = string.Empty;
            ProductName.Text = string.Empty;
            Classification.Text = string.Empty;
            Stock.Text = string.Empty;
        }
    }
}
