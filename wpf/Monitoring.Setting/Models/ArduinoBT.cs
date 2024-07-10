using System;
using System.Collections.Generic;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Models
{
    internal class ArduinoBT
    {
        // 온습도 정보 수신용 블루투스 연결
        public SerialPort serialPort01;

        // 컨베이어 벨트 블루투스 연결
        public SerialPort serialPort02;

        // USB 포트를 위한 블루트스 연결
        public SerialPort serialPort03;
    }
}
