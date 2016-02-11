using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;

namespace Muntazm
{
	public static class GlobalFunctions
	{
        public static List<Dictionary<string, object>> GetRowsForJson(SqlCommand cmd)
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
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
            return rows;
        }
        public static void ShowReport(string SqlQuery, string ReportFileName, string DatabaseName)
        {
            HttpContext.Current.Session["DatabaseName"] = DatabaseName;
            HttpContext.Current.Session["SqlQuery"] = SqlQuery;
            HttpContext.Current.Session["ReportFileName"] = HttpContext.Current.Server.MapPath("/Reports/" + ReportFileName + ".rpt");
            //HttpContext.Current.Response.Redirect("~/RptViewer.aspx");
        }

        public static List<T> DeserializeJSONData<T>(T value, string JSONData)
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            List<T> list = ser.Deserialize<List<T>>(JSONData);
            return list;
        }

        public static void SaveDocLog(string DocID, string DocTag, bool FinalizeState)
        {
            DBClass db = new DBClass("SCM");
            bool isSaved;
            db.Con.Open();
            db.Com.CommandText = String.Format("SELECT COUNT(*) FROM UMDocLog WHERE DocID='{0}' AND Doctag='{1}'", DocID, DocTag);
            isSaved = Convert.ToBoolean(db.Com.ExecuteScalar());
            if (FinalizeState == true)
            {
                if (isSaved == true)
                {
                    db.Com.CommandText = String.Format("UPDATE UMDocLog SET FinalizeTime='{0}',FinalizeUser='{1}' Where DocID='{2}' AND Doctag='{3}'", DateTime.Now.ToString(), HttpContext.Current.Session["UserName"], DocID, DocTag);
                    db.Com.ExecuteNonQuery();
                }
                else
                {
                    db.Com.CommandText = String.Format("DELETE FROM UMDocLog WHERE DocID='{0}' AND DocTag='{1}'", DocID, DocTag);
                    db.Com.ExecuteNonQuery();
                    db.Com.CommandText = String.Format("INSERT INTO UMDocLog (DocID, DocTag, SaveUser, FinalizeUser) VALUES ('{0}','{1}','{2}','{2}')", DocID, DocTag, HttpContext.Current.Session["UserName"]);
                    db.Com.ExecuteNonQuery();
                }
            }
            else
            {
                if (isSaved == true)
                {
                    db.Com.CommandText = String.Format("UPDATE UMDocLog SET SaveTime='{0}',SaveUser='{1}' Where DocID='{2}' AND Doctag='{3}'", DateTime.Now.ToString(), HttpContext.Current.Session["UserName"], DocID, DocTag);
                    db.Com.ExecuteNonQuery();
                }
                else
                {
                    db.Com.CommandText = String.Format("DELETE FROM UMDocLog WHERE DocID='{0}' AND DocTag='{1}'", DocID, DocTag);
                    db.Com.ExecuteNonQuery();
                    db.Com.CommandText = String.Format("INSERT INTO UMDocLog (DocID, DocTag, SaveUser) VALUES ('{0}','{1}','{2}')", DocID, DocTag, HttpContext.Current.Session["UserName"]);
                    db.Com.ExecuteNonQuery();
                }
            }
        }

        public static string GetSqlDate(string Date)
        {
            string[] arr = Date.Split('-');
            return arr[2] + "-" + arr[1] + "-" + arr[0];

        }

        public static string GetDate(string SqlDate)
        {
            string[] arr = SqlDate.Split('-');
            return arr[2] + "-" + arr[1] + "-" + arr[0];

        }
     }
 }