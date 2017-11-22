using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Users;
using VD.Modules.VBFramework; 
using DevExpress.Web;
using DataLayer;
using DotNetNuke.Services.Localization;
using System.Data.SqlClient;
using GlobalAPI;
using VD.Modules.Framework;

namespace VD.Modules.Materials
{
    public partial class Param_MeasureSystem : DotNetNuke.Entities.Modules.PortalModuleBase
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
            toolbarMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureSystems", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Text  = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[1].Text  = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[2].Text  =  DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath); 
            
            
        }

        protected void grdParam_HtmlEditFormCreated(object sender, DevExpress.Web.ASPxGridViewEditFormEventArgs e)
        {
            ASPxButton btnCancel = grdParam.FindEditFormTemplateControl("btnCancel") as ASPxButton;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            ASPxButton btnUpdate = grdParam.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
            btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            if (! grdParam.IsNewRowEditing )
                EditRow(); 
        }

        private void EditRow()
        {
            Object[] retRef = (Object[])grdParam.GetRowValues(grdParam.FocusedRowIndex, new string[] { "ID", "Designation" });
            xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
            txtdesg.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, retRef[1].ToString());
            int Ref = Convert.ToInt32(retRef[0].ToString());
      
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);                
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                                             
                        var retLang = MeasureSystemController.GetMeasureSystemMLByLang(Ref, langObj.Key); 
                        if (retLang != null)                        
                            txtdesg.SetTextFieldValueByLocale(langObj.Key, retLang.Designation );
                        
                    }
                    else
                    {
                        var ret = MeasureSystemController.GetMeasureSystemByID(Ref); 
                        if (ret != null)
                            txtdesg.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Designation);
                    }
                }
           
        }
        protected void grdParam_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "save")
            {
                string designation = string.Empty;                
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                string defaultLanguageValue = txtdesg.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                if (grdParam.IsNewRowEditing)
                {
                    Materials_MeasureSystem fam = new Materials_MeasureSystem();
                    if (defaultLanguageValue != "")
                        designation  = defaultLanguageValue;
                    else
                        designation = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                  int key = MeasureSystemController.AddMeasureSystem(designation);
                  if (key > -1)
                  {
                      foreach (var langObj in languages)
                      {
                          if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                                MeasureSystemController.AddMeasureSystemML(key, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                      }
                  }                   
                }
                else
                {
                    int retRef = Convert.ToInt32(grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID"));
                    
                        if (defaultLanguageValue != "")
                            designation = defaultLanguageValue;
                        else
                            designation  = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    MeasureSystemController.UpdateMeasureSystem(retRef, designation);                         
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            if (!MeasureSystemController.FindMeasureSystemByLocale(retRef, langObj.Key))
                                MeasureSystemController.AddMeasureSystemML(retRef, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                            else
                                MeasureSystemController.UpdateMeasureSystemByLocale(retRef, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key);                              
                            
                        }
                    }                    
                }
                grdParam.DataBind();
                grdParam.CancelEdit();
            }
        }

    }
}