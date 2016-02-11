using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
/// <summary>
/// Summary description for DBClass
/// </summary>
public class DBClass
{
    public SqlConnection Con;
    public SqlCommand Com;
	public DBClass()
	{
        
		//
		// TODO: Add constructor logic here
		//
        string constr = ConfigurationManager.ConnectionStrings["MuntazmConnectionString"].ConnectionString;
        Con = new SqlConnection(constr);
        Com = new SqlCommand();
        Com.Connection = Con;
	}
}