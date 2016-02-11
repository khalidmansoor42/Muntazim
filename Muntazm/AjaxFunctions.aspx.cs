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
    public partial class AjaxFunctions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

         [WebMethod]
        public static string PrintVoucher(string VoucherType, string VoucherNo, string VoucherDate)
        {
            string SqlQuery = string.Format("Select (Select Description From VoucherType Where Code = dbo.vwLedger.VoucherTypeCode) as VoucherDesc, (Select CompName From Companies Where CompCode = LEFT(dbo.vwLedger.BranchCode,2)) AS CompanyName, [Date], [Year] + '-' + [MONTH] + '-' + VoucherTypeCode + '-' + CAST(ISNULL(VoucherCode,0) AS Varchar) as VoucherNo, VoucherCode, VoucherTypeCode as VoucherType,RTRIM(VoucherTypeCode) + '-' + CAST(ISNULL(VoucherCode,0) AS Varchar) as VocuherTyepeAndCode, Naration, BranchCode, BranchDesc, AccountsCode, AccountsDesc, BankAccountCode,Cheque,PreparedBy,CheckedBy,ApprovedBy,Debit,Credit from dbo.vwLedger WHERE VoucherTypeCode= '{0}' AND VoucherCode={1} AND [Date]='{2}'", VoucherType, VoucherNo, GlobalFunctions.GetSqlDate(VoucherDate));
            HttpContext.Current.Session["SqlQuery"] = SqlQuery;
            HttpContext.Current.Session["ReportFileName"] = HttpContext.Current.Server.MapPath("/Reports/" + "rptPrintVoucher.rpt");
            HttpContext.Current.Session["DatabaseName"] = "Accounts";
            return "1";
        }

        [WebMethod]
        public static string getValue(string SQL, string DBName)
        {
            DBClass db = new DBClass("Accounts");
            object Value;
            db.Com.CommandText = SQL;
            db.Con.Open();
            Value = db.Com.ExecuteScalar();
            if(Value != null)
            {
                return Value.ToString();
            }
            else if (Value == null)
            {
                return "";
            }

            return "";
        }

        [WebMethod]
        public static string LoadBranchCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [BranchCode],[Description] FROM [Branches]";
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
        public static string LoadProjectCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [ProjectCode],[Description] FROM [Projects]";
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
        public static string FillGrid(string DBName, string SqlQuery)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }
            DBClass db = new DBClass(DBName);
            db.Con.Open();
            db.Com.CommandText = SqlQuery;
            string Json = (new System.Web.Script.Serialization.JavaScriptSerializer()).Serialize(GlobalFunctions.GetRowsForJson(db.Com));
            db.Con.Close();
            db = null;
            return Json;
        }

        [WebMethod]
        public static string FillComboGrid(string SQL)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = SQL;
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
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
            return String.Format("{{\"total\":{0},\"rows\":{1}}}", dt.Rows.Count, serializer.Serialize(rows));
        }

        [WebMethod]
        public static string LoadCurrencyCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [CurCode],[CurDesc] FROM [Currencies] WHERE Status = 'True'";
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
        public static string LoadCompanyCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [CompCode],[CompName] FROM [Companies] WHERE Status = 'True'";
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
        public static string LoadYearCombo()
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT DISTINCT [Year] FROM [Vouchers]";
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
        public static string GetAccounts(string filter = "")
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [AccountCode],[Description] FROM [Account] " + filter;
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
            return String.Format("{{\"total\":{0},\"rows\":{1}}}", dt.Rows.Count, serializer.Serialize(rows));
            //return serializer.Serialize(rows);
        }

        [WebMethod]
        public static string GetGLAccounts(string filter = "")
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [AccountCode],[AccountName] as [Description] FROM [vwcataccounts] " + filter;
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
            return String.Format("{{\"total\":{0},\"rows\":{1}}}", dt.Rows.Count, serializer.Serialize(rows));
            //return serializer.Serialize(rows);
        }

        [WebMethod]
        public static string GetProjects(string filter = "")
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [ProjectCode],[Description] FROM [Projects] " + filter;
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
            return String.Format("{{\"total\":{0},\"rows\":{1}}}", dt.Rows.Count, serializer.Serialize(rows));
            //return serializer.Serialize(rows);
        }

        [WebMethod]
        public static string GetBaseCurrency()
        {
            DBClass db = new DBClass("Accounts");
            object Value;
            db.Com.CommandText = "SELECT BaseCurrency FROM Companies WHERE CompCode='" + HttpContext.Current.Session["CompanyId"].ToString() + "'";
            db.Con.Open();
            Value = db.Com.ExecuteScalar();
            if (Value != null)
            {
                return Value.ToString();
            }
            else if (Value == null)
            {
                return "";
            }

            return "";
        }

        [WebMethod]
        public static string LoadCashAccountCombo(string Branch)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [AccountCode],[Description] FROM [Account] WHERE left(AccountCode,5)='" + Branch + "' AND right(left(AccountCode,14),8)in ('02-06-03','02-06-04')";
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
        public static string LoadAccountCombo(string BranchCode)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = String.Format("SELECT [AccountCode],[Description] from account where left(accountcode,5)='{0}' AND left(catagorycode,5) in ('02-06','01-04','02-04','04-01','05-01','05-02','05-03')", BranchCode);
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
        public static string Search(int PageNumber, int PageSize, string sql)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            if (String.IsNullOrEmpty(sql))
                db.Com.CommandText = "SELECT [AccountCode],[Description] FROM [Account]";
            else
                db.Com.CommandText = sql;
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
            return String.Format("{{\"total\":{0},\"rows\":{1}}}", dt.Rows.Count, serializer.Serialize(rows));
        }
    }
}