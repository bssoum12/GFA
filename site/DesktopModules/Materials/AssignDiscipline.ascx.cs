using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;
using DotNetNuke.Entities.Users;
using VD.Modules.VBFramework;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class AssignDisciplineToSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        static int specID;
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (! IsPostBack)
            {
                Session["lang"] = Request.QueryString["lang"];
                // Init controls visibility
                lblDisciplineUI.ClientVisible = true;
                cmbDiscipline.ClientVisible = true;
                btnApply.ClientVisible = true;

                if (Request.QueryString["specid"] != null) {
                    try
                    {
                        //Get id spec from url
                        specID = int.Parse(Request.QueryString["specid"]);
                    }
                    catch
                    {
                
                    }
                }
                // Get the spec row by specID
                List<DataLayer.Materials_SelectMaterialsSpecificationByIDResult> spec = SpecificationController.GetMatSpecByID(specID);
                lblDisciplineUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDisciplineUI", ressFilePath);
                lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignDisToSpec", ressFilePath) + " " + spec[0].Designation;
                btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
                btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            }
            
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            try
            {
                string result = SpecificationController.AssignMatSpecToDiscipline(cmbDiscipline.Value.ToString(), specID, Utili.UserID);
                lblDisciplineUI.ClientVisible = false;
                cmbDiscipline.ClientVisible = false;
                btnApply.ClientVisible = false;
                btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
                if (result != "ok")
                {
                    GlobalAPI.CommunUtility.logEvent("Error assign spec to discipline : " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles );
                    lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                }
                else
                {
                    lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SSuccess", ressFilePath);
                }
            }
            catch (Exception)
            {

            }
        }
    }
}