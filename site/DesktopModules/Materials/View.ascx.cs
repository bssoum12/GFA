/*
' Copyright (c) 2017  Virtualdev.tn
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using GlobalAPI;
using DevExpress.Web;

namespace VD.Modules.Materials
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from MaterialsModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : MaterialsModuleBase, IActionable
    {
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected string _portalAlias = "";

        protected void Page_Init(object sender, System.EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            //Register UserId and ModuleId javascript variables
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "InitModule", "var ModuleId = " + Convert.ToString(ModuleId) + "; var UserId=" + UserId + "; var TabId = " + PortalSettings.ActiveTab.TabID + " ;", true);
            ModuleConfiguration.ModuleTitle = Localization.GetString("mModuleTitle", ressFilePath);
            //Verify License
            //Dim mLicenseExpired As String = DotNetNuke.Services.Localization.Localization.GetString("mLicenseExpired", ressFilePath)
            //Dim mLicenseDateProblem As String = DotNetNuke.Services.Localization.Localization.GetString("mLicenseDateProblem", ressFilePath)
            //Dim moduleCtrl As New ModuleController
            //SecurityAPI.HelperUtility.VerifyLicense(ModuleId, PortalSettings.ActiveTab.TabID, moduleCtrl.GetModule(ModuleId).DesktopModule.FriendlyName, Host.Host.HostTitle + Host.Host.GUID, mLicenseExpired, mLicenseDateProblem)
        }

        protected void cbMaterialsOp_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            if (e.Parameter.StartsWith("0"))
            {
                string[] tabParam = e.Parameter.Split(new string[] { "@@" }, StringSplitOptions.None);
                int ret = MaterialsController.deleteMaterialByID(Int32.Parse(tabParam[1]));
                if (ret == 0)
                    e.Result = Localization.GetString("lbSuccesOp", ressFilePath);
                else
                    if (ret == 1)
                    e.Result = Localization.GetString("mAlreadyUsedMaterialDeleteError", ressFilePath);
                else
                    e.Result = Localization.GetString("mErrorOccured", ressFilePath);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ribMenu.Tabs[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnMaterials", ressFilePath);
                RibbonGroup rgArticles = ribMenu.Tabs[0].Groups.FindByName("rgArticles");
                rgArticles.Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdition", ressFilePath);
                rgArticles.Items.FindByName("rbiAdd").Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
                rgArticles.Items.FindByName("rbiEdit").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
                rgArticles.Items.FindByName("rbiDelete").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);
                rgArticles.Items.FindByName("rbiDetails").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDetails", ressFilePath);
                rgArticles.Items.FindByName("rbiSearch").Text = DotNetNuke.Services.Localization.Localization.GetString("mnSearch", ressFilePath);

                RibbonGroup rgFamilles = ribMenu.Tabs[0].Groups.FindByName("rgFamilles");
                rgFamilles.Text = DotNetNuke.Services.Localization.Localization.GetString("hSpecifications", ressFilePath);
                rgFamilles.Items.FindByName("rbiFamilles").Text = DotNetNuke.Services.Localization.Localization.GetString("hSpecifications", ressFilePath);
                rgFamilles.Items.FindByName("rbiGroupeDis").Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignToDisciplines", ressFilePath);
                rgFamilles.Items.FindByName("rbiGroupeFournis").Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignToSuppliers", ressFilePath);

                RibbonGroup rgProperties = ribMenu.Tabs[0].Groups.FindByName("rgProperties");
                rgProperties.Text = DotNetNuke.Services.Localization.Localization.GetString("mnProperties", ressFilePath);
                rgProperties.Items.FindByName("rbiProperties").Text = DotNetNuke.Services.Localization.Localization.GetString("mnProperties", ressFilePath);
                rgProperties.Items.FindByName("rbiGroupeProp").Text = DotNetNuke.Services.Localization.Localization.GetString("mnPropertiesGroup", ressFilePath);
                rgProperties.Items.FindByName("rbiGroupeFamille").Text = DotNetNuke.Services.Localization.Localization.GetString("mnPropertiesAssignment", ressFilePath);

                RibbonGroup rgNormes = ribMenu.Tabs[0].Groups.FindByName("rgNormes");
                rgNormes.Text = DotNetNuke.Services.Localization.Localization.GetString("mnNormes", ressFilePath);
                rgNormes.Items.FindByName("rbiNormes").Text = DotNetNuke.Services.Localization.Localization.GetString("mnNormes", ressFilePath);
                rgNormes.Items.FindByName("rbiFamileNorm").Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignNorms", ressFilePath);
                rgNormes.Items.FindByName("rbiExigenNorme").Text = DotNetNuke.Services.Localization.Localization.GetString("mnNormRequirements", ressFilePath);

                RibbonGroup rgActions = ribMenu.Tabs[0].Groups.FindByName("rgActions");
                rgActions.Text = DotNetNuke.Services.Localization.Localization.GetString("mnActions", ressFilePath);
                rgActions.Items.FindByName("mitExportExcel_Actions").Text = DotNetNuke.Services.Localization.Localization.GetString("mnExportExcel", ressFilePath);
                rgActions.Items.FindByName("mitExportPDF_Actions").Text = DotNetNuke.Services.Localization.Localization.GetString("mnExportPDF", ressFilePath);
                rgActions.Items.FindByName("mitExpandTree_Actions").Text = DotNetNuke.Services.Localization.Localization.GetString("mnExpandTree", ressFilePath);
                ribMenu.Tabs[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnParameters", ressFilePath);
                RibbonGroup rgConfig = ribMenu.Tabs[1].Groups.FindByName("rgConfig");
                rgConfig.Text = DotNetNuke.Services.Localization.Localization.GetString("mnParameters", ressFilePath);
                rgConfig.Items.FindByName("rbiConfig").Text = DotNetNuke.Services.Localization.Localization.GetString("mnParameters", ressFilePath);


            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }
        public View()
        {
            Load += Page_Load;
            Init += Page_Init;
        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }
    }
}