/*
' Copyright (c) 2017  Virtualdev
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
using DevExpress.Web;

namespace VD.Modules.GestionTiers
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from GestionTiersModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : GestionTiersModuleBase, IActionable
    {
        protected string ressFilePath = "~/DesktopModules/GestionTiers/App_LocalResources/View.ascx.resx";
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

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ribMenu.Tabs[0].Text= DotNetNuke.Services.Localization.Localization.GetString("mManagementthirdparties", ressFilePath);
                RibbonGroup rgTiers = ribMenu.Tabs[0].Groups.FindByName("rgTiers");
                rgTiers.Text  = DotNetNuke.Services.Localization.Localization.GetString("mTiers", ressFilePath);
                rgTiers.Items.FindByName("rbiTiers").Text  = DotNetNuke.Services.Localization.Localization.GetString("mTiers", ressFilePath);
                rgTiers.Items.FindByName("rbiAddTiers").Text = DotNetNuke.Services.Localization.Localization.GetString("mAdd", ressFilePath);
                rgTiers.Items.FindByName("rbiEdit").Text = DotNetNuke.Services.Localization.Localization.GetString("mEdit", ressFilePath);
                rgTiers.Items.FindByName("rbiDelete").Text = DotNetNuke.Services.Localization.Localization.GetString("mDelete", ressFilePath);


            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }
        /// <summary>
        /// Initializes a new instance of the <see cref="View"/> class.
        /// </summary>
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