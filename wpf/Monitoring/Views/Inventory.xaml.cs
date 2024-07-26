using LiveChartsCore;
using LiveChartsCore.SkiaSharpView;
using LiveChartsCore.SkiaSharpView.Painting;
using Monitoring.Models;
using Monitoring.Views.Models;
using SkiaSharp;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows;
using System.Windows.Controls;

namespace Monitoring.Views
{
    public partial class Inventory : UserControl, INotifyPropertyChanged
    {
        private string CONNSTRING = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";

        public ObservableCollection<Classification> Classifications { get; set; }
        public ObservableCollection<Classification> Classifications2 { get; set; }

        private Classification _selectedClassification;
        public Classification SelectedClassification
        {
            get { return _selectedClassification; }
            set
            {
                _selectedClassification = value;
                OnPropertyChanged(nameof(SelectedClassification));
            }
        }
        public ObservableCollection<Alignment> Alignments { get; set; }

        private Alignment _selectedAlignment;

        public Alignment SelectedAlignment
        {
            get { return _selectedAlignment; }
            set
            {
                _selectedAlignment = value;
                OnPropertyChanged(nameof(SelectedAlignment));
            }
        }

        public static string AlignmentStandard {  get; set; }
        public Inventory()
        {
            InitializeComponent();
            DataContext = this;
            Classifications = new ObservableCollection<Classification>();
            Classifications2 = new ObservableCollection<Classification>();
            Alignments = new ObservableCollection<Alignment>();
            Classifications2.Add(new Classification
            {
                ClassificationCode = "0",
                ClassificationName = "(전체)"
            });

            DataContext = this;
            SetAlignments();
            LoadClassifications();
            CreateChart(0);
        }

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            CboClassification.SelectedIndex = 0;
            GetInventory();
        }

        private void SetAlignments()
        {
            List<Alignment> alignments = new List<Alignment>();
            string[] alignmentsName = { "상품코드", "상품명", "상품분류", "상품가격", "판매량", "재고 현황", "안전 재고", "조달 예정 물량" };
            string[] alignmentsCode = { "ProductCode", "ProductName", "ClassificationName", "Price", "InventoryNum", "SalesRate", "Stock", "SafeStock", "Procurement" };

            for (int i = 0; i < alignmentsName.Count(); i++)
            {
                Alignments.Add(new Alignment
                {
                    AlignmentName = alignmentsName[i],
                    AlignmentCode = alignmentsCode[i],
                });
            }
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            GetInventory();
        }

        // 데이터 그리드에 전체 값을 출력하는 함수
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

        
        // 콤보박스에 값을 집어넣는 함수
        private void LoadClassifications()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(CONNSTRING))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("SELECT ClassificationCode, ClassificationName FROM Classification", connection);
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Classifications.Add(new Classification
                        {
                            ClassificationCode = reader["ClassificationCode"].ToString(),
                            ClassificationName = reader["ClassificationName"].ToString()
                        });
                        Classifications2.Add(new Classification
                        {
                            ClassificationCode = reader["ClassificationCode"].ToString(),
                            ClassificationName = reader["ClassificationName"].ToString()
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"오류 발생: {ex.Message}", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SaveEmployee_Click(object sender, RoutedEventArgs e)
        {
            SaveInventory();
        }

        // 신규 상품 및 재고 추가
        private void SaveInventory()
        {
            string productCode = ProductCode.Text;
            string productName = ProductName.Text;
            string classification = SelectedClassification?.ClassificationCode;
            string priceStr = Price.Text;
            string stockStr = Stock.Text;

            if (!decimal.TryParse(priceStr, out decimal price) || !int.TryParse(stockStr, out int stock))
            {
                MessageBox.Show("유효하지 않은 가격 또는 재고량입니다. 숫자를 입력하세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(CONNSTRING))
                {
                    conn.Open();

                    SqlCommand checkProductCmd = new SqlCommand("SELECT COUNT(*) FROM Product WHERE ProductCode = @ProductCode", conn);
                    checkProductCmd.Parameters.AddWithValue("@ProductCode", productCode);
                    int productCount = (int)checkProductCmd.ExecuteScalar();

                    if (productCount > 0)
                    {
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
                            SqlCommand updateInventoryCmd = new SqlCommand(@"UPDATE Inventory 
                                                                            SET Stock = @Stock
                                                                            WHERE ProductCode = @ProductCode", conn);
                            updateInventoryCmd.Parameters.AddWithValue("@ProductCode", productCode);
                            updateInventoryCmd.Parameters.AddWithValue("@Stock", stock);
                            int resultInventory = updateInventoryCmd.ExecuteNonQuery();

                            if (resultInventory > 0)
                            {
                                Dispatcher.Invoke(() =>
                                {
                                    MessageBox.Show("제품 정보와 재고량을 업데이트했습니다.", "저장 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                                    GetInventory();
                                    ClearControls();
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
                        SqlCommand insertProductCmd = new SqlCommand(@"INSERT INTO Product (ProductCode, ProductName, Classification, Price) 
                                                                        VALUES (@ProductCode, @ProductName, @Classification, @Price)", conn);
                        insertProductCmd.Parameters.AddWithValue("@ProductCode", productCode);
                        insertProductCmd.Parameters.AddWithValue("@ProductName", productName);
                        insertProductCmd.Parameters.AddWithValue("@Classification", classification);
                        insertProductCmd.Parameters.AddWithValue("@Price", price);
                        int resultProduct = insertProductCmd.ExecuteNonQuery();

                        if (resultProduct > 0)
                        {
                            SqlCommand insertInventoryCmd = new SqlCommand(@"INSERT INTO Inventory (ProductCode, Stock) 
                                                                            VALUES (@ProductCode, @Stock)", conn);
                            insertInventoryCmd.Parameters.AddWithValue("@ProductCode", productCode);
                            insertInventoryCmd.Parameters.AddWithValue("@Stock", stock);
                            int resultInventory = insertInventoryCmd.ExecuteNonQuery();

                            if (resultInventory > 0)
                            {
                                Dispatcher.Invoke(() =>
                                {
                                    MessageBox.Show("새로운 제품과 재고량을 추가했습니다.", "저장 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                                    GetInventory();
                                    ClearControls();
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
            if (GrdResult.SelectedItem != null)
            {
                DataRowView row = (DataRowView)GrdResult.SelectedItem;
                string productCode = row["ProductCode"].ToString();
                string productName = row["ProductName"].ToString();
                string classificationName = row["ClassificationName"].ToString();
                decimal price = Convert.ToDecimal(row["Price"]);
                int stock = Convert.ToInt32(row["Stock"]);
                int inventoryNum = GetInventoryNum(productCode);

                ProductCode.Text = productCode;
                ProductName.Text = productName;
                SelectedClassification = Classifications.FirstOrDefault(c => c.ClassificationName == classificationName);
                Price.Text = price.ToString();
                Stock.Text = stock.ToString();
                InventoryNum.Text = inventoryNum.ToString();

                IsDeleteButtonEnabled = true;
            }
        }

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

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (GrdResult.SelectedItem != null)
            {
                DataRowView row = (DataRowView)GrdResult.SelectedItem;
                string productCode = row["ProductCode"].ToString();

                try
                {
                    using (SqlConnection conn = new SqlConnection(CONNSTRING))
                    {
                        conn.Open();

                        SqlCommand deleteInventoryCmd = new SqlCommand("DELETE FROM Inventory WHERE ProductCode = @ProductCode", conn);
                        deleteInventoryCmd.Parameters.AddWithValue("@ProductCode", productCode);
                        int resultInventory = deleteInventoryCmd.ExecuteNonQuery();

                        SqlCommand deleteProductCmd = new SqlCommand("DELETE FROM Product WHERE ProductCode = @ProductCode", conn);
                        deleteProductCmd.Parameters.AddWithValue("@ProductCode", productCode);
                        int resultProduct = deleteProductCmd.ExecuteNonQuery();

                        if (resultInventory > 0 && resultProduct > 0)
                        {
                            MessageBox.Show("제품과 재고량을 삭제했습니다.", "삭제 성공", MessageBoxButton.OK, MessageBoxImage.Information);
                            GetInventory();
                            ClearControls();
                        }
                        else
                        {
                            MessageBox.Show("제품 삭제 중 오류가 발생했습니다.", "삭제 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"오류 발생: {ex.Message}", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("삭제할 제품을 선택하세요.", "경고", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void ClearControls()
        {
            ProductCode.Text = string.Empty;
            ProductName.Text = string.Empty;
            SelectedClassification = null;
            Price.Text = string.Empty;
            Stock.Text = string.Empty;
            InventoryNum.Text = string.Empty;
        }

        private void BtnNew_Click(object sender, RoutedEventArgs e)
        {
            ClearControls();
        }

        public event PropertyChangedEventHandler PropertyChanged;

        private bool _isDeleteButtonEnabled;
        public bool IsDeleteButtonEnabled
        {
            get { return _isDeleteButtonEnabled; }
            set
            {
                _isDeleteButtonEnabled = value;
                OnPropertyChanged(nameof(IsDeleteButtonEnabled));
            }
        }

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void Price_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (decimal.TryParse(Price.Text.Replace(",", ""), out decimal value))
            {
                Price.TextChanged -= Price_TextChanged;
                Price.Text = string.Format("{0:N0}", value);
                Price.CaretIndex = Price.Text.Length;
                Price.TextChanged += Price_TextChanged;
            }
        }

        #region 상품별 판매량 차트

        private ObservableCollection<ISeries> _salesSeries;

        public ObservableCollection<ISeries> SalesSeries 
        {   
            get => _salesSeries;
            set
            {
                _salesSeries = value;
                OnPropertyChanged2();
            }
        }

        public event PropertyChangedEventHandler PropertyChanged2;

        protected void OnPropertyChanged2([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private ObservableCollection<Axis> _salesLabels;

        public ObservableCollection<Axis> SalesLabels 
        {
            get => _salesLabels;
            set
            {
                _salesLabels = value;
                OnPropertyChanged2();
            }
        }

        private SolidColorPaint _tooltipColors;

        public SolidColorPaint TooltipColors
        {
            get => _tooltipColors;
            set
            {
                _tooltipColors = value;
                OnPropertyChanged2();
            }
        }
        private string[] ProductNames { get; set; }
        private List<ProductSale> GetChartInfo(int align)
        {
            var productSales = new List<ProductSale>();

            using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
            {
                conn.Open();
                string query = "";
                if(align == 0)
                {
                    query = InventoryDB.SALES_SELECT_QUERY_DESC;
                }
                else if (align == 1) query = InventoryDB.SALES_SELECT_QUERY_ASC;

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    productSales.Add(new ProductSale()
                    {
                        ProductName = reader["ProductName"].ToString(),
                        Sales = Convert.ToInt32(reader["SalesRate"])
                    });
                }
            }
            return productSales;
        }

        private void CreateChart(int alignNum)
        {
            var productSales = GetChartInfo(alignNum);

            SalesSeries = new ObservableCollection<ISeries> 
            {
                new ColumnSeries<int>
                {
                    Values = new List<int>(productSales.Select(ps => ps.Sales)),
                    Name = "Sales",
                    Tag = new SolidColorPaint
                    {
                        Color = SKColors.Black,
                        FontFamily = "NanumGothic"
                    },
                    MaxBarWidth = 40,
                }
            };

            ProductNames = productSales.Select(ps => ps.ProductName).ToArray();

            SalesLabels = new ObservableCollection<Axis>
            {
                new Axis
                {
                    Labels = ProductNames,
                    TextSize = 15,
                    LabelsPaint = new SolidColorPaint
                    {
                        Color = SKColors.Black,
                        FontFamily = "NanumGothic"
                    },
                    
                }
            };

            TooltipColors =
                new SolidColorPaint
                {
                    Color = SKColors.Black,
                    FontFamily = "NanumGothic"
                };


            //SalesChart.Series = SalesSeries;
            //SalesChart.XAxes = SalesLabels;
        }

        #endregion

        // 상품 분류 필터 콤보박스 선택 변경
        private void CboClassification_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (Convert.ToInt32(CboClassification.SelectedValue) == 0)
            {
                GetInventory();
            }
            else
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(CONNSTRING))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(Models.InventoryDB.FILTER_SELECT_QUERY, connection);
                        command.Parameters.AddWithValue("@ClassificationCode", Convert.ToInt32(CboClassification.SelectedValue));
                    
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

        private void CboAlign_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(CboAlign.SelectedIndex == 0)
            {
                CreateChart(0);
            }
            if(CboAlign.SelectedIndex == 1)
            {
                CreateChart(1);
            }
        }
    }

    public class Classification
    {
        public string ClassificationCode { get; set; }
        public string ClassificationName { get; set; }
    }

    public class ProductSale
    {
        public string ProductName { get; set; }
        public int Sales { get; set; }
    }

    public class Alignment
    {
        public string AlignmentCode { get; set; }
        public string AlignmentName { get; set; }
    }
}
