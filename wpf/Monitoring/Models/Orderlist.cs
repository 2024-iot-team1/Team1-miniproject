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



        public static readonly string SELECT_QUERY = @"
            ";

        public static readonly string INSERT_QUERY = @"
            ";

        //public static readonly string UPDATE_QUERY = @"";

        //public static readonly string DELETE_QUERY = @"DELETE FROM [dbo].[Orders] WHERE Id = @Id";
    }
}
