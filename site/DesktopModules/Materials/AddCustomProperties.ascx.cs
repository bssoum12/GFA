using DataLayer;
using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using DotNetNuke.Entities.Users;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class AddCustomProperties : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            tlsPropertiesGroupsCustom.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGroup", ressFilePath);
            tlsPropertiesGroupsCustom.Columns["PropertyDesignation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperty", ressFilePath);
            tlsPropertiesGroupsCustom.Columns[4].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValue", ressFilePath);
            tlsPropertiesGroupsCustom.Columns[5].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);
            SaveCustomProperties.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
        }

        protected void tlsPropertiesGroupsCustom_HtmlDataCellPrepared(object sender, TreeListHtmlDataCellEventArgs e)
        {
            if (e.GetValue("Designation").ToString() == "")
            {
                if (e.Column.FieldName == "PropertyDesignation")
                {
                    if (e.CellValue.ToString() != "")
                    {
                        Color bColor = Color.FromName("#c0e0e7");
                        e.Cell.BackColor = bColor;
                    }
                }
            }
        }

        protected void cmbMeasureUnit_C_Init(object sender, EventArgs e)
        {
            ASPxComboBox cmBox = sender as ASPxComboBox;
            TreeListDataCellTemplateContainer container = cmBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() == "")
                cmBox.Visible = false;
        }

        protected void cmbMeasureUnit_C_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ASPxComboBox cmBox = sender as ASPxComboBox;
            TreeListDataCellTemplateContainer container = cmBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() != "")
            {
                Session["ID_Properties"] = container.Value;
                cmBox.DataBind();
            }
        }


        protected void txtPropertyValue_Init(object sender, EventArgs e)
        {
            ASPxTextBox textBox = sender as ASPxTextBox;
            TreeListDataCellTemplateContainer container = textBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() == "")
                textBox.Visible = false;
        }

        protected void tlsPropertiesGroupsCustom_HtmlRowPrepared(object sender, TreeListHtmlRowEventArgs e)
        {
            if (e.GetValue("Designation").ToString() != "")
            {
                foreach (TableCell cell in e.Row.Cells)
                {
                    if (cell is DevExpress.Web.ASPxTreeList.Internal.TreeListSelectionCell)
                    {
                        (cell as DevExpress.Web.ASPxTreeList.Internal.TreeListSelectionCell).Controls[0].Visible = false;
                        break;
                    }
                }

            }
        }

        protected void SaveCustomProperties_Click(object sender, EventArgs e)
        {
            int IdArticle;
            int IdProperties;
            int IdMesureUnit = -1 ;            
           // int UserID = Convert.ToInt32(CurrentUser.Username);
            List<TreeListNode> tls = tlsPropertiesGroupsCustom.GetSelectedNodes();
            foreach (TreeListNode tl in tls)
            {
                if (tl.GetValue("PropertyID").ToString() != "")
                {
                    IdArticle = Convert.ToInt32(Session["ArticleID"]);
                    IdProperties = Convert.ToInt32(tl.GetValue("PropertyID"));
                    ASPxComboBox cmbMesureUnit = tlsPropertiesGroupsCustom.FindDataCellTemplateControl(tl.Key, null, "cmbMeasureUnit_C") as ASPxComboBox;
                    if( cmbMesureUnit.Value != null ) 
                        IdMesureUnit = Convert.ToInt32(cmbMesureUnit.Value.ToString());
                    ASPxTextBox txtVal = tlsPropertiesGroupsCustom.FindDataCellTemplateControl(tl.Key, null, "txtPropertyValue") as ASPxTextBox;                    
                    int IdSpec = Convert.ToInt32(Session["SpecID"].ToString());
                    MaterialsController.AddMaterialsProperties(IdArticle, IdProperties, IdMesureUnit, txtVal.Text, CurrentUser.UserID );
                    SpecificationController.AddMateriaslSpecProperties(IdProperties,  CurrentUser.UserID , IdSpec);
                }
            }
            popupValProperties.ShowOnPageLoad = true; 
            
        }

        protected void tlsPropertiesGroupsCustom_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            tlsPropertiesGroupsCustom.DataBind();
            var r = PortalSettings.PortalAlias.HTTPAlias;
        }

        

        


    }
}