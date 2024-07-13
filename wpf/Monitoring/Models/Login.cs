using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Monitoring.Models
{
    internal class Login
    {
        public static readonly string SELECT_QUERY = @"SELECT [UserIdx]
                                                      ,[UserName]
                                                      ,[ID]
                                                      ,[PASSWORD]
                                                  FROM [dbo].[Users]
                                                 WHERE ID = @ID
                                                   AND PASSWORD = @PASSWORD";

        public static readonly string INSERT_QUERY = @"INSERT INTO [dbo].[ConnectLog]
                                                                   ([UserIdx]
                                                                   ,[ConnectDT])
                                                             VALUES
                                                                   (@UserIdx
                                                                   ,@ConnectDT)";
    }
}
