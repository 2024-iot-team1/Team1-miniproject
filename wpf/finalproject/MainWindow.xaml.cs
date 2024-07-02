using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;
using System.Diagnostics;
using System.Web;
using System.Windows;
using System.Windows.Input;
using System.Windows.Controls;
using System.Text;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;
using finalproject.Models;
using System.Windows.Media.Imaging;
using Microsoft.Data.SqlClient;
using CefSharp.DevTools.Page;
using System.Data;

namespace finalproject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void doLogin()
        {
            
        }

        private void MetroWindow_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            doLogin();
        }
    }
}