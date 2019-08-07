using BTL.MobileShop.Data;
using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

namespace BTL.MobileShop.View
{
    public partial class FilterPage : System.Web.UI.Page
    {
        // Khởi tạo ADO
        private DataAccess dataAccess = new DataAccess();

        // Biến chỉ index của trang
        private int position = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Tạo 1 viewsate giữ chỉ số paging
                ViewState["pageIndex"] = 1;
                ViewState["SX"] = "";
                position = (int)ViewState["pageIndex"];

                float lowPrice;
                float hightPrice;
                int? brandID;
                string keySearch;

                try
                {
                    // Lấy Keysearch
                    keySearch = Request.QueryString["keySearch"].ToString();
                    // Thực thi truy vấn lọc
                    DataSet dataSet = GetDataByKeySearch(keySearch);
                    // Bind dữ liệu vào ListView
                    BindDataAndPaging(dataSet, ViewState["SX"].ToString());
                }
                catch (Exception)
                {
                    // Lấy khoảng giá
                    try
                    {
                        lowPrice = Convert.ToSingle(Request.QueryString["lprice"].ToString());
                        hightPrice = Convert.ToSingle(Request.QueryString["hprice"].ToString());
                    }
                    catch (Exception)
                    {
                        lowPrice = 1;
                        hightPrice = 3000000000;
                    }
                    // Lấy ID của hãng
                    try
                    {
                        brandID = Convert.ToInt32(Request.QueryString["brandID"].ToString());
                    }
                    catch (Exception)
                    {
                        brandID = null;
                    }
                    // Thực thi truy vấn sql
                    DataSet dataSet = GetDataByBrandIDAndPrice(brandID, lowPrice, hightPrice);
                    // Bind dữ liệu và phân trang
                    string sx = ViewState["SX"].ToString();
                    BindDataAndPaging(dataSet, sx);
                }
            }
        }

        /// <summary>
        /// Thực thi truy vấn lọc bản ghi trả về một dataset
        /// </summary>
        /// <param name="brandID"></param>
        /// <param name="lowPrice"></param>
        /// <param name="hightPrice"></param>
        /// <returns></returns>
        public DataSet GetDataByBrandIDAndPrice(int? brandID, float lowPrice, float hightPrice)
        {
            DataAccess dataAccess = new DataAccess();
            dataAccess.SqlCommand.CommandText = "[dbo].[Proc_Select_ProductByBrandAndPrice]";

            //Check xem BrandID có null không
            if (brandID != null)
            {
                dataAccess.SqlCommand.Parameters.AddWithValue("@BrandID", brandID);
            }
            else
            {
                dataAccess.SqlCommand.Parameters.AddWithValue("@BrandID", DBNull.Value);
            }
            dataAccess.SqlCommand.Parameters.AddWithValue("@LowPrice", lowPrice);
            dataAccess.SqlCommand.Parameters.AddWithValue("@HightPrice", hightPrice);
            DataSet dataSet = dataAccess.ExecuteSqlAdapter(dataAccess.SqlCommand);

            return dataSet;
        }

        /// <summary>
        /// Thực
        /// </summary>
        /// <param name="keySearch"></param>
        /// <returns></returns>
        public DataSet GetDataByKeySearch(string keySearch)
        {
            DataAccess dataAccess = new DataAccess();
            dataAccess.SqlCommand.CommandText = "[dbo].[Proc_Select_ProductByKeySearch]";
            dataAccess.SqlCommand.Parameters.AddWithValue("@KeySearch", keySearch);
            DataSet dataSet = dataAccess.ExecuteSqlAdapter(dataAccess.SqlCommand);
            return dataSet;
        }

        /// <summary>
        /// Thực thi PageDataSource (phân trang)
        /// </summary>
        /// <returns></returns>
        protected void BindDataAndPaging(DataSet dataSet, string sx)
        {
            // Đổ dữ liệu vào DataSource và phân trang
            PagedDataSource pagedDataSource = new PagedDataSource();
            DataView dataView = dataSet.Tables[0].DefaultView;
            if (sx != "")
            {
                if (sx == "ASC")
                {
                    dataView.Sort = "Price ASC";
                }
                else if (sx == "DESC")
                {
                    dataView.Sort = "Price DESC";
                }
            }
            // Phân trang bằng PageDataSource
            pagedDataSource.DataSource = dataView;
            pagedDataSource.AllowPaging = true;
            pagedDataSource.CurrentPageIndex = position - 1;
            pagedDataSource.PageSize = 15;
            Lable_CurrentPage.Text = position.ToString();
            Lable_TotalPage.Text = pagedDataSource.PageCount.ToString();
            // Kiểm tra xem có phải trang cuối cùng hoặc đầu tiên không, nếu đúng thì Disable 1 trong 2 button
            Button_Previous.Enabled = !pagedDataSource.IsFirstPage;
            Button_Next.Enabled = !pagedDataSource.IsLastPage;
            // Lấy toàn bộ các sản phẩm đổ vào ListView
            dataList_Product.DataSource = pagedDataSource;
            dataList_Product.DataBind();
        }

        protected void Button_Next_Click(object sender, EventArgs e)
        {
            position = Convert.ToInt32(ViewState["pageIndex"]);
            position++;
            ViewState["pageIndex"] = position;
            DataSet dataSet = GetDataByBrandIDAndPrice(null, 1, 1000000000);
            BindDataAndPaging(dataSet, ViewState["SX"].ToString());
        }

        protected void Button_Previous_Click(object sender, EventArgs e)
        {
            position = Convert.ToInt32(ViewState["pageIndex"]);
            position = position == 1 ? 1 : position = position - 1;
            ViewState["pageIndex"] = position;
            DataSet dataSet = GetDataByBrandIDAndPrice(null, 1, 1000000000);
            BindDataAndPaging(dataSet, ViewState["SX"].ToString());
        }

        protected void dataList_Product_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Show")
            {
                string strId = dataList_Product.DataKeys[e.Item.ItemIndex].ToString();
                Response.Redirect("DetailProduct.aspx?id=" + strId);
            }
        }

        /// <summary>
        /// Tính giá sau khi sale
        /// Chú ý tính kiểu này thì sẽ sort giá không đúng, tài vì sort nó chạy trên ADO
        /// </summary>
        /// <param name = "regularPrice" ></ param >
        /// < param name="discount"></param>
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

        protected void Button_Tang_Click(object sender, EventArgs e)
        {
            ViewState["SX"] = "ASC";
            DataSet dataSet = GetDataByBrandIDAndPrice(null, 1, 10000000000);
            BindDataAndPaging(dataSet, ViewState["SX"].ToString());
        }

        protected void Button_Giam_Click(object sender, EventArgs e)
        {
            ViewState["SX"] = "DESC";
            DataSet dataSet = GetDataByBrandIDAndPrice(null, 1, 10000000000);
            BindDataAndPaging(dataSet, ViewState["SX"].ToString());
        }
    }
}