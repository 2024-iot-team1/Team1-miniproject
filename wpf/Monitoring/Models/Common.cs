using MahApps.Metro.Controls.Dialogs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Models
{
    internal class Common
    {
        public static readonly string CONNSTRING = "Server=localhost;Database=AutoSortingDB;User Id=sa;Password=mssql_p@ss";

        public static IDialogCoordinator DialogCoordinator { get; set; }
    }
}
