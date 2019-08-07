using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace BTL.MobileShop.Commons
{
    public class Context
    {
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
    }
}