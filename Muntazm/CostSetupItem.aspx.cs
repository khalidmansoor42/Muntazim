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
    public partial class CostSetupItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {

            }
        }

        [WebMethod]
        public static string LoadMainHeadCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT id, description from costsetupItemMainhead Order By [id]";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<String, Object>();

                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);

                }

                rows.Add(row);
            }

            db.Con.Close();
            db = null;
            return serializer.Serialize(rows);
        }

        [WebMethod]
        public static string GetMaxId(string Prefix = "")
        {
            DBClass db = new DBClass("SCM");
            return db.GetMaxId(Prefix, 2, "id", "CostsetupItem");
        }

        [WebMethod]
        public static string Add(string CatagoryCode, string Description, string SubHeadCode, string MarketingOverhead, string VariableExpense)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT COUNT(*) FROM [CostsetupItem] WHERE [id]='" + CatagoryCode + "' AND [Description]='" + Description + "'";
            if ((Int32)db.Com.ExecuteScalar() > 0)
                return "Error: Same data already exists.";
            db.Com.CommandText = String.Format("INSERT INTO [CostsetupItem] ([id],[Description],[subheadid],[VariableExpense],[MarketingOverhead]) VALUES ('{0}','{1}','{2}','{3}','{4}')", CatagoryCode, Description, SubHeadCode, MarketingOverhead, VariableExpense);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record added successfully.";
        }

        [WebMethod]
        public static string LoadSubHeadCombo(string MainHeadCode)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT [id],[description] from costsetupItemSubhead WHERE [MainHeadId] = '" + MainHeadCode + "' Order By  [id] ";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<String, Object>();

                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);

                }

                rows.Add(row);
            }

            db.Con.Close();
            db = null;
            return serializer.Serialize(rows);
        }


        [WebMethod]
        public static string DeleteRow(string RowId)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            //db.Com.CommandText = String.Format("SELECT COUNT(*) FROM [CostsetupItem] WHERE [id]='{0}'", RowId);
            //if ((Int32)db.Com.ExecuteScalar() > 0)
            //    return "Error: Catagory is In-Use.";
            db.Com.CommandText = String.Format("DELETE FROM [CostsetupItem] WHERE [id]='{0}'", RowId);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record deleted successfully.";
        }


        [WebMethod]
        public static string Update(string id, string Description, string MarketingOverhead, string VariableExpense)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = String.Format("UPDATE [CostsetupItem] SET [description]='{0}', [MarketingOverhead]='{1}', [VariableExpense]='{2}'  WHERE [id]='{3}'", Description, MarketingOverhead, VariableExpense,id);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record updated successfully.";
        }

        [WebMethod]
        public static string FillGrid(int PageNumber, int PageSize, string filter)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }
            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT [id] , [Description], MarketingOverhead, VariableExpense FROM [CostsetupItem] " + filter + " Order By [id] ";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DataTable paggedtable = new DataTable();
            paggedtable = dt.Clone();
            int initial = (PageNumber - 1) * PageSize + 1;
            int last = initial + PageSize;

            for (int i = initial - 1; i < last - 1; i++)
            {
                if (i >= dt.Rows.Count)
                {
                    break;
                }
                paggedtable.ImportRow(dt.Rows[i]);
            }

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in paggedtable.Rows)
            {
                row = new Dictionary<String, Object>();

                foreach (DataColumn col in paggedtable.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);

                }

                rows.Add(row);
            }

            db.Con.Close();
            db = null;
            return String.Format("{{\"total\":{0},\"rows\":{1}}}", dt.Rows.Count, serializer.Serialize(rows));
        }

        [WebMethod]
        public static string GetRow(string RowId)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }
            
            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT [id],[Description] FROM [CostsetupItem] WHERE [id] = '" + RowId + "'";
            SqlDataReader dr = db.Com.ExecuteReader();
            JavaScriptSerializer serailizer = new JavaScriptSerializer();
            Cost Cost = new Cost();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    Cost.id = dr[0].ToString();
                    Cost.Description = dr[1].ToString();
                    //Catagory.MarketingOverhead = dr[2].ToString();
                    //Catagory.VariableExpense = dr[3].ToString();
                }
            }

            if (dr.IsClosed == false)
                dr.Close();

            db.Con.Close();
            db = null;
            return serailizer.Serialize(Cost);
        }
        public class Cost
        {
            public string id, Description, MarketingOverhead, VariableExpense;
        }
    }
}