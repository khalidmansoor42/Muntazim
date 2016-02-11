using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MutazimBCL;
using System.Data;

namespace Muntazm
{
    public partial class SubHead : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack )
            {
                fillCombo();
            }
        }
        private void fillCombo() {
            SubHead_BCL objBCL = new SubHead_BCL();
            DataTable dt=new DataTable();
            dt = objBCL.getDataTable();
            ////CostSetupItem_DropDownMainHeads.DataSource = dt;
            ////CostSetupItem_DropDownMainHeads.DataBind();

            for (int i = 0; i < dt.Rows.Count-1 ; i++)
            {
                CostSetupItem_DropDownMainHeads.Items.Add(new ListItem( dt.Rows[i][0].ToString ()) );
            }
        }

    }
}