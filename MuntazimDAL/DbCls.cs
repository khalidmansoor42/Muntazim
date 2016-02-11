using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MuntazimDAL
{
    public class DbCls
    {
        public String getConnectionString() { return ConfigurationManager.ConnectionStrings["Accounts"].ToString(); }


        public DataTable getDataTable()
        {
            DataTable dt = new DataTable();
            String lStrQry = "select description  from costsetupItemMainhead";

            SqlConnection conn = new SqlConnection(getConnectionString());
            //SqlTransaction trans = null;


            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = lStrQry;



            SqlDataAdapter adt = new SqlDataAdapter(cmd);
            adt.Fill(dt);

            return dt;
        }
    }
}
