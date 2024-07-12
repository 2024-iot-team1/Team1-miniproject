﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Views.Models
{
    public class InventoryDB
    {
        public string ProductName { get; set; }
        public int ProductCode { get; set; }
        public int Stock { get; set; }
        public int Price { get; set; }
        public int InventoryNum { get; set; }
        public int SalesRate { get; set; }
        public int SafeStock { get; set; }
        public int Procurement { get; set; }
        public string Classification { get; set; }


        public static readonly string SELECT_QUERY = @"SELECT p.[ProductCode]
                                                              ,p.[ProductName]
                                                              ,p.[Price]                                                              
                                                              ,p.[Classification]
                                                              ,i.[InventoryNum]
                                                              ,i.[SalesRate]
                                                              ,i.[Stock]
                                                              ,i.[SafeStock]
                                                              ,i.[Procurement]
                                                        FROM [AutoSortingDB].[dbo].[Product] p
                                                        INNER JOIN [AutoSortingDB].[dbo].[Inventory] i ON p.[ProductCode] = i.[ProductCode];";

        public static readonly string INSERT_QUERY = @"INSERT INTO [dbo].[Inventory]
                                                           ([ProductCode]
                                                           ,[SalesRate]
                                                           ,[Stock]
                                                           ,[SafeStock]
                                                           ,[Procurement])
                                                     VALUES
                                                           (@ProductCode
                                                           ,@SalesRate
                                                           ,@Stock
                                                           ,@SafeStock
                                                           ,@Procurement)
                                                        INSERT INTO [dbo].[Product]
                                                                   ([ProductCode]
                                                                   ,[ProductName]
                                                                   ,[Price]
                                                                   ,[Classification])
                                                             VALUES
                                                                   (@ProductCode
                                                                   ,@ProductName
                                                                   ,@Price
                                                                   ,@Classification)";

        public static readonly string UPDATE_QUERY = @"UPDATE [dbo].[Inventory]
                                                           SET [ProductCode] = @ProductCode
                                                              ,[SalesRate] = @SalesRate
                                                              ,[Stock] = @Stock
                                                              ,[SafeStock] = @SafeStock
                                                              ,[Procurement] = @Procurement
                                                         WHERE InventoryNum = @InventoryNum

                                                        UPDATE [dbo].[Product]

                                                           SET [ProductCode] = @ProductCode
                                                              ,[ProductName] = @ProductName
                                                              ,[Price] = @Price
                                                              ,[Classification] = @Classification
                                                         WHERE ProductCode = @ProductCode";
    }
}
