using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Web.Configuration;

namespace Muntazm
{
    public partial class RptViewer : System.Web.UI.Page
    {
        ReportDocument reportDocument;

        SqlConnection con;
        SqlDataAdapter da;
        DataTable dt;
       
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void CrystalReportViewer1_Init(object sender, EventArgs e)
        {
            string DatabaseName = HttpContext.Current.Session["DatabaseName"].ToString();
            DBClass db = new DBClass(DatabaseName);
            string SqlQuery = HttpContext.Current.Session["SqlQuery"].ToString();
            string ReportFileName = HttpContext.Current.Session["ReportFileName"].ToString();
            da = new SqlDataAdapter(SqlQuery, db.Con);
            dt = new DataTable();
            da.Fill(dt);
            reportDocument = new ReportDocument();
            reportDocument.Load(ReportFileName);
            reportDocument.SetDataSource(dt);
            reportDocument.ReadRecords();
            CrystalReportViewer1.ReportSource = reportDocument;
        }
    }
}