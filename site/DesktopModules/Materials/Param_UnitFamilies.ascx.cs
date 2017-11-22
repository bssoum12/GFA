using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using DataLayer;
using DotNetNuke.Services.Localization;
using System.Data.SqlClient;
using GlobalAPI;
using DevExpress.Web;
using VD.Modules.VBFramework;

namespace VD.Modules.Materials
{
    public partial class Param_UnitFamilies : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public  UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo() ;
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";     

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name; 
            TranslateUtility.localizeGrid(grdParam, ressFilePath);
            grdParam.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hNom", ressFilePath);
            toolbarMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnitFamilies", ressFilePath); 
            toolbarMenu.Items[0].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath); 
            
        }

        

        protected void grdParam_HtmlEditFormCreated(object sender, DevExpress.Web.ASPxGridViewEditFormEventArgs e)
        {
            ASPxButton btnCancel = grdParam.FindEditFormTemplateControl("btnCancel") as ASPxButton;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            ASPxButton btnUpdate = grdParam.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
            btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            if (! grdParam.IsNewRowEditing)
                EditRow(); 
        }

        private void EditRow()
        {
            Object[] retRef = (Object[]) grdParam.GetRowValues(grdParam.FocusedRowIndex, new string[] { "ID", "Designation"}) ;
            xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
            txtdesg.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, retRef[1].ToString());
            int Ref = Convert.ToInt32(retRef[0].ToString()); 

                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
               MaterialsDataContext layer = new MaterialsDataContext();
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        var retLang = UnitFamilyController.GetUnitFamiliesByLocale(Ref, langObj.Key); 
                        if (retLang != null)                        
                            txtdesg.SetTextFieldValueByLocale(langObj.Key, retLang.Description);
                        
                    }
                    else
                    {
                        var ret = UnitFamilyController.GetUnitFamiliesByID(Ref); 
                        if( ret != null )
                            txtdesg.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Designation );
                    }
                }
            
        }

        
        protected void grdParam_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "save")
            {
                string designation = string.Empty; 
               MaterialsDataContext layer = new MaterialsDataContext();
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
               xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                string defaultLanguageValue = txtdesg.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                if (grdParam.IsNewRowEditing)
                {                                                                              
                    if (defaultLanguageValue != "")                    
                        designation  = defaultLanguageValue ;                    
                    else                                                                    
                        designation = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    int key = UnitFamilyController.AddUnitFamilies(designation); 
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            designation = txtdesg.GetTextFieldValueByLocale(langObj.Key);
                            UnitFamilyController.AddUnitFamiliesML(key, designation, langObj.Key);                             
                        }
                    }                                        
                }
                else
                {
                    int retRef =  Convert.ToInt32( grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID")) ;
                        if (defaultLanguageValue != "")
                            designation  = defaultLanguageValue;
                        else
                            designation  = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    UnitFamilyController.UpdateUnitFamilies(retRef, designation); 
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            var existe = UnitFamilyController.FindUnitFamiliesByLocale(retRef, langObj.Key);
                            if (! existe)
                                UnitFamilyController.AddUnitFamiliesML( retRef , txtdesg.GetTextFieldValueByLocale(langObj.Key) , langObj.Key);                             
                            else
                                UnitFamilyController.UpdateUnitFamiliesML(retRef , txtdesg.GetTextFieldValueByLocale(langObj.Key)  , langObj.Key);                            
                        }
                    }
                    
                }
                grdParam.DataBind();
                grdParam.CancelEdit();
            }
        }


    }
}