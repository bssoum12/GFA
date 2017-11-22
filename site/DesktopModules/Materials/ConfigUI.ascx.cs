using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VD.Modules.Materials
{
    public partial class ConfigUI : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected string _portalAlias = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            mnLinks.Items.FindByName("itemMeasureSystem").Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureSystems", ressFilePath);
            mnLinks.Items.FindByName("itemMeasureUnit").Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureUnits", ressFilePath);
            mnLinks.Items.FindByName("itemUnitFamilies").Text = DotNetNuke.Services.Localization.Localization.GetString("mnitFamilies", ressFilePath);
            mnLinks.Items.FindByName("itemFormulas").Text = DotNetNuke.Services.Localization.Localization.GetString("mnFormules", ressFilePath);
            mnLinks.Items.FindByName("itemTechnicalSoftware").Text = DotNetNuke.Services.Localization.Localization.GetString("mnTechnicalSoftware", ressFilePath);
            mnLinks.Items.FindByName("itemSoftwareSpecifcation").Text = DotNetNuke.Services.Localization.Localization.GetString("mnSoftwareSpecification", ressFilePath);
                        
            mnLinks.Items.FindByName("itemMaterialMenToNotify").Text = DotNetNuke.Services.Localization.Localization.GetString("hMaterialsMenToNotify", ressFilePath);
            mnLinks.Items.FindByName("itemBrands").Text = DotNetNuke.Services.Localization.Localization.GetString("mnBrands", ressFilePath);
            

            nbMain.Groups[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnMaterials", ressFilePath);
            
            
            nbMain.Groups[0].Items.FindByName("itemMeasureSystem").Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureSystems", ressFilePath);
            nbMain.Groups[0].Items.FindByName("itemMeasureUnit").Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureUnits", ressFilePath);
            nbMain.Groups[0].Items.FindByName("itemUnitFamilies").Text = DotNetNuke.Services.Localization.Localization.GetString("mnitFamilies", ressFilePath);
            nbMain.Groups[0].Items.FindByName("itemFormulas").Text = DotNetNuke.Services.Localization.Localization.GetString("mnFormules", ressFilePath);
            nbMain.Groups[0].Items.FindByName("itemTechnicalSoftware").Text = DotNetNuke.Services.Localization.Localization.GetString("mnTechnicalSoftware", ressFilePath);
            nbMain.Groups[0].Items.FindByName("itemSoftwareSpecifcation").Text = DotNetNuke.Services.Localization.Localization.GetString("mnSoftwareSpecification", ressFilePath);
            
            nbMain.Groups[0].Items.FindByName("itemBrands").Text = DotNetNuke.Services.Localization.Localization.GetString("mnBrands", ressFilePath);            
            nbMain.Groups[0].Items.FindByName("itemMaterialMenToNotify").Text = DotNetNuke.Services.Localization.Localization.GetString("hMaterialsMenToNotify", ressFilePath);            
        }
    }
}