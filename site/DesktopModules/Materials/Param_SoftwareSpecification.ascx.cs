using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VD.Modules.Materials
{
    public partial class Param_SoftwareSpecification : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        /// <summary>
        /// The current user
        /// </summary>
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        /// <summary>
        /// The ressource file path
        /// </summary>
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            TranslateUtility.localizeGrid(grdParam, ressFilePath);
            toolbarMenu.Items[0].Text =   DotNetNuke.Services.Localization.Localization.GetString("mnSoftwareSpecification", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

        }
    }
}