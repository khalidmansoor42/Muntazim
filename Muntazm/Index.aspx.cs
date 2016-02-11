using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Muntazm
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            
        }

        [WebMethod(EnableSession = true)]
        public static string DoLogOut()
        {
            if (HttpContext.Current.Session["UserName"] != null && HttpContext.Current.Session["CompanyName"] != null)
            {
                HttpContext.Current.Session["UserName"] = null;
                HttpContext.Current.Session["CompanyName"] = null;
            }
            return "You have been logged out successfully.";
        }
    }
}