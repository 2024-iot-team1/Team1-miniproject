using System;
using System.Collections.Generic;
using System.Diagnostics;
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
    /// Setting.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class Setting : UserControl
    {
        public Setting()
        {
            InitializeComponent();

        }

     

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string flaskServerUrl = "http://192.168.5.3:8081/";
            try
            {
                Process.Start(new ProcessStartInfo(flaskServerUrl) { UseShellExecute = true });

            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to load the webcam streaming: " + ex.Message);
            }

        }
    }
}
