using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL.MobileShop.Entity
{
    public class Cart
    {
        public int ProductID { get; set; }
        public string ProductImage { get; set; }
        public string ProductName { get; set; }
        public string ProductPrice { get; set; }
        public int Amount { get; set; }
        
    }
}