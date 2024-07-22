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
        public string Destination { get; set; }
        public DateTime ProcessDT { get; set; }
        public char CompleteOrNot { get; set; }

        public static readonly string SELECT_QUERY = @"SELECT W.[WorkNum]
                                                             ,W.[OrderNum]
                                                             ,W.[DeliveryNum]
                                                             ,D.[Destination]
                                                             ,W.[ProcessDT]
                                                             ,W.[CompleteOrNot]
                                                         FROM [dbo].[WorkStatus] W
                                                        INNER JOIN [dbo].[Delivery] D ON W.DeliveryNum = D.DeliveryNum";

        public static readonly string FILTER_SELECT_QUERY = @"SELECT W.[WorkNum]
                                                                    ,W.[OrderNum]
                                                                    ,W.[DeliveryNum]
                                                                    ,D.[Destination]
                                                                    ,W.[ProcessDT]
                                                                    ,W.[CompleteOrNot]
                                                                FROM [dbo].[WorkStatus] W
                                                               INNER JOIN [dbo].[Delivery] D ON W.DeliveryNum = D.DeliveryNum
                                                               WHERE D.Destination = @Destination";

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

        public static readonly string GROUP_BY_DES_SELECT_QUERY = @"SELECT Destination, COUNT(WorkNum) AS 'SUM'　
                                                                  FROM (SELECT w.WorkNum, d.OrderNum, d.Destination
		                                                                  FROM WorkStatus AS w,
			                                                                   Delivery AS d
		                                                                  WHERE w.OrderNum = d.OrderNum) AS a
                                                                 GROUP BY Destination";

        public static readonly string GROUP_BY_PRO_SELECT_QUERY = @"SELECT i.ProductName, SUM(Quantity) AS Sales
                                                                      FROM Orders AS o,
	                                                                       (SELECT InventoryNum, ProductName
		                                                                      FROM Product as p,
			                                                                       Inventory as i
		                                                                     WHERE p.ProductCode = i.ProductCode) AS i
                                                                     WHERE o.InventoryNum = i.InventoryNum
                                                                     GROUP BY i.ProductName";

        public static readonly string UPDATE_WORKSTATUS = @"UPDATE WorkStatus
                                                               SET CompleteOrNot = 'Y'
                                                             WHERE OrderNum = @OrderNum";

        public static readonly string ORDERNUM_SELECT_QUERY = @"SELECT COUNT(*)
                                                                  FROM WorkStatus
                                                                 WHERE OrderNum = @OrderNum";

        public static readonly string STATUS_SELECT_QUERY = @"SELECT *
                                                                FROM Delivery
                                                               WHERE DeliveryStatus IN ('배송중','배송완료','주문취소')
                                                                 AND OrderNum = 1112112;";    
    }
}
