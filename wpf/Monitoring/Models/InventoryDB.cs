using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Views.Models
{
    public class InventoryDB
    {
        public int InventoryNum { get; set; }
        public int ProductCode { get; set; }
        public int SalesRate { get; set; }
        public int Stock { get; set; }
        public int SafeStock { get; set; }
        public int Procurement { get; set; }

        public static readonly string SELECT_QUERY = @"SELECT [InventoryNum]
                                                            , [ProductCode]
                                                            , [SalesRate]
                                                            , [Stock]
                                                            , [SafeStock]
                                                            , [Procurement]
                                                         FROM [dbo].[Inventory]";
    }

}
