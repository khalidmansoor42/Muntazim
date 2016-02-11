using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace Muntazm
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillCombo();
            }
        }

        public void FillCombo()
        {
            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "Select [CompCode], [CompName] from [Companies]";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptCompanies.DataSource = dt;
            rptCompanies.DataBind();
            db.Con.Close();
            db = null;
        }

        [WebMethod(EnableSession=true)]
        public static string DoLogin(string UserName, string Password, string CompanyId, string CompanyName)
        {
            DBClass db = new DBClass("Muntazm");
            string result;
            db.Con.Open();
            db.Com.CommandText = "SELECT COUNT(*) FROM [Users] WHERE [UserName]='" + UserName + "' AND [Password]='" + Password + "'";
            if ((Int32)db.Com.ExecuteScalar() == 1)
            {
                result = "You have been logged-in successfully.";
                HttpContext.Current.Session["UserName"] = UserName;
                HttpContext.Current.Session["CompanyId"] = CompanyId;
                HttpContext.Current.Session["CompanyName"] = CompanyName;
            }
            else
            {
                result = "Error: Invalid User name or Password.";
            }
            db.Con.Close();
            db = null;
            return result;
        }
    }
}