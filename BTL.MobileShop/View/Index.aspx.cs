using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using BTL.MobileShop.Data;
using System.Globalization;

namespace BTL.MobileShop.View
{
    public partial class index : System.Web.UI.Page , System.Web.UI.ICallbackEventHandler
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind dữ liệu vào DataList
                dataList_hotPhone.DataSource = GetProductByCategoryID(1);
                dataList_newPhone.DataSource = GetProductByCategoryID(2);
                dataList_cameraPhone.DataSource = GetProductByCategoryID(3);
                dataList_hotPhone.DataBind();
                dataList_newPhone.DataBind();
                dataList_cameraPhone.DataBind();
            }
            // Khởi tạo đối tượng ClientScript -- > Quản lý script ở client
            ClientScriptManager cm = Page.ClientScript;
            // Chỉ định các tham số và hàm xử lý kết quả sau khi RaiseCallBackEvent được thực thi
            // Trả về tên của script function , tên function này sẽ được gọi ở hàm CallServer bên dưới
            string cbReference = cm.GetCallbackEventReference(this, "args", "HandleResultReiseCallBack", "");
            // Khởi tạo 1 script function liên kiết với callback server
            // Hàm này có thể gọi ở bất kì đâu trong các sự kiện của client
            string cbScript = "function CallServer(args,context){" + cbReference + ";}";
            cm.RegisterClientScriptBlock(this.GetType(), "CallServer", cbScript, true);
        }

        /// <summary>
        /// Thực thi PageDataSource (phân trang) lấy sản phẩm dựa vòa mã loại sản phẩm
        /// </summary>
        /// <param name="categoryID"></param>
        /// <param name=""></param>
        /// <returns></returns>
        protected PagedDataSource GetProductByCategoryID(int categoryID)
        {
            DataAccess dataAccess = new DataAccess();
            dataAccess.SqlCommand.CommandText = "[dbo].[Proc_Select_ProductByCategoryID]";
            dataAccess.SqlCommand.Parameters.AddWithValue("@CategoryID", categoryID);
            DataSet dataSet = dataAccess.ExecuteSqlAdapter(dataAccess.SqlCommand);

            PagedDataSource pagedDataSource = new PagedDataSource();
            pagedDataSource.DataSource = dataSet.Tables[0].DefaultView;
            pagedDataSource.AllowPaging = true;
            pagedDataSource.CurrentPageIndex = 0;
            pagedDataSource.PageSize = 5;

            return pagedDataSource;
        }
        /// <summary>
        /// Tính giá sau khi sale
        /// </summary>
        /// <param name="regularPrice"></param>
        /// <param name="discount"></param>
        /// <returns></returns>
        protected string DiscountPrice(object regularPrice,object discount)
        {
            decimal total;
            decimal regPrice= decimal.Parse(regularPrice.ToString());
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

        protected void dataList_hotPhone_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Show")
            {
                string strId = dataList_hotPhone.DataKeys[e.Item.ItemIndex].ToString();
                Response.Redirect("DetailProduct.aspx?id=" + strId);
            }
        }

        protected void dataList_newPhone_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Show")
            {
                string strId = dataList_newPhone.DataKeys[e.Item.ItemIndex].ToString();
                Response.Redirect("DetailProduct.aspx?id=" + strId);
            }
        }

        protected void dataList_cameraPhone_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Show")
            {
                string strId = dataList_cameraPhone.DataKeys[e.Item.ItemIndex].ToString();
                Response.Redirect("DetailProduct.aspx?id=" + strId);
            }
        }

        string textSearch;
        /// <summary>
        /// Hàm xử lý call back ajax gửi đến
        /// </summary>
        /// <param name="eventArgument">Tham số của hàm gọi call back</param>
        /// NVSON: 8/5/2019
        public void RaiseCallbackEvent(string eventArgument)
        {
            try
            {
                string textSearch = "FilterPage.aspx?keySearch=" + eventArgument;
            }
            catch (Exception ex)
            {
                string er = ex.Message;
            }

        }

        public string GetCallbackResult()
        {
            return textSearch;
        }
    }
}