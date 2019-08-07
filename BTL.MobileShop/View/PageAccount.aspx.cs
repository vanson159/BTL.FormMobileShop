using BTL.MobileShop.Data;
using System;
using System.Data;
using System.Data.SqlClient;
using BTL.MobileShop.Entity;
using System.Collections.Generic;
using System.Web.UI.WebControls;
// j=48;j<=57
namespace BTL.MobileShop.View
{
    public partial class PageAccount : System.Web.UI.Page
    {
        private DataAccess dataAccess = new DataAccess();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var statePage = Request.QueryString["pageState"].ToString();
                if (statePage == "signin")
                {
                    PlaceHolder_LogIn.Visible = false;
                }
                else if (statePage == "login")
                {
                    PlaceHolder_SignIn.Visible = false;
                }
            }
        }

        /// <summary>
        /// Hàm thực thi chức năng Login , Lưu trạng thái đăng nhập vào session
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void button_login_Click(object sender, EventArgs e)
        {
            // Lấy email và pass
            string email = txt_login_email.Text;
            string pass = txt_login_pass.Text;
            ViewState["Email"] = email;
            SqlCommand sqlCommand= dataAccess.SqlCommand;
            // Check email và pass đúng định dạng (nếu muốn check lại lần 2)

            // Thực thi SqlDataReader
            sqlCommand.CommandText = "[dbo].[Proc_Login_Account]";
            sqlCommand.Parameters.AddWithValue("@Email", email);
            sqlCommand.Parameters.AddWithValue("@Pass", pass);
            sqlCommand.Parameters.Add("@Name", SqlDbType.NVarChar, 100);
            sqlCommand.Parameters["@Name"].Direction = ParameterDirection.Output;
            SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
            // Lấy trạng thái đăng nhập
            bool stateLog = sqlDataReader.Read();
            // Lấy id của tài khoản
            int? accountID = null;
            if (stateLog == true)
            {
                accountID = Convert.ToInt32(sqlDataReader["AccountID"].ToString());
            }
            // Trước khi return output parameter phải thực thi xong SQLReader
            sqlDataReader.Close();
            string nameUser = sqlCommand.Parameters["@Name"].Value == null ? null : sqlCommand.Parameters["@Name"].Value.ToString();
            //Check trong db xem có bản ghi nào trùng không
            if (stateLog==true)
            {
                Session["LogState"] = true;
                Session["NameUser"] = nameUser;
                Session["AccountID"] = accountID;
                lbl_stateLog.Visible = true;
                lbl_stateLog.Text = "Đăng nhập thành công xin chào: " + nameUser;
                Response.Redirect("Index.aspx");
                Session.Timeout = 2;
            }
            else
            {
                lbl_stateLog.Visible = true;
                lbl_stateLog.Text = "Email hoặc Password không đúng";
                txt_login_pass.Text = null;
                txt_login_email.Text = (string)ViewState["Email"];
            }
        }
        
        /// <summary>
        /// Kiểm tra mật khẩu phải lớn hơn 6 kí tự và phải có 1 kí tự là chữ hoa
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        protected void Ct_Pass_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;
            int soluongKTH =0;
            string pass = args.Value.ToString();
            char[] arrChar = pass.ToCharArray();

            if (pass.Length >= 6)
            {
                for (int i = 0; i < arrChar.Length; i++)
                {
                    int ascii = Convert.ToInt32(arrChar[i]);
                    if (ascii > 65 && ascii <= 90)
                    {
                        soluongKTH ++;
                    }
                }
                if (soluongKTH == 0)
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = false;
            }
        }
        
        protected void Button_Signin_Click(object sender, EventArgs e)
        {
            string email = TextBox_Email.Text;
            string name = TextBox_Name.Text;
            string pass = TextBox_Pass.Text;
            if (IsValid == true)
            {
                dataAccess.SqlCommand.Parameters.AddWithValue("@Email", email);
                dataAccess.SqlCommand.Parameters.AddWithValue("@Name", name);
                dataAccess.SqlCommand.Parameters.AddWithValue("@Pass", pass);
                int stateSignin = dataAccess.ExecuteNonQuery("[dbo].[Proc_Add_Account]");
                if (stateSignin > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bạn đã đăng kí tài khoản thành công')", true);
                    
                }
            }
            
        }
    }
}