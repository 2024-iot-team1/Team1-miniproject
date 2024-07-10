using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Models
{
    internal class ProMonitoring
    {
        public int WorkNum { get; set; }
        public int OrderNum { get; set; }
        public int DeliveryNum { get; set; }
        public DateTime ProcessDT { get; set; }
        public char CompleteOrNot { get; set; }

        public static readonly string SELECT_QUERY = @"SELECT [WorkNum]
                                                             ,[OrderNum]
                                                             ,[DeliveryNum]
                                                             ,[ProcessDT]
                                                             ,[CompleteOrNot]
                                                         FROM [dbo].[WorkStatus]";

        public static readonly string DESTINATION_SELECT_QUERY = @"SELECT Destination
                                                                        , DeliveryNum
                                                                     FROM Delivery
                                                                    WHERE OrderNum = @OrderNum";

        public static readonly string INSERT_QUERY = @"INSERT INTO [dbo].[WorkStatus]
                                                               ( OrderNum
                                                               , DeliveryNum
                                                               , ProcessDT
                                                               , CompleteOrNot)
                                                         VALUES
                                                               (@OrderNum
                                                               ,@DeliveryNum
                                                               ,@ProcessDT
                                                               ,@CompleteOrNot)";

        public static readonly string DELIVERY_UPDATE_QUERY = @"UPDATE DELIVERY
                                                                   SET DeliveryStatus = '배송중' 
                                                                     , StartDT = @StartDT
                                                                 WHERE OrderNum = @OrderNum";
    }
}
