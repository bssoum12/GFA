using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VD.Modules.Framework;
using DotNetNuke.Entities.Users;
using System.Data.SqlClient;
using DevExpress.Web;
using DotNetNuke.Services.Localization;
using DataLayer;
using GlobalAPI;
using VD.Modules.VBFramework;

namespace VD.Modules.Materials
{
    public partial class Param_MeasureUnit : DotNetNuke.Entities.Modules.PortalModuleBase
    {
         
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
         
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
         
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            TranslateUtility.localizeGrid(grdParam, ressFilePath);
            grdParam.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hNom", ressFilePath);
            grdParam.Columns["Abreviation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hAbreviation", ressFilePath);
            grdParam.Columns["ID_SystemMeasure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hSystemMeasure", ressFilePath);
            grdParam.Columns["ID_FamilyUnites"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hFamilyUnit", ressFilePath);
            toolbarMenu.Items[0].Text  = popupMenu.Items[0].Text =  DotNetNuke.Services.Localization.Localization.GetString("mnMeasureUnits", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[0].Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[0].Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);
            toolbarMenu.Items[1].Text = popupMenu.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureSystems", ressFilePath);
            toolbarMenu.Items[1].Items[0].Text = popupMenu.Items[1].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[1].Items[1].Text = popupMenu.Items[1].Items[1].Text =  DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[2].Text = popupMenu.Items[2].Text =  DotNetNuke.Services.Localization.Localization.GetString("mnUnitFamilies", ressFilePath);
            toolbarMenu.Items[2].Items[0].Text = popupMenu.Items[2].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[2].Items[1].Text = popupMenu.Items[2].Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);            
        }




         
        private void EditRow()
        {
            Object[] retRef = (Object[])grdParam.GetRowValues(grdParam.FocusedRowIndex, new string[] { "ID", "Designation", "Abreviation", "ID_SystemMeasure", "ID_FamilyUnites" });
            ASPxTextBox txtAbb = (ASPxTextBox)grdParam.FindEditFormTemplateControl("txtAbbreviation");
            txtAbb.Text = retRef[2].ToString();             
            ASPxComboBox cmbMeasure = (ASPxComboBox)grdParam.FindEditFormTemplateControl("cmbSystemeMesure");
            cmbMeasure.Value = Convert.ToInt32(retRef[3].ToString());
            ASPxComboBox cmbfamily = (ASPxComboBox)grdParam.FindEditFormTemplateControl("cmbFamilyUnit");
            cmbfamily.Value = Convert.ToInt32(retRef[4].ToString()); 
            xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
            txtdesg.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, retRef[1].ToString());
            int Ref = Convert.ToInt32(retRef[0].ToString());
          
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        var retLang = MeasureUnitController.GetMeasureUnitByLocale(Ref, langObj.Key); 
                        if (retLang != null)
                            txtdesg.SetTextFieldValueByLocale(langObj.Key, retLang.Designation);
                    }
                    else
                    {
                        var ret = MeasureUnitController.GetMeasureUnitById(Ref); 
                        if (ret != null)
                            txtdesg.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Designation);
                    }
                }
            
        }

 
        protected void grdParam_HtmlEditFormCreated(object sender, ASPxGridViewEditFormEventArgs e)
        {          

            ASPxButton btnCancel = grdParam.FindEditFormTemplateControl("btnCancel") as ASPxButton;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            ASPxButton btnUpdate = grdParam.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
            btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            
            if (!grdParam.IsNewRowEditing)
                EditRow(); 
        }

        
        protected void grdParam_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "save")
            {
                string designation = string.Empty;                 
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                string defaultLanguageValue = txtdesg.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                ASPxTextBox txtAbb = (ASPxTextBox)grdParam.FindEditFormTemplateControl("txtAbbreviation");
                ASPxComboBox cmbfamily = (ASPxComboBox)grdParam.FindEditFormTemplateControl("cmbFamilyUnit");
                ASPxComboBox cmbMeasure = (ASPxComboBox)grdParam.FindEditFormTemplateControl("cmbSystemeMesure");
                if (grdParam.IsNewRowEditing)
                {

                    Materials_MeasureUnit fam = new Materials_MeasureUnit();
                    if (defaultLanguageValue != "")
                        designation  = defaultLanguageValue;
                    else
                        designation  = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    int key = MeasureUnitController.AddMeasureUnit(designation, txtAbb.Text, Convert.ToInt32(cmbMeasure.Value), Convert.ToInt32(cmbfamily.Value), CurrentUser.UserID);                     
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                            MeasureUnitController.AddMeasureUnitML(key, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key);                                     
                    }
                }
                else
                {
                    int retRef = Convert.ToInt32(grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID"));                    
                        if (defaultLanguageValue != "")
                            designation  = defaultLanguageValue;
                        else
                            designation  = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    MeasureUnitController.UpdateMeasureUnit(retRef, designation, txtAbb.Text, Convert.ToInt32(cmbMeasure.Value), Convert.ToInt32(cmbfamily.Value), CurrentUser.UserID);                     
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {                            
                            if (!MeasureUnitController.FindMeasureUnitByLocale(retRef, langObj.Key))
                                MeasureUnitController.AddMeasureUnitML(retRef, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key); 
                            else
                                MeasureUnitController.UpdateMeasureUnitML(retRef, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key); 
                        }
                    }                    
                }
                grdParam.DataBind();
                grdParam.CancelEdit();
            }
        }
    }
}
