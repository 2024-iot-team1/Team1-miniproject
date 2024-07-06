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
using MahApps.Metro.Controls;

namespace Monitoring
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        public MainWindow()
        {
            InitializeComponent();
            //ActiveItem.Content = new Views.ProcessMonitoring();
            //StsSelScreen.Content = "모니터링";
        }

        private void Monitoring_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.ProcessMonitoring();
            StsSelScreen.Content = "모니터링";
        }

        private void Order_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Order();
            StsSelScreen.Content = "주문 목록 모니터링";
        }

        private void Product_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Product();
            StsSelScreen.Content = "상품 목록 모니터링";
        }

        private void Inventory_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Inventory();
            StsSelScreen.Content = "재고 목록 모니터링";
        }

        private void Setting_Click(object sender, RoutedEventArgs e)
        {
            ActiveItem.Content = new Views.Setting();
            StsSelScreen.Content = "시스템 모니터링";
        }
    }
}
