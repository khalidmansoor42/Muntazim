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
    public partial class SetupCostMainHead : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["username"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {

            }
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
            if (String.IsNullOrEmpty(filter))
                db.Com.CommandText = "SELECT [id] ,[description] FROM [costsetupItemMainhead] ORDER BY [id]";
            else
                db.Com.CommandText = "SELECT [id] ,[description] FROM [costsetupItemMainhead] WHERE [id] LIKE '%" + filter + "%' OR [description] LIKE '%" + filter + "%' ORDER BY [id] ";
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
        public static string Add(string id, string description, string branchID, string AGglCode, string FOglCode, string SDglCode, string COGSglCOde)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT COUNT(*) FROM [SetupLocation] WHERE [id]='" + id + "' AND [description]='" + description + "'";
            if ((Int32)db.Com.ExecuteScalar() > 0)
                return "Error: Same data already exists.";
            db.Com.CommandText = String.Format("INSERT INTO [costsetupItemMainhead] ([id],[description]) VALUES ('{0}','{1}')", id, description);
            db.Com.ExecuteNonQuery();
            db.Com.CommandText = String.Format("INSERT INTO [costsetupOverheadMainheadGlCode] ([MohID],[BranchID],[AGglCode],[FOglCode],[SDglCode],[COGSglCOde]) VALUES ('{0}','{1}','{2}','{3}','{4}','{5}')", id, branchID, AGglCode, FOglCode, SDglCode, COGSglCOde);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record added successfully.";
        }

        [WebMethod]
        public static string GetMaxId()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            string Id;
            db.Con.Open();
            db.Com.CommandText = String.Format("SELECT CAST(isNULL(MAX(CAST([id] AS INT)),0)+1 AS VARCHAR(2)) AS Id FROM [costsetupItemMainhead]");
            Id = (string)db.Com.ExecuteScalar();
            if (Id.Length == 1)
                Id = "0" + Id;
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return Id;
        }

        [WebMethod]
        public static string FillExpGrid(int PageNumber, int PageSize, string filter)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            if (String.IsNullOrEmpty(filter))
                db.Com.CommandText = "SELECT [AGglCode], [FOglCode], [SDglCode], [COGSglCode] FROM [costsetupOverheadMainheadGLCode] ORDER BY [id]";
            else
                db.Com.CommandText = "SELECT [AGglCode], [FOglCode], [SDglCode], [COGSglCode] FROM [costsetupOverheadMainheadGLCode] where Branchid = '" + filter + "' ORDER BY [id]";
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
        public static string Update(string id, string description, string branchID, string AGglCode, string FOglCode, string SDglCode, string COGSglCOde)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = String.Format("UPDATE [costsetupOverheadMainheadGlCode] SET [MohID]='{0}', [BranchID]='{1}', [AGglCode]='{2}', [FOglCode]='{3}', [SDglCode]='{4}', [COGSglCode]='{5}'  WHERE [MohID]='{0}'", id, branchID, AGglCode, FOglCode, SDglCode, COGSglCOde);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record updated successfully.";
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
            db.Com.CommandText = "SELECT [id] ,[description] FROM [costsetupItemMainhead] WHERE [id] = '" + RowId + "'";
            SqlDataReader dr = db.Com.ExecuteReader();
            JavaScriptSerializer serailizer = new JavaScriptSerializer();
            SetupLocationEntry SetupLocation = new SetupLocationEntry();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    SetupLocation.BankCode = dr[0].ToString();
                    SetupLocation.BankDescription = dr[1].ToString();
                }
            }

            if (dr.IsClosed == false)
                dr.Close();

            db.Con.Close();
            db = null;
            return serailizer.Serialize(SetupLocation);
        }

        [WebMethod]
        public static string LoadMainHeadCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT CompCode, Description from branches where CompCode = '" + HttpContext.Current.Session["CompanyId"] + "'";
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

        public class SetupLocationEntry
        {
            public string BankCode, BankDescription;
        }
    }
}