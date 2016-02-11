using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MuntazimDAL;
using System.Data;

namespace MutazimBCL
{
    public class SubHead_BCL
    {
        DbCls objDAL = new DbCls();
        public DataTable getDataTable() { return objDAL.getDataTable(); }

    }
}
