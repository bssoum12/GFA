using DotNetNuke.Entities.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GlobalAPI;
using VD.Modules.VBFramework;
using VD.Modules.Framework;

namespace VD.Modules.Materials
{
    public partial class Param_TechnicalSoftware_Discipline_Responsable : DotNetNuke.Entities.Modules.PortalModuleBase
    {

        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();          
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";

       
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            TranslateUtility.localizeGrid(grdParam, ressFilePath);
            TranslateUtility.localizeGrid(grdEmploye, ressFilePath);
            grdParam.Columns["Discipline"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hDiscipline", ressFilePath);
            grdParam.Columns["TechnicalSoftwareName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hTechnicalSoftware", ressFilePath);
            grdParam.Columns["NomFonction"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hFonction", ressFilePath);
            grdParam.Columns["nom_organisation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("LabNomOrg", ressFilePath);
            grdParam.Columns["NomSociete"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lblSociete", ressFilePath);
            grdEmploye.Columns["Discipline"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hDiscipline", ressFilePath);
            grdEmploye.Columns["TechnicalSoftwareName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hTechnicalSoftware", ressFilePath);
            grdEmploye.Columns["empName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hEmploye", ressFilePath);

            toolbarMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("hMaterialsMenToNotify", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            pcAssignments.TabPages[0].Text = DotNetNuke.Services.Localization.Localization.GetString("hByFunction", ressFilePath);
            pcAssignments.TabPages[1].Text = DotNetNuke.Services.Localization.Localization.GetString("hByEmployee", ressFilePath);
        }


       
        protected void grdParam_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            grdParam.DataBind();
        }

         
        protected void grdEmploye_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            grdEmploye.DataBind();
        } 
    }
}