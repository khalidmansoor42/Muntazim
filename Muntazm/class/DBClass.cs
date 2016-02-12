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
    string constr;
    public DBClass(string InitialDatabaseName)
    {

       // string Dbusername = "DESKTOP-IAI0RIM\Khalid";
        string constr = @"Data Source=DESKTOP-IAI0RIM\SQLEXPRESS;Initial Catalog=" + InitialDatabaseName + ";Integrated Security=SSPI;";
        Con = new SqlConnection(constr);
        Com = new SqlCommand();
        Com.Connection = Con;
    }

    public string GetConnectionString()
    {
        return constr;
    }

    public string GetMaxId(string preFix, Int32 IdLenght, string IdField, string TableName)
    {
        string Id = "";

        Com.CommandText = String.Format("SELECT LTRIM(RTRIM(('{0}'+  REPLICATE('0', {1} - LEN(i.ID)) +  CAST(i.ID AS VARCHAR(MAX))))) AS ID " +
        "FROM (SELECT ISNULL(MAX(SUBSTRING({2},LEN('{0}')+1, LEN({2})-LEN('{0}'))),0)+1 AS ID from " +
        "{3} where {2} like  '{0}' + '%') AS i", preFix, IdLenght, IdField, TableName);

        if (Con.State == System.Data.ConnectionState.Open)
        {
            return Com.ExecuteScalar().ToString().Trim();
        }
        else if (Con.State == System.Data.ConnectionState.Closed)
        {
            Con.Open();
            Id = Com.ExecuteScalar().ToString().Trim();
            Con.Close();
        }

        return Id;
    }

    public string GetField(string TableName, string FieldName, string Condition)
    {
        string SQL = "SELECT " + FieldName + " FROM " + TableName + " WHERE " + Condition;
        object Value;
        Com.CommandText = SQL;
        Value = Com.ExecuteScalar();
        if (Value != null)
        {
            return Value.ToString();
        }
        else
        {
            return "";
        }
    }

    public string GetMaxVoucherCode(string VoucherTypeCode, string Month, string Year)
    {
        Com.CommandText = String.Format("SELECT CAST(ISNULL(MAX([VoucherCode]),0)+1 AS CHAR) FROM [Accounts].[dbo].[Vouchers] WHERE [VoucherTypeCode]='{0}' AND [Month]='{1}' AND [Year]='{2}'", VoucherTypeCode, Month, Year);
        if (Con.State == System.Data.ConnectionState.Open)
        {
            return Com.ExecuteScalar().ToString().Trim();
        }
        else if (Con.State == System.Data.ConnectionState.Closed)
        {
            object Value;
            Con.Open();
            Value = Com.ExecuteScalar();
            Con.Close();
            return Value.ToString().Trim();
        }
        return "";
    }
}