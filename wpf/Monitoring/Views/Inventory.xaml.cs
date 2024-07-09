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
        private int selectedInventoryNum = -1; // 선택된 제고번호

        public Inventory()
        {
            InitializeComponent();
            GetInventory(); // 초기화 시 인벤토리 데이터 조회
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            GetInventory();
        }

        public void GetInventory()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(CONNSTRING))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(Models.InventoryDB.SELECT_QUERY, connection);
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

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            SaveInventory();
        }

        private void SaveInventory()
        {
            // Fetch ProductName and Classification from UI
            string productName = ProductName.Text;
            string classification = Classification.Text;

            using (SqlConnection conn = new SqlConnection(CONNSTRING))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                if (selectedInventoryNum == -1)
                {
                    // INSERT query
                    cmd.CommandText = @"INSERT INTO Product (ProductCode,ProductName, Classification) 
                                        VALUES (@ProductCode, @ProductName, @Classification);
                                        INSERT INTO Inventory (ProductCode) 
                                        VALUES (SCOPE_IDENTITY())";
                    cmd.Parameters.AddWithValue("@ProductCode", ProductCode);
                    cmd.Parameters.AddWithValue("@ProductName", productName);
                    cmd.Parameters.AddWithValue("@Classification", classification);
                }
                else
                {
                    // UPDATE query without Stock, SafeStock, Procurement
                    cmd.CommandText = @"UPDATE Product 
                                        SET ProductName = @ProductName,
                                            Classification = @Classification
                                        WHERE ProductCode = @ProductCode;
                                        UPDATE Inventory 
                                        SET ProductCode = @ProductCode
                                        WHERE InventoryNum = @InventoryNum";
                    cmd.Parameters.AddWithValue("@InventoryNum", selectedInventoryNum);
                    cmd.Parameters.AddWithValue("@ProductCode", ProductCode.Text);
                    cmd.Parameters.AddWithValue("@ProductName", productName);
                    cmd.Parameters.AddWithValue("@Classification", classification);
                }

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    string successMessage = selectedInventoryNum == -1 ? "새로운 제품을 추가했습니다." : "제품 정보를 수정했습니다.";
                    MessageBox.Show(successMessage, "저장 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                    GetInventory(); // 저장 후 데이터 다시 조회하여 그리드에 반영
                    ClearControls(); // 입력 컨트롤 초기화
                }
                else
                {
                    MessageBox.Show("저장 중 오류가 발생했습니다.", "저장 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private void GrdResult_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // 데이터 그리드에서 선택한 행의 데이터를 UI 컨트롤에 표시
            if (GrdResult.SelectedItem != null)
            {
                DataRowView row = (DataRowView)GrdResult.SelectedItem;
                selectedInventoryNum = Convert.ToInt32(row["InventoryNum"]);
                ProductCode.Text = row["ProductCode"].ToString();
                ProductName.Text = row["ProductName"].ToString();
                Classification.Text = row["Classification"].ToString();
            }
        }

        private void ClearControls()
        {
            InventoryNum.Text = string.Empty;
            ProductCode.Text = string.Empty;
            ProductName.Text = string.Empty;
            Classification.Text = string.Empty;
        }
    }
}
