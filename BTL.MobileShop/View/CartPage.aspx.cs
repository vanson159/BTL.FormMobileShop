using BTL.MobileShop.Data;
using BTL.MobileShop.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;

namespace BTL.MobileShop.View
{
    public partial class CartPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bool loginState = Convert.ToBoolean(Session["LogState"].ToString());
                if (loginState == true)
                {
                    AttactDataToGrid();
                }
                else
                {
                    // Xử lý lấy danh sách sản phẩm đã add từ session ra
                    GridView_Cart.DataSource = (List<Cart>)Session["ListCart"];
                    GridView_Cart.DataBind();
                }
            }
        }

        /// <summary>
        /// Lấy dữ liệu đơn hàng và attact vào grid
        /// </summary>
        /// NVSON: 8/5/2019
        public void AttactDataToGrid()
        {
            DataAccess dataAccess = new DataAccess();
            int accID = Convert.ToInt32(Session["AccountID"].ToString());
            SqlCommand sqlCommand = dataAccess.SqlCommand;
            sqlCommand.Parameters.AddWithValue("@AccountID", accID);
            sqlCommand.CommandText = "[dbo].[Proc_Select_ProductInOrders]";
            DataSet dataSet = dataAccess.ExecuteSqlAdapter(sqlCommand);
            if (dataSet.Tables[0].Rows.Count > 0)
            {
                double tongtien = 0;
                GridView_Cart.Visible = true;
                GridView_Cart.DataSource = dataSet.Tables[0].DefaultView;
                GridView_Cart.DataBind();

                DataTable dataTable = dataSet.Tables[0];
                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    double price = Convert.ToDouble(dataTable.Rows[i]["ProductPrice"].ToString());
                    int amount = Convert.ToInt32(dataTable.Rows[0]["Amount"].ToString());
                    double pricePro = price * amount;
                    tongtien = tongtien + pricePro;
                }
                lbl_totalPrice.Text = tongtien.ToString("#,###", CultureInfo.GetCultureInfo("vi-VN").NumberFormat);
            }
            else
            {
                GridView_Cart.Visible = false;
                lbl_state.Visible = true;
            }
        }

        protected void Button_Delete_Command(object sender, CommandEventArgs e)
        {
            DataAccess dataAccess = new DataAccess();
            int productID = Convert.ToInt32(e.CommandArgument);
            int accountID = Convert.ToInt32(Session["AccountID"].ToString());
            dataAccess.SqlCommand.Parameters.AddWithValue("ProductID", productID);
            dataAccess.SqlCommand.Parameters.AddWithValue("AccountID", accountID);
            dataAccess.ExecuteNonQuery("[dbo].[Proc_Delete_Orders]");
            AttactDataToGrid();
            Response.Redirect("CartPage.aspx");
        }
    }
}