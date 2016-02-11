using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
/// <summary>
/// Summary description for DBAccounts
/// </summary>
public class DBAccounts
{
    public SqlConnection Con;
    public SqlCommand Com;
    public DBAccounts()
	{
        string constr = ConfigurationManager.ConnectionStrings["Accounts"].ConnectionString;
        Con = new SqlConnection(constr);
        Com = new SqlCommand();
        Com.Connection = Con;
	}
}