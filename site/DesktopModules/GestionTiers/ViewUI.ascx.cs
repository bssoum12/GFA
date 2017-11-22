using DotNetNuke.Entities.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VD.Modules.Framework;

namespace VD.Modules.GestionTiers
{
    public partial class ViewUI : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected string ressFilePath = "~/DesktopModules/GestionTiers/App_LocalResources/View.ascx.resx";

        protected UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                TranslateUtility.localizeGrid( grdTiers , ressFilePath);
            }
               // grdTiers.DataBind(); 
        }
    }
}