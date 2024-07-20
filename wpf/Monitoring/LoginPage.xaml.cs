using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;
using Monitoring.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Monitoring.Views
{
    /// <summary>
    /// LoginPage.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class LoginPage : MetroWindow
    {
        public bool IsLogin { get; set; } = false;
        public LoginPage()
        {
            InitializeComponent();
            TbxId.Focus();
        }

        private async void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            bool isFail = false;
            string errMsg = string.Empty;

            if (string.IsNullOrEmpty(TbxId.Text))
            {
                isFail = true;
                errMsg += "아이디를 입력해주세요.\n";
            }
            if (string.IsNullOrEmpty(TbxPassword.Password))
            {
                isFail = true;
                errMsg += "비밀번호를 입력해주세요.\n";
            }
            if (isFail == true)
            {
                await this.ShowMessageAsync("로그인 오류", errMsg);
            }
            IsLogin = LoginProcess();
            if (IsLogin == true) 
            {
                MainWindow mainWindow = new MainWindow();
                mainWindow.Show();
                this.Close();
            }

        }

        private bool LoginProcess()
        {
            // 입력된 아이디와 패스워드
            string userId = TbxId.Text;
            string password = TbxPassword.Password;

            // DB에서 가져온 아이디와 패스워드
            string checkId = string.Empty;
            string checkPass = string.Empty;

            try
            {
                using (SqlConnection conn = new SqlConnection(Common.CONNSTRING))
                {
                    conn.Open();

                    string query1 = Login.SELECT_QUERY;
                    SqlCommand cmd = new SqlCommand(query1, conn);

                    cmd.Parameters.AddWithValue("@ID", userId);
                    cmd.Parameters.AddWithValue("@PASSWORD", password);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        checkId = reader["ID"] != null ? reader["ID"].ToString() : "-"; // 유저 아이디가 null 일때 -로 변경
                        checkPass = reader["PASSWORD"] != null ? reader["PASSWORD"].ToString() : "-"; // 패스워드가 null 이면 -로 변경
                        Common.UserIdx = Convert.ToInt32(reader["UserIdx"]);
                        Common.UserName = reader["UserName"].ToString();

                        reader.Close();

                        string query2 = Login.INSERT_QUERY;
                        SqlCommand cmd2 = new SqlCommand(query2, conn);

                        cmd2.Parameters.AddWithValue("@UserIdx", Common.UserIdx);
                        cmd2.Parameters.AddWithValue("@ConnectDT", DateTime.Now);
                        cmd2.ExecuteNonQuery();
                        return true;
                    }
                    else
                    {
                        ErrorMsg();
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }

        }

        private async void ErrorMsg()
        {
            await this.ShowMessageAsync("로그인 오류", "로그인 정보가 없습니다.");
        }


        private void TbxPassword_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)             
            {
                BtnLogin_Click(sender, e);
            }
        }

        private void TbxId_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Tab)
            {
                TbxPassword.Focus();
            }
        }
    }
}
