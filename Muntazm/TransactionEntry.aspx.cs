using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
namespace Muntazm
{
    public partial class TransactionEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Path = "~/Uploads/Voucher Attachments";
            
            if(HttpContext.Current.Request.Form.Get("Action") != null && HttpContext.Current.Request.Form.Get("Action").ToString() == "Upload")
            {
                if (HttpContext.Current.Request.Files.Count > 0)
                {
                    HttpRequest Request = HttpContext.Current.Request;
                    var s = Request.Form["BranchCode"].ToString();
                    Path = String.Format("{0}\\{1}\\{2}\\{3}\\{4}\\{5}\\{6}", Path, HttpContext.Current.Session["CompanyId"].ToString(), Request.Form.Get("BranchCode"), Request.Form.Get("Year"), Request.Form.Get("Month"), Request.Form.Get("VoucherTypeCode"), Request.Form.Get("VoucherCode"));
                    Path = Server.MapPath(Path);
                    if (Directory.Exists(Path) == false)
                    {
                        Directory.CreateDirectory(Path);
                    }

                    DBClass db = new DBClass("Accounts");
                    db.Con.Open();
                    foreach (string fileName in Request.Files)
                    {
                        HttpPostedFile file = Request.Files[fileName];
                        file.SaveAs(Path + "\\" + file.FileName);
                        db.Com.CommandText = String.Format("INSERT INTO [Attachments] ([CoID],[BranchCode],[Month],[Year],[VochType],[VochNo],[FileName],[UploadedBy],[UploadedDate],[Status]) VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}',1)", HttpContext.Current.Session["CompanyId"], Request.Form.Get("BranchCode"), Request.Form.Get("Month"), Request.Form.Get("Year"), Request.Form.Get("VoucherTypeCode"), Request.Form.Get("VoucherCode"), file.FileName, HttpContext.Current.Session["UserName"], DateTime.Now);
                        db.Com.ExecuteNonQuery();
                    }
                    db.Con.Close();
                    db = null;
                    HttpContext.Current.Response.ContentType = "text/plain";
                    HttpContext.Current.Response.Write("File(s) uploaded successfully.");
                    HttpContext.Current.Response.End();
                }
            }
            else if (HttpContext.Current.Request.QueryString.Get("Action") != null && HttpContext.Current.Request.QueryString.Get("Action").ToString() == "Download")
            {
                Path = String.Format("{0}\\{1}\\{2}\\{3}\\{4}\\{5}\\{6}\\{7}", Path, HttpContext.Current.Session["CompanyId"].ToString(), Request.QueryString.Get("BranchCode"), Request.QueryString.Get("Year"), Request.QueryString.Get("Month"), Request.QueryString.Get("VoucherTypeCode"), Request.QueryString.Get("VoucherCode"), Request.QueryString.Get("FileName"));
                Path = Server.MapPath(Path);
                Response.AddHeader("Content-disposition", "attachment; filename=" + Request.QueryString.Get("FileName"));
                Response.ContentType = "application/octet-stream";
                Response.WriteFile(Path);
                Response.End();
            }
            else if (HttpContext.Current.Request.Form.Get("Action") != null && HttpContext.Current.Request.Form.Get("Action").ToString() == "Delete")
            {
                Path = String.Format("{0}\\{1}\\{2}\\{3}\\{4}\\{5}\\{6}\\{7}", Path, HttpContext.Current.Session["CompanyId"].ToString(), Request.Form.Get("BranchCode"), Request.Form.Get("Year"), Request.Form.Get("Month"), Request.Form.Get("VoucherTypeCode"), Request.Form.Get("VoucherCode"), Request.Form.Get("FileName"));
                Path = Server.MapPath(Path);
                if(File.Exists(Path) == true)
                {
                    File.Delete(Path);
                }
                DBClass db = new DBClass("Accounts");
                db.Con.Open();
                db.Com.CommandText = String.Format("UPDATE [Attachments] SET [DeletedBy]='{0}',[DeletedDate]='{1}',[Status]=0 WHERE [AttachID]={2}", HttpContext.Current.Session["UserName"], DateTime.Now, Request.Form.Get("AttachID"));
                db.Com.ExecuteNonQuery();
                db.Con.Close();
                db = null;
                HttpContext.Current.Response.ContentType = "text/plain";
                HttpContext.Current.Response.Write("File Deleted Successfully.");
                HttpContext.Current.Response.End();
            }
        }

        [WebMethod]
        public static string GetMaxId(string VoucherTypeCode, string Month, string Year)
        {
            DBClass db = new DBClass("Accounts");
            return db.GetMaxVoucherCode(VoucherTypeCode, Month, Year);
        }

        [WebMethod]
        public static string Add(string VoucherCode, string BranchCode, string VoucherTypeCode, string Date, string Month, string Year, string Note, float Debit, float Credit, string Rows, string Currency, float ExchangeRate, string ProjectCode)
        {
            DBClass db = new DBClass("Accounts");
            List<TransactionData> list = GlobalFunctions.DeserializeJSONData(new TransactionData(), Rows);
            db.Con.Open();
            db.Com.CommandText = String.Format("DELETE FROM [Vouchers] WHERE [VoucherCode]={0} AND [Month]='{1}' AND [Year]='{2}' AND [VoucherTypeCode]='{3}'", VoucherCode, Month, Year.Trim(), VoucherTypeCode);
            db.Com.ExecuteNonQuery();
            db.Com.CommandText = String.Format("DELETE FROM [VoucherDetail] WHERE [VoucherCode]={0} AND [Month]='{1}' AND [Year]='{2}' AND [VoucherTypeCode]='{3}'", VoucherCode, Month, Year.Trim(), VoucherTypeCode);
            db.Com.ExecuteNonQuery();
            db.Com.CommandText = String.Format("INSERT INTO [Vouchers] ([VoucherCode],[BranchCode],[VoucherTypeCode],[Date],[Month],[Year],[Naration],[Currency],[ExchangeRate],[PreparedBy],[Status],[ProjectCode]) VALUES ({0},'{1}','{2}','{3}','{4}','{5}','{6}','{7}',{8},'{9}','{10}','{11}')", VoucherCode, BranchCode, VoucherTypeCode, Date, Month, Year.Trim(), Note, Currency, ExchangeRate, HttpContext.Current.Session["UserName"], "Prepared", ProjectCode);
            db.Com.ExecuteNonQuery();
            for (int i=0; i < list.Count; i++)
            {
                db.Com.CommandText = String.Format("INSERT INTO [VoucherDetail] ([VoucherCode],[BranchCode],[VoucherTypeCode],[Accounts],[Month],[Year],[Note],[Debit],[Credit]) VALUES ({0},'{1}','{2}','{3}','{4}','{5}','{6}',{7},{8})", VoucherCode, BranchCode, VoucherTypeCode, list[i].AccountCode, Month, Year.Trim(), String.IsNullOrEmpty(list[i].Note) ? Note : list[i].Note, String.Format("{0} * '{1}", Convert.ToDouble(list[i].Debit), ExchangeRate.ToString()), String.Format("{0} * {1}", Convert.ToDouble(list[i].Credit), ExchangeRate.ToString()));
                db.Com.ExecuteNonQuery();
            }

            return "Record Added Successfully.";
        }

        [WebMethod]
        public static string GetAttachments(string BranchCode, string Year, string Month, string VoucherTypeCode, string VoucherCode)
        {
            DBClass db = new DBClass("Accounts");
            db.Con.Open();
            db.Com.CommandText = String.Format("SELECT AttachID,FileName FROM Attachments WHERE CoID='{0}' AND BranchCode='{1}' AND Year='{2}' AND Month='{3}' AND VochType='{4}' AND VochNo='{5}' AND Status=1", HttpContext.Current.Session["CompanyId"], BranchCode, Year, Month, VoucherTypeCode, VoucherCode);
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
        public static string LoadVoucher(string VoucherCode, string VoucherTypeCode, string Month, string Year, string BranchCode)
        {
            DBClass db = new DBClass("Accounts");
            EditTransactionData etd = new EditTransactionData();
            db.Con.Open();
            db.Com.CommandText = String.Format("SELECT VoucherCode,VoucherTypeCode,BranchCode,CONVERT(varchar,[Date],105) AS [Date],Naration,Currency,ExchangeRate,ProjectCode FROM Vouchers WHERE VoucherCode={0} AND VoucherTypeCode='{1}' AND Month='{2}' AND Year='{3}' AND BranchCode='{4}'", VoucherCode, VoucherTypeCode, Month, Year, BranchCode);
            SqlDataReader sdr = db.Com.ExecuteReader();
            if(sdr.HasRows)
            {
                while (sdr.Read())
                {
                    etd.VoucherCode = sdr[0].ToString();
                    etd.VoucherTypeCode = sdr[1].ToString();
                    etd.BranchCode = sdr[2].ToString();
                    etd.Date = sdr[3].ToString();
                    etd.Narration = sdr[4].ToString();
                    etd.Currency = sdr[5].ToString();
                    etd.ExchangeRate = sdr[6].ToString();
                    etd.ProjectCode = sdr[7].ToString();
                }
            }
            if (sdr.IsClosed == false)
                sdr.Close();

            db.Com.CommandText = String.Format("SELECT A.Accounts AS AccountCode,A.Note AS LineDescription,A.Debit/V.ExchangeRate AS Debit,A.Credit/V.ExchangeRate AS Credit,B.Description AS Description FROM VoucherDetail AS A INNER JOIN Vouchers AS V ON V.VoucherCode=A.VoucherCode INNER JOIN Account AS B ON A.Accounts=B.AccountCode WHERE A.VoucherCode={0} AND A.VoucherTypeCode='{1}' AND A.Month='{2}' AND A.Year='{3}' AND A.BranchCode='{4}'", VoucherCode, VoucherTypeCode, Month, Year, BranchCode);
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

            etd.Rows = rows;
            db.Con.Close();
            db = null;
            return serializer.Serialize(etd);
        }

    }
    public class TransactionData
    {
        public string VoucherCode, BranchCode, VoucherTypeCode, AccountCode, Month, Year, Note, Debit, Credit;
    }

    public class EditTransactionData
    {
        public string VoucherCode, VoucherTypeCode, BranchCode, Date, Narration, Currency, ExchangeRate, ProjectCode;
        public List<Dictionary<string, object>> Rows;

        public EditTransactionData()
        {
            Rows = new List<Dictionary<string, object>>();
        }
    }
    class VoucherAttachmentsInfo
    {
        string CompnayID, Branch, Year, Month, VoucherType, VoucherNo;
    }
}