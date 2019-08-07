using BTL.MobileShop.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL.MobileShop
{
    public partial class SiteGrid : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string logState = Request.QueryString["login"] == null ? null : Request.QueryString["login"].ToString();
                if (logState == "out")
                {
                    Session["LogState"] = false;
                    Session["AccountID"] = null;
                    Session["NameUser"] = "Tài Khoản";
                    lbl_nameAcc.Text = Session["NameUser"].ToString();
                }
                else
                {
                    lbl_nameAcc.Text = Session["NameUser"].ToString();
                }
                
            }
        }

        protected void Button_Search_Click(object sender, EventArgs e)
        {
            var textSearch = TextBox_Search.Text;
            Response.Redirect("FilterPage?keySearch=" + textSearch);
        }
    }
}