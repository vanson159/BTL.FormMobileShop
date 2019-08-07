using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BTL.MobileShop.Data;
using BTL.MobileShop.Entity;

namespace BTL.MobileShop.View
{
    public partial class DetailProduct : System.Web.UI.Page
    {
        DataAccess dataAccess = new DataAccess();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int productID = Convert.ToInt32(Request.QueryString["id"]);
                    dataAccess.SqlCommand.Parameters.AddWithValue("@ProductID", productID);
                    formView_product.DataSource = dataAccess.ExecuteReader("[dbo].[Proc_Select_ProductByID]");
                    formView_product.DataBind();
                }

            }
        }
        /// <summary>
        /// Tính giá sau khi sale
        /// </summary>
        /// <param name="regularPrice"></param>
        /// <param name="discount"></param>
        /// <returns></returns>
        protected string DiscountPrice(object regularPrice, object discount)
        {
            decimal total;
            decimal regPrice = decimal.Parse(regularPrice.ToString());
            decimal disCount = decimal.Parse(discount.ToString());
            if (disCount != 0)
            {
                total = regPrice - (regPrice * (disCount / 100));
            }
            else
            {
                // Nếu giảm giá 0% thì tổng giá bằng giá gốc
                total = regPrice;
            }
            return string.Format(new CultureInfo("vi-VN"), "{0:#,##0}", total);
        }
        /// <summary>
        /// Hàm thực thi lệnh add sản phẩm vào giỏ hàng
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_AddProductToCard_Command(object sender, CommandEventArgs e)
        {
            // Kiểm tra trạng thái LoginState 
            // Nếu chưa Loggin thì giỏ hàng sẽ lưu ở Session (tạm thời chưa làm)
            // Nếu đã Login thì giỏ hàng lưu ở DB
            bool loginState = Convert.ToBoolean(Session["LogState"].ToString());
           
            if (loginState == true)
            {
                int productID = Convert.ToInt32(e.CommandArgument.ToString());
                int accountID = Convert.ToInt32(Session["AccountID"].ToString());

                dataAccess.SqlCommand.Parameters.AddWithValue("@ProductID", productID);
                dataAccess.SqlCommand.Parameters.AddWithValue("@AccountID", accountID);
                dataAccess.SqlCommand.Parameters.AddWithValue("@Amount", 1);
                dataAccess.SqlCommand.Parameters.AddWithValue("@OrdersDetailD", DBNull.Value);
                dataAccess.SqlCommand.Parameters.AddWithValue("@OrderState", 0);
                dataAccess.ExecuteNonQuery("[dbo].[Proc_Add_Orders]");
                // Chuyển hướng sang trang giỏ hàng
                Response.Redirect("CartPage.aspx");
            }
            else if (loginState == false)
            {
                //Xử lý add sản phẩm vào List , lưu trên session
                Cart cart = new Cart();
                int productID = Convert.ToInt32(e.CommandArgument.ToString());
                DataAccess dataAccess = new DataAccess();
                SqlCommand sqlCommand = dataAccess.SqlCommand;
                sqlCommand.Parameters.AddWithValue("@ProductID", productID);
                sqlCommand.CommandText = "[dbo].[Proc_Select_ProductByID]";
                DataSet dataSet = dataAccess.ExecuteSqlAdapter(sqlCommand);
                DataTable dataTable = dataSet.Tables[0];


                cart.ProductID =productID ;
                cart.ProductImage = dataTable.Rows[0]["ProductImage"].ToString();
                cart.ProductName = dataTable.Rows[0]["ProductName"].ToString();
                cart.ProductPrice = dataTable.Rows[0]["ProductImage"].ToString();
                cart.Amount = 1;
                List<Cart> listCart = (List<Cart>)Session["ListCart"];
                listCart.Add(cart);
                Response.Redirect("CartPage.aspx");
            }
        }
    }
}