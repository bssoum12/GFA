using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using DevExpress.Web;
using DataLayer;
using DotNetNuke.Services.Localization;
using System.Data.SqlClient;
using VD.Modules.VBFramework;

namespace VD.Modules.Materials
{
    public partial class Param_Norm : System.Web.UI.UserControl
    {
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name; 
            TranslateUtility.localizeGrid(grdParam, ressFilePath);
            grdParam.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hDesignation", ressFilePath);             
        }

        protected void grdParam_HtmlEditFormCreated(object sender, DevExpress.Web.ASPxGridViewEditFormEventArgs e)
        {
            ASPxButton btnCancel = grdParam.FindEditFormTemplateControl("btnCancel") as ASPxButton;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            ASPxButton btnUpdate = grdParam.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
            btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            if (!grdParam.IsNewRowEditing)
                EditRow(); 
        }


        private void EditRow()
        {
            Object[] retRef = (Object[])grdParam.GetRowValues(grdParam.FocusedRowIndex, new string[] { "ID", "Designation" });
            xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
            txtdesg.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, retRef[1].ToString());
            int Ref = Convert.ToInt32(retRef[0].ToString());
           
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                MaterialsDataContext layer = new MaterialsDataContext();
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        var retLang = (from x in layer.Materials_NormML  where x.NormID  == Ref && x.Locale == langObj.Key select x).SingleOrDefault();
                        if (retLang != null)
                        {
                            txtdesg.SetTextFieldValueByLocale(langObj.Key, retLang.Designation);
                        }
                    }
                    else
                    {
                        var ret = (from x in layer.Materials_Norm  where x.ID == Ref select x).SingleOrDefault();
                        if (ret != null)
                            txtdesg.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Designation);
                    }
                }
           
        }


        protected void grdParam_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "save")
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                string defaultLanguageValue = txtdesg.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                if (grdParam.IsNewRowEditing)
                {
                    Materials_Norm fam = new Materials_Norm();
                    if (defaultLanguageValue != "")
                        fam.Designation = defaultLanguageValue;
                    else
                        fam.Designation = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    layer.Materials_Norm.InsertOnSubmit(fam);
                    layer.SubmitChanges();
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            Materials_NormML matML = new Materials_NormML();
                            matML.NormID  = fam.ID;
                            matML.Designation = txtdesg.GetTextFieldValueByLocale(langObj.Key);
                            matML.Locale = langObj.Key;
                            layer.Materials_NormML.InsertOnSubmit(matML);
                            layer.SubmitChanges();
                        }
                    }
                    grdParam.DataBind();
                    grdParam.CancelEdit();

                }
                else
                {
                    int retRef = Convert.ToInt32(grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID"));
                    var UnitFam = (from p in layer.Materials_Norm  where p.ID == retRef select p).SingleOrDefault();
                    if (UnitFam != null)
                    {
                        if (defaultLanguageValue != "")
                            UnitFam.Designation = defaultLanguageValue;
                        else
                            UnitFam.Designation = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                        layer.SubmitChanges();
                    }
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            var UnitFamML = (from w in layer.Materials_NormML
                                             where w.NormID  == UnitFam.ID &&
                                             w.Locale == langObj.Key
                                             select w).SingleOrDefault();
                            if (UnitFamML == null)
                            {
                                Materials_NormML matML = new Materials_NormML();
                                matML.NormID  = UnitFam.ID;
                                matML.Designation = txtdesg.GetTextFieldValueByLocale(langObj.Key);
                                matML.Locale = langObj.Key;
                                layer.Materials_NormML.InsertOnSubmit(matML);
                                layer.SubmitChanges();
                            }
                            else
                            {
                                UnitFamML.Designation = txtdesg.GetTextFieldValueByLocale(langObj.Key);
                                layer.SubmitChanges();
                            }
                        }
                    }
                    grdParam.DataBind();
                    grdParam.CancelEdit();
                }
            }
        }
    }
}