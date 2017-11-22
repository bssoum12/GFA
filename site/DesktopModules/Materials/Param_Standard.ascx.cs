using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using VD.Modules.Framework;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class Param_Standard : DotNetNuke.Entities.Modules.PortalModuleBase
    {
         
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";

        protected string _portalAlias = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            if (!IsPostBack)
            {
                tlNorm.DataBind();
                tlNorm.ExpandToLevel(1);
                if (tlNorm.FocusedNode != null)
                {
                    grdCases.SettingsText.Title = String.Format(DotNetNuke.Services.Localization.Localization.GetString("lbUseCaseList", ressFilePath).Replace(@"\", ""), tlNorm.FocusedNode.GetValue("Designation"));
                    Session["IDNorme"] = tlNorm.FocusedNode.Key;
                }
                else
                {
                    grdCases.SettingsText.Title = String.Format(DotNetNuke.Services.Localization.Localization.GetString("lbUseCaseList", ressFilePath).Replace(@"\", ""), " ");
                    Session["IDNorme"] = null;
                }
                grdCases.DataBind();
                
            }

            //Populate UI Text
            btnDeleteStd.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdDelete", ressFilePath);
            btnCancelDeleteStd.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            pupDeleteStandard.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("tDeleteStd", ressFilePath);

            btnDeleteCase.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdDelete", ressFilePath);
            btnCancelDeleteCase.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            pupDeleteCase.HeaderText = String.Format(DotNetNuke.Services.Localization.Localization.GetString("mnuDeleteCase", ressFilePath).Replace(@"\", ""), ""); 
            


            //traduction tool bar
            toolbar.Items.FindByName("normGrp").Text = DotNetNuke.Services.Localization.Localization.GetString("mnNormes", ressFilePath);
            toolbar.Items.FindByName("addNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("mAddNewNorm", ressFilePath);
            toolbar.Items.FindByName("editNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbar.Items.FindByName("deleteNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdDelete", ressFilePath);
            toolbar.Items.FindByName("showStdFile").Text = DotNetNuke.Services.Localization.Localization.GetString("hDocList", ressFilePath);

            toolbar.Items.FindByName("casesGrp").Text = DotNetNuke.Services.Localization.Localization.GetString("mnuCases", ressFilePath).Replace(@"\", "");
            toolbar.Items.FindByName("addCase").Text = DotNetNuke.Services.Localization.Localization.GetString("mnuAddCase", ressFilePath).Replace(@"\", "");
            toolbar.Items.FindByName("editCase").Text = DotNetNuke.Services.Localization.Localization.GetString("mnuEditCase", ressFilePath).Replace(@"\", "");
            toolbar.Items.FindByName("deleteCase").Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("mnuDeleteCase", ressFilePath).Replace(@"\", ""), "");
            toolbar.Items.FindByName("showCaseFile").Text = DotNetNuke.Services.Localization.Localization.GetString("hDocList", ressFilePath);
            
            // traduction menu contextuel
            pupMnuManageStd.Items.FindByName("addNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("mAddNewNorm", ressFilePath);
            pupMnuManageStd.Items.FindByName("editNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            pupMnuManageStd.Items.FindByName("deleteNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdDelete", ressFilePath);
            pupMnuManageStd.Items.FindByName("addCase").Text = DotNetNuke.Services.Localization.Localization.GetString("mnuAddCase", ressFilePath).Replace(@"\", "");
            pupMnuManageStd.Items.FindByName("showStdFile").Text = DotNetNuke.Services.Localization.Localization.GetString("hDocList", ressFilePath);

            pupMnuManageCase.Items.FindByName("addCase").Text = DotNetNuke.Services.Localization.Localization.GetString("mnuAddCase", ressFilePath).Replace(@"\", "");
            pupMnuManageCase.Items.FindByName("editCase").Text = DotNetNuke.Services.Localization.Localization.GetString("mnuEditCase", ressFilePath).Replace(@"\", "");
            pupMnuManageCase.Items.FindByName("deleteCase").Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("mnuDeleteCase", ressFilePath).Replace(@"\", ""), "");
            pupMnuManageCase.Items.FindByName("showCaseFile").Text = DotNetNuke.Services.Localization.Localization.GetString("hDocList", ressFilePath);
            TranslateUtility.localizeGrid(grdCases , ressFilePath);
            tlNorm.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("mnNormes", ressFilePath);

        }

        
        protected void grdCases_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            Session["IDNorme"] = e.Parameters;
            grdCases.DataBind();
            grdCases.SettingsText.Title = String.Format(DotNetNuke.Services.Localization.Localization.GetString("lbUseCaseList", ressFilePath).Replace(@"\", ""), tlNorm.FocusedNode.GetValue("Designation"));
        }

         
        protected void tlNorm_CustomCallback(object sender, DevExpress.Web.ASPxTreeList.TreeListCustomCallbackEventArgs e)
        {
            tlNorm.DataBind();
            Session["IDNorme"] = tlNorm.FocusedNode.Key;
        }

         
        protected void btnDeleteStd_Click(object sender, EventArgs e)
        {

            if (StandardController.DeleteNorm(Convert.ToInt32(tlNorm.FocusedNode.Key)))
            {
                pupDeleteStandard.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDeleteNormErr", ressFilePath);
                btnDeleteStd.ClientVisible = false;
            }
            else
            {
                pupDeleteStandard.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath);
                btnCancelDeleteStd.Text = DotNetNuke.Services.Localization.Localization.GetString("lbClose", ressFilePath);
                btnDeleteStd.ClientVisible = false;
                tlNorm.DataBind();
            }
        }

         
        protected void pupDeleteStandard_WindowCallback(object source, DevExpress.Web.PopupWindowCallbackArgs e)
        {
            btnDeleteStd.ClientVisible = true;
            pupDeleteStandard.Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("lbDeleteNormMsg", ressFilePath).Replace(@"\",""), tlNorm.FocusedNode.GetValue("Designation"));
        }
 
        protected void btnDeleteCase_Click(object sender, EventArgs e)
        {
           /* if (StandardController.DeleteCaseByID(Convert.ToInt32(tlNorm.FocusedNode.Key), Convert.ToInt32(grdCases.GetRowValues(grdCases.FocusedRowIndex, "ID"))))
            {
                pupDeleteCase.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDeleteCaseErr", ressFilePath).Replace(@"\", "");
                btnDeleteCase.ClientVisible = false;
            }
            else
            {*/
                pupDeleteCase.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath);
                btnCancelDeleteCase.Text = DotNetNuke.Services.Localization.Localization.GetString("lbClose", ressFilePath);
                btnDeleteCase.ClientVisible = false;
                grdCases.DataBind();
           // }
        }

        
        protected void pupDeleteCase_WindowCallback(object source, DevExpress.Web.PopupWindowCallbackArgs e)
        {
            btnDeleteCase.ClientVisible = true;
            string libCase = grdCases.GetRowValues(grdCases.FocusedRowIndex, "LibCase") as string;
            pupDeleteCase.Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("mnuDeleteCase", ressFilePath).Replace(@"\", ""), libCase); 
        }

    }
}