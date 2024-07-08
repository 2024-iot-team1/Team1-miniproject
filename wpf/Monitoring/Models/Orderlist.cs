using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Models
{
    internal class Orderlist
    {
        public int OrderNum { get; set; }
        public int InventoryNum { get; set; }
        public int Quantity { get; set; }
        public DateTime? OrderDT { get; set; }
        public int DeliveryNum { get; set; }
        public string DeliveryStatus { get; set; }
        public DateTime StartDT { get; set; }
        public DateTime CompleteDT { get; set; }
        public string Destination { get; set; }
        public int ProductCode { get; set; }
        public string ProductName { get; set; }
        public int Price { get; set; }



        public static readonly string SELECT_QUERY = @"SELECT D.DeliveryNum,
                                                              D.OrderNum,
                                                              D.DeliveryStatus,
                                                              D.StartDT,
                                                              D.CompleteDT,
                                                              D.Destination,
                                                              O.InventoryNum,
                                                              O.Quantity,
                                                              O.OrderDT,
                                                              P.ProductCode,
                                                              P.ProductName,
                                                              P.Price
                                                         FROM [dbo].[Delivery] D
                                                        INNER JOIN [dbo].[Orders] O ON D.OrderNum = O.OrderNum
                                                        INNER JOIN [dbo].[Product] P ON O.InventoryNum = P.InventoryNum;";

        public static readonly string INSERT_QUERY = @"INSERT INTO [dbo].[Orders]
                                                                       ([OrderNum]
                                                                       ,[InventoryNum]
                                                                       ,[Quantity]
                                                                       ,[OrderDT])
                                                                 VALUES
                                                                       (@OrderNum
                                                                       ,@InventoryNum
                                                                       ,@Quantity
                                                                       ,@OrderDT);

                                                            INSERT INTO [dbo].[Delivery]
                                                                       ([DeliveryNum]
                                                                       ,[OrderNum]
                                                                       ,[DeliveryStatus]
                                                                       ,[StartDT]
                                                                       ,[CompleteDT]
                                                                       ,[Destination])
                                                                 VALUES
                                                                       (@DeliveryNum
                                                                       ,@OrderNum
                                                                       ,@DeliveryStatus
                                                                       ,@StartDT
                                                                       ,@CompleteDT
                                                                       ,@Destination);";

        public static readonly string UPDATE_QUERY = @"UPDATE O
                                                          SET O.OrderNum = @OrderNum,
                                                              O.InventoryNum = @InventoryNum,
                                                              O.Quantity = @Quantity,
                                                              O.OrderDT = @OrderDT
                                                         FROM [dbo].[Orders] O
                                                        INNER JOIN [dbo].[Delivery] D ON O.OrderNum = D.OrderNum
                                                        WHERE O.OrderNum = @OrderNum;

                                                       UPDATE D
                                                          SET D.DeliveryNum = @DeliveryNum,
                                                              D.DeliveryStatus = @DeliveryStatus,
                                                              D.StartDT = @StartDT,
                                                              D.CompleteDT = @CompleteDT,
                                                              D.Destination = @Destination
                                                         FROM [dbo].[Delivery] D
                                                        INNER JOIN [dbo].[Orders] O ON O.OrderNum = D.OrderNum
                                                        WHERE O.OrderNum = @OrderNum;";

        //public static readonly string DELETE_QUERY = @"DELETE FROM [dbo].[Orders] WHERE Id = @Id";
    }
}
