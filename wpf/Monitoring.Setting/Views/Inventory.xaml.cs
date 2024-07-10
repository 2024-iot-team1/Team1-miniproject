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

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            GetInventory(); // 조회 버튼 클릭 시 인벤토리 데이터 조회
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

        private void SaveEmployee_Click(object sender, RoutedEventArgs e)
        {
            SaveInventory();
        }

        private void SaveInventory()
        {
            // Fetch ProductCode, ProductName, Classification, and Price from UI
            string productCode = ProductCode.Text;
            string productName = ProductName.Text;
            string classification = Classification.Text;
            string priceStr = Price.Text;
            string stockStr = Stock.Text; // New field: Stock

            // Convert string inputs to numeric types
            decimal price;
            int stock;

            bool isPriceValid = decimal.TryParse(priceStr, out price);
            bool isStockValid = int.TryParse(stockStr, out stock);

            if (!isPriceValid || !isStockValid)
            {
                MessageBox.Show("유효하지 않은 가격 또는 재고량입니다. 숫자를 입력하세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(CONNSTRING))
                {
                    conn.Open();

                    // Check if ProductCode already exists in Product table
                    SqlCommand checkProductCmd = new SqlCommand("SELECT COUNT(*) FROM Product WHERE ProductCode = @ProductCode", conn);
                    checkProductCmd.Parameters.AddWithValue("@ProductCode", productCode);
                    int productCount = (int)checkProductCmd.ExecuteScalar();

                    if (productCount > 0)
                    {
                        // UPDATE Product query: Update existing product in Product table
                        SqlCommand updateProductCmd = new SqlCommand(@"UPDATE Product 
                                                          SET ProductName = @ProductName,
                                                              Classification = @Classification,
                                                              Price = @Price
                                                          WHERE ProductCode = @ProductCode", conn);
                        updateProductCmd.Parameters.AddWithValue("@ProductCode", productCode);
                        updateProductCmd.Parameters.AddWithValue("@ProductName", productName);
                        updateProductCmd.Parameters.AddWithValue("@Classification", classification);
                        updateProductCmd.Parameters.AddWithValue("@Price", price);

                        int resultProduct = updateProductCmd.ExecuteNonQuery();

                        if (resultProduct > 0)
                        {
                            // UPDATE Inventory query: Update Stock in Inventory table
                            SqlCommand updateInventoryCmd = new SqlCommand(@"UPDATE Inventory 
                                                                SET Stock = @Stock
                                                                WHERE ProductCode = @ProductCode", conn);
                            updateInventoryCmd.Parameters.AddWithValue("@ProductCode", productCode);
                            updateInventoryCmd.Parameters.AddWithValue("@Stock", stock);

                            int resultInventory = updateInventoryCmd.ExecuteNonQuery();

                            if (resultInventory > 0)
                            {
                                // UI update is performed using Dispatcher to ensure it runs on the UI thread
                                Dispatcher.Invoke(() =>
                                {
                                    MessageBox.Show("제품 정보와 재고량을 업데이트했습니다.", "저장 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                                    GetInventory(); // Reload data after save to update the grid
                                    ClearControls(); // Clear input controls
                                });
                            }
                            else
                            {
                                MessageBox.Show("재고량 업데이트 중 오류가 발생했습니다.", "저장 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                            }
                        }
                        else
                        {
                            MessageBox.Show("제품 정보 업데이트 중 오류가 발생했습니다.", "저장 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                    }
                    else
                    {
                        // INSERT Product query: Add new product to Product table with provided ProductCode
                        SqlCommand insertProductCmd = new SqlCommand(@"INSERT INTO Product (ProductCode, ProductName, Classification, Price) 
                                                          VALUES (@ProductCode, @ProductName, @Classification, @Price)", conn);
                        insertProductCmd.Parameters.AddWithValue("@ProductCode", productCode);
                        insertProductCmd.Parameters.AddWithValue("@ProductName", productName);
                        insertProductCmd.Parameters.AddWithValue("@Classification", classification);
                        insertProductCmd.Parameters.AddWithValue("@Price", price);

                        int resultProduct = insertProductCmd.ExecuteNonQuery();

                        // INSERT Inventory query: Add new product to Inventory table
                        if (resultProduct > 0)
                        {
                            SqlCommand insertInventoryCmd = new SqlCommand(@"INSERT INTO Inventory (ProductCode, Stock) 
                                                                VALUES (@ProductCode, @Stock)", conn);
                            insertInventoryCmd.Parameters.AddWithValue("@ProductCode", productCode);
                            insertInventoryCmd.Parameters.AddWithValue("@Stock", stock);

                            int resultInventory = insertInventoryCmd.ExecuteNonQuery();

                            if (resultInventory > 0)
                            {
                                // UI update is performed using Dispatcher to ensure it runs on the UI thread
                                Dispatcher.Invoke(() =>
                                {
                                    MessageBox.Show("새로운 제품과 재고량을 추가했습니다.", "저장 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                                    GetInventory(); // Reload data after save to update the grid
                                    ClearControls(); // Clear input controls
                                });
                            }
                            else
                            {
                                MessageBox.Show("Inventory에 제품 추가 중 오류가 발생했습니다.", "저장 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                            }
                        }
                        else
                        {
                            MessageBox.Show("Product에 제품 추가 중 오류가 발생했습니다.", "저장 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"오류 발생: {ex.Message}", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void GrdResult_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // 데이터 그리드에서 선택한 행의 데이터를 UI 컨트롤에 표시
            if (GrdResult.SelectedItem != null)
            {
                DataRowView row = (DataRowView)GrdResult.SelectedItem;
                string productCode = row["ProductCode"].ToString();
                string productName = row["ProductName"].ToString();
                string classification = row["Classification"].ToString();
                decimal price = Convert.ToDecimal(row["Price"]);
                int stock = Convert.ToInt32(row["Stock"]);

                // InventoryNum 가져오기
                int inventoryNum = GetInventoryNum(productCode);

                // UI 컨트롤에 데이터 출력
                ProductCode.Text = productCode;
                ProductName.Text = productName;
                Classification.Text = classification;
                Price.Text = price.ToString();
                Stock.Text = stock.ToString();
                InventoryNum.Text = inventoryNum.ToString(); // InventoryNum도 UI에 출력
            }
        }

        // InventoryNum 가져오는 메서드
        private int GetInventoryNum(string productCode)
        {
            int inventoryNum = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(CONNSTRING))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT InventoryNum FROM Inventory WHERE ProductCode = @ProductCode", conn);
                    cmd.Parameters.AddWithValue("@ProductCode", productCode);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        inventoryNum = Convert.ToInt32(result);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"오류 발생: {ex.Message}", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            return inventoryNum;
        }



        private void ClearControls()
        {
            ProductCode.Text = string.Empty;
            ProductName.Text = string.Empty;
            Classification.Text = string.Empty;
            Price.Text = string.Empty;
            Stock.Text = string.Empty;
            InventoryNum.Text = string.Empty;
        }

        private void BtnNew_Click(object sender, RoutedEventArgs e)
        {
            // 새로운 제품 등록을 위해 UI 초기화
            ProductCode.Text = string.Empty;
            ProductName.Text = string.Empty;
            Classification.Text = string.Empty;
            Price.Text = string.Empty;
            Stock.Text = string.Empty;
            InventoryNum.Text = string.Empty;

            // InventoryNum은 자동 증가되므로 여기서 초기화만 해주면 됩니다.
        }
    }
}
