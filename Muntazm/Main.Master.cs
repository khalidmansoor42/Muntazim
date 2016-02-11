using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Muntazm
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["CompanyName"] != null)
            {
                lblCompanyName.Text = "Welcome to " + HttpContext.Current.Session["CompanyName"] .ToString();
            }
        }
    }
}