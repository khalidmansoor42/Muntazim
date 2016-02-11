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
    public partial class BankAccountSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if(!IsPostBack)
            {
       
            }
        }

        [WebMethod]
        public static string LoadBanksCombo()
        {
            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT [id], [Description] FROM [setupBankAccountMainHead]";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
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
        public static string LoadBranchCombo(string Bank)
        {
            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT [id], [Description] FROM setupBankAccountSubHead WHERE MainHeadId='"+ Bank +"'";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
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
        public static string LoadCurrencyCombo()
        {
            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = "SELECT [ID], [CurCode] FROM Currencies";
            SqlDataAdapter da = new SqlDataAdapter(db.Com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
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
        public static string GetMaxId(string preFix)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            string Id;
            db.Con.Open();
            Id = db.GetMaxId(preFix, 2, "id", "setupBankAccount");
            db.Con.Close();
            db = null;
            return Id;
        }

        [WebMethod]
        public static string Add(string AccountCode,string Description,string SubHeadId,string Currency,string GLCode,string BankName,string BranchName, string AccountType,string AccountNo,string SwiftCode,string IBAN)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            db.Con.Open();
            db.Com.CommandText = "SELECT COUNT(*) FROM [setupBankAccount] WHERE [id]='" + AccountCode + "' AND [Description]='" + Description + "' AND [subheadid]= '" + SubHeadId + "' AND [BankName]='" + BankName + "' AND [BranchName]= '" + BranchName + "' AND [currency]='" + Currency + "' AND [BankGlCode]= '" + GLCode + "' AND [AccountType]='" + AccountType + "' AND [AccountNo]='" + AccountNo + "' AND [SwiftCode]='" + SwiftCode + "' AND [iban]= '" + IBAN + "'";
            if ((Int32)db.Com.ExecuteScalar() > 0)
                return "Error: Same data already exists.";
            db.Com.CommandText = String.Format("INSERT INTO [setupBankAccount] ([id],[Description],[subheadid],[currency],[BankGlCode],[BankName],[BranchName],[AccountType],[AccountNo],[SwiftCode],[iban]) VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}')", AccountCode,Description,SubHeadId,Currency,GLCode, BankName, BranchName, AccountType, AccountNo, SwiftCode,IBAN);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record added successfully.";
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
                db.Com.CommandText = "SELECT [id] as [AccountCode],[Description] FROM [setupBankAccount] " + filter + " ORDER BY [id]";
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
            db.Com.CommandText = "SELECT [id] as [AccountCode], [Description], [subheadid] as [BankName],[subheadid] as [BranchName],[AccountType],[currency] as [Currency],[BankGlCode] as [GLCode],[AccountNo],[SwiftCode],[iban] as IBAN FROM [setupBankAccount] WHERE [id] = '" + RowId + "'";
            SqlDataReader dr = db.Com.ExecuteReader();
            JavaScriptSerializer serailizer = new JavaScriptSerializer();
            BankAccounts BankAccount = new BankAccounts();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    BankAccount.AccountCode = dr[0].ToString();
                    BankAccount.Description = dr[1].ToString();
                    BankAccount.SubHeadId = dr[2].ToString();
                    BankAccount.SubHeadId = dr[3].ToString();
                    BankAccount.AccountType = dr[4].ToString();
                    BankAccount.Currency = dr[5].ToString();
                    BankAccount.GLCode = dr[6].ToString();
                    BankAccount.AccountNo = dr[7].ToString();
                    BankAccount.SwiftCode = dr[8].ToString();
                    BankAccount.IBAN = dr[9].ToString();
                }
            }

            if (dr.IsClosed == false)
                dr.Close();

            db.Con.Close();
            db = null;
            return serailizer.Serialize(BankAccount);
        }

        [WebMethod]
        public static string Update(string AccountCode, string Description, string SubHeadId, string Currency, string GLCode, string BankName, string BranchName, string AccountType, string AccountNo, string SwiftCode, string IBAN)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "Error: You are not logged-in.";
            }

            DBClass db = new DBClass("SCM");
            string msg = "";
            db.Con.Open();
            db.Com.CommandText = "SELECT COUNT(*) FROM [setupBankAccount] WHERE [id]= '" + AccountCode + "'";
            if ((Int32)db.Com.ExecuteScalar() == 1)
            {
                db.Com.CommandText = String.Format("UPDATE [setupBankAccount] SET [Description]='{0}', [subheadid]='{2}', [currency]='{3}', [BankGlCode]='{4}', [BankName]='{5}',[BranchName]='{6}',[AccountType]='{7}',[AccountNo]='{8}',[SwiftCode]='{9}',[iban]='{10}' WHERE [id]='{1}'", Description, AccountCode, SubHeadId, Currency, GLCode,BankName, BranchName, AccountType, AccountNo, SwiftCode, IBAN);
                msg = "Record updated successfully.";
            }
            else if ((Int32)db.Com.ExecuteScalar() == 0)
            {
                db.Com.CommandText = String.Format("INSERT INTO [setupBankAccount] ([id],[Description],[subheadid],[currency],[BankGlCode],[BankName],[BranchName],[AccountType],[AccountNo],[SwiftCode],[iban]) VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}')", AccountCode, Description, AccountCode, SubHeadId, Currency, GLCode, BankName, BranchName, AccountType, AccountNo, SwiftCode, IBAN);
                msg = "Record added successfully.";
            }
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return msg;
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
            db.Com.CommandText = String.Format("DELETE FROM [setupBankAccount] WHERE [id]='{0}'", RowId);
            db.Com.ExecuteNonQuery();
            db.Con.Close();
            db = null;
            return "Record deleted successfully.";
        }
    }

    public class BankAccounts
    {
        public string AccountCode, Description, SubHeadId, Currency, GLCode, BankName, BranchName, AccountType, AccountNo, SwiftCode, IBAN;
    }
}