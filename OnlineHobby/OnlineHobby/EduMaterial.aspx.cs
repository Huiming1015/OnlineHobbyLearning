﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class EduMaterial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dlMaterialKit_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "viewModify")
            {
                Response.Redirect("ViewMaterial.aspx?id=" + e.CommandArgument.ToString());
            }
        }
    }
}