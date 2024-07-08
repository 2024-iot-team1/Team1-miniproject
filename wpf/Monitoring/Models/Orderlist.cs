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
        public int SalesRate { get; set; }
        public int Stock {  get; set; }
        public int SafeStock { get; set; }
        public int Procurement { get; set; }
        


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
                                                       P.Price,
                                                       I.InventoryNum,
                                                       I.ProductCode
                                                FROM [dbo].[Delivery] D
                                                INNER JOIN [dbo].[Orders] O ON D.OrderNum = O.OrderNum
                                                INNER JOIN [dbo].[Inventory] I ON O.InventoryNum = I.InventoryNum
                                                INNER JOIN [dbo].[Product] P ON I.ProductCode = P.ProductCode;";

        public static readonly string INSERT_QUERY = @"INSERT INTO [dbo].[Product]
                                                                       ([ProductCode]
                                                                       ,[ProductName]
                                                                       ,[Price])
                                                                 VALUES
                                                                       (@ProductCode
                                                                       ,@ProductName
                                                                       ,@Price);

                                                            INSERT INTO [dbo].[Orders]
                                                                       ([OrderNum]
                                                                       ,[InventoryNum]
                                                                       ,[Quantity]
                                                                       ,[OrderDT])
                                                                 VALUES
                                                                       (@OrderNum
                                                                       ,@InventoryNum
                                                                       ,@Quantity
                                                                       ,@OrderDT);

                                                            INSERT INTO [dbo].[Inventory]
                                                                       ([InventoryNum]
                                                                       ,[ProductCode]
                                                                       ,[SalesRate]
                                                                       ,[Stock]
                                                                       ,[SafeStock]
                                                                       ,[Procurement])
                                                                 VALUES
                                                                       (@InventoryNum
                                                                       ,@ProductCode
                                                                       ,@SalesRate
                                                                       ,@Stock
                                                                       ,@SafeStock
                                                                       ,@Procurement);

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

        public static readonly string UPDATE_QUERY = @"UPDATE P
                                                          SET P.ProductCode = @ProductCode,
                                                              P.ProductName = @ProductName,
                                                              P.Price = @Price
                                                         FROM [dbo].[Product] P
                                                   INNER JOIN [dbo].[Inventory] I ON P.ProductCode = I.ProductCode
                                                   INNER JOIN [dbo].[Orders] O ON I.InventoryNum = O.InventoryNum
                                                   INNER JOIN [dbo].[Delivery] D ON O.OrderNum = D.OrderNum
                                                        WHERE P.ProductCode = @ProductCode AND I.InventoryNum = @InventoryNum AND O.OrderNum = @OrderNum AND D.DeliveryNum = @DeliveryNum;

                                                       UPDATE O
                                                          SET O.OrderNum = @OrderNum,
                                                              O.InventoryNum = @InventoryNum,
                                                              O.Quantity = @Quantity,
                                                              O.OrderDT = @OrderDT
                                                         FROM [dbo].[Orders] O
                                                   INNER JOIN [dbo].[Inventory] I ON O.InventoryNum = I.InventoryNum
                                                   INNER JOIN [dbo].[Product] P ON I.ProductCode = P.ProductCode
                                                   INNER JOIN [dbo].[Delivery] D ON O.OrderNum = D.OrderNum
                                                        WHERE O.OrderNum = @OrderNum AND I.InventoryNum = @InventoryNum AND P.ProductCode = @ProductCode AND D.DeliveryNum = @DeliveryNum;

                                                       UPDATE I
                                                          SET I.InventoryNum = @InventoryNum,
                                                              I.ProductCode = @ProductCode,
                                                              I.SalesRate = @SalesRate,
                                                              I.Stock = @Stock,
                                                              I.SafeStock = @SafeStock,
                                                              I.Procurement = @Procurement
                                                         FROM [dbo].[Inventory] I
                                                   INNER JOIN [dbo].[Product] P ON I.ProductCode = P.ProductCode
                                                   INNER JOIN [dbo].[Orders] O ON I.InventoryNum = O.InventoryNum
                                                   INNER JOIN [dbo].[Delivery] D ON O.OrderNum = D.OrderNum
                                                        WHERE I.InventoryNum = @InventoryNum AND P.ProductCode = @ProductCode AND O.OrderNum = @OrderNum AND D.DeliveryNum = @DeliveryNum;

                                                       UPDATE D
                                                          SET D.DeliveryNum = @DeliveryNum,
                                                              D.OrderNum = @OrderNum,
                                                              D.DeliveryStatus = @DeliveryStatus,
                                                              D.StartDT = @StartDT,
                                                              D.CompleteDT = @CompleteDT,
                                                              D.Destination = @Destination
                                                         FROM [dbo].[Delivery] D
                                                   INNER JOIN [dbo].[Orders] O ON D.OrderNum = O.OrderNum
                                                   INNER JOIN [dbo].[Inventory] I ON O.InventoryNum = I.InventoryNum
                                                   INNER JOIN [dbo].[Product] P ON I.ProductCode = P.ProductCode
                                                        WHERE D.DeliveryNum = @DeliveryNum AND O.OrderNum = @OrderNum AND I.InventoryNum = @InventoryNum AND P.ProductCode = @ProductCode;";

        //public static readonly string DELETE_QUERY = @"DELETE FROM [dbo].[Orders] WHERE Id = @Id";
    }
}
