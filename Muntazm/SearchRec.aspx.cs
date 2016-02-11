using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;

namespace Muntazm
{
    public partial class SearchRec : System.Web.UI.Page
    {
         protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        [WebMethod]
        public static string FillTable(string filter)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Muntazm");
            db.Con.Open();
            /*if(String.IsNullOrEmpty(filter))
                db.Com.CommandText = "SELECT TOP 8 [UserID],[UserName],[Status] FROM [Users]";
            else*/
            db.Com.CommandText = "SELECT  [CurCode],[CurDesc] FROM [Currencies] WHERE [CurDesc] LIKE '%" + filter + "%'";
            SqlDataReader dr = db.Com.ExecuteReader();
            string tableRows = "";
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    tableRows = tableRows + String.Format("<tr><td>{0}</td><td>{1}</td></tr>", dr[0].ToString(), dr[1].ToString());
                }
            }
            db.Con.Close();
            db = null;
            return tableRows;
        }
        

        [WebMethod]

        public static string GetRow(string RowId)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Muntazm");
            db.Con.Open();
            db.Com.CommandText = "SELECT [CurCode],[CurDesc] FROM [Currencies] WHERE [CurCode] ='"+ RowId +"'";
            SqlDataReader dr = db.Com.ExecuteReader();
            JavaScriptSerializer serailizer = new JavaScriptSerializer();
            SurchResult SurchResult = new SurchResult();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    SurchResult.SurCode = dr[0].ToString();
                    SurchResult.SurDescription = dr[1].ToString();
                    //curriencies.DecimalDescription = dr[2].ToString();
                    //curriencies.Status = dr[3].ToString();
                    
                }
            }

            if (dr.IsClosed == false)
                dr.Close();

            db.Con.Close();
            db = null;
            return serailizer.Serialize(SurchResult);
        }
    }

    public class SurchResult
    {
        public string SurCode,SurDescription;
    }
    
}