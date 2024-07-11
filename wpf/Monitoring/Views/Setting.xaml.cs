﻿using System;
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
using System.Diagnostics;
using System.IO;
using System.Runtime.Remoting.Channels;
using System.IO.Ports;
using System.IdentityModel.Protocols.WSTrust;


namespace Monitoring.Views
{
    /// <summary>
    /// Setting.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class Setting : UserControl
    {
        private Process _flaskProcess;

        private SerialPort port;

        MainWindow MainWindow { get; set; }

        public Setting()
        {
            InitializeComponent();
        }

        public Setting(MainWindow e)
        {
            InitializeComponent();
            MainWindow = e;
            port = MainWindow._serialPort01;
        }

        private void OnButton_Click(object sender, RoutedEventArgs e)
        {
            if (_flaskProcess == null)
            {
                StartFlaskServer();
            }

            ChromeWeb.Address = "http://210.119.12.59:18088/";
        }

        private void OffButton_Click(object sender, RoutedEventArgs e)
        {
            if (_flaskProcess != null)
            {
                StopFlaskServer();
            }

            ChromeWeb.Address = "about:blank";
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            string fanStatus = string.Empty;
            string buzzStatus = string.Empty;

            if (SwitchFan.IsOn)
            {
                fanStatus = "1";
            }
            else fanStatus = "0";

            if (SwitchBuzz.IsOn) buzzStatus = "1";
            else buzzStatus = "0";

            string setting_data = fanStatus + "," + buzzStatus + "," + TempNum.Value.ToString() + "," + HumidNum.Value.ToString();
            port.WriteLine(setting_data);
        }

        private void StartFlaskServer()
        {
            var startInfo = new ProcessStartInfo
            {
                FileName = "python",
                Arguments = "\"C:\\Sources\\Team1-miniproject\\CCTV\\gdsb_cctv_project\\cctv#3 flask webcam with text.py\"",
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true,
            };

            _flaskProcess = new Process
            {
                StartInfo = startInfo
            };

            _flaskProcess.OutputDataReceived += (sender, args) => Debug.WriteLine(args.Data);
            _flaskProcess.ErrorDataReceived += (sender, args) => Debug.WriteLine(args.Data);

            _flaskProcess.Start();
            _flaskProcess.BeginOutputReadLine();
            _flaskProcess.BeginErrorReadLine();
        }

        private void StopFlaskServer()
        {
            if (_flaskProcess != null && !_flaskProcess.HasExited)
            {
                _flaskProcess.Kill();
                _flaskProcess.Dispose();
                _flaskProcess = null;
            }
        }
    }
}
