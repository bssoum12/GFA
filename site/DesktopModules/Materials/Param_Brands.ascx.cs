using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using DevExpress.Web;
using DataLayer;
using DotNetNuke.Services.Localization;
using System.Data.SqlClient;
using GlobalAPI; 

namespace VD.Modules.Materials
{
    public partial class Param_Brands : DotNetNuke.Entities.Modules.PortalModuleBase
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
            grdParam.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hNom", ressFilePath);
            toolbarMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnBrands", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Text  = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[1].Text  = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[2].Text  =  DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath); 
            
            
        }

        protected void grdParam_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            grdParam.DataBind();
            grdParam.CancelEdit();
        }

        protected void grdParam_CustomErrorText(object sender, DevExpress.Web.ASPxGridViewCustomErrorTextEventArgs e)
        {
	        if (e.ErrorTextKind != DevExpress.Web.GridErrorTextKind.RowValidate) 
            {
		        try
                {
			        SqlException sqlEx = (SqlException)e.Exception;
                    if ((sqlEx.Number == 547)) {
                        e.ErrorText = DotNetNuke.Services.Localization.Localization.GetString("mDeleteBrandError", ressFilePath);
				    }
				}
                catch(Exception)
                {}
            }			
        }
    }
}