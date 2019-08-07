using BTL.MobileShop.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace BTL.MobileShop
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        void Session_Start(object sender, EventArgs e)
        {
            List<Cart> listCart = new List<Cart>();
            Session.Add("LogState",false);
            Session.Add("AccountID", null);
            Session.Add("NameUser", "Tài Khoản");
            Session.Add("ListCart",listCart);
        }
        void Session_End(object sender, EventArgs e)
        {
            Session["LogState"] = false;
            Session["AccountID"] = null;
            Session["NameUser"] = "Tài Khoản";
            Session["ListCart"] = null;
        }
    }
}