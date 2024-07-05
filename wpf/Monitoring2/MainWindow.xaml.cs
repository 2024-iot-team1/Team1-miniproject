using System.Text;
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
using System.ComponentModel;
using System.Diagnostics;
using System.CodeDom;

namespace Monitoring2
{
    public partial class MainWindow : MetroWindow
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        //private void Monitoring_Click(object sender, RoutedEventArgs e)
        //{
        //    //ActiveItem.Content = new Views.MainWindow();
        //}

        //private void Order_Click(object sender, RoutedEventArgs e)
        //{
        //    ActiveItem.Content = new Views.Order();
        //    StsSelScreen.Content = "주문 목록 모니터링";
        //}

        //private void Product_Click(object sender, RoutedEventArgs e)
        //{
        //    ActiveItem.Content = new Views.Product();
        //    StsSelScreen.Content = "재고 목록 모니터링";
        //}

        //private void System_Click(object sender, RoutedEventArgs e)
        //{
        //    ActiveItem.Content = new Views.System();
        //    StsSelScreen.Content = "시스템 모니터링";
        //}
    }
}