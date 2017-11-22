using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Services.Localization;
using DataLayer;
using VD.Modules.VBFramework; 
using DotNetNuke.Entities.Users;
using GlobalAPI;


namespace VD.Modules.Materials
{
    public partial class AddMeasureUnitCtrl : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected void Page_Load(object sender, EventArgs e)
        { 
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            lblDescription.Text  = DotNetNuke.Services.Localization.Localization.GetString("hDesignation", ressFilePath);
            lblAbbreviation.Text  = DotNetNuke.Services.Localization.Localization.GetString("hAbreviation", ressFilePath);
            lblSystemMesure.Text  = DotNetNuke.Services.Localization.Localization.GetString("hSystemMeasure", ressFilePath);
            lblFamilleUnit.Text  = DotNetNuke.Services.Localization.Localization.GetString("hFamilyUnit", ressFilePath);
            btnSave.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            if (!IsPostBack)
            {
                if (HttpContext.Current.Request.QueryString["mode"] != null)
                {
                    string mode = HttpContext.Current.Request.QueryString["mode"].ToString();
                    if (mode == "edit")
                        LoadField();
                }
            }

        }


        private void LoadField()
        {
            if (HttpContext.Current.Request.QueryString["key"] != null)
            {
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                int Key = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
                var ret = MeasureUnitController.GetMeasureUnitById(Key);
                cmbFamilyUnit.Value = ret.ID_FamilyUnites;
                cmbSystemeMesure.Value = ret.ID_SystemMeasure;
                txtAbbreviation.Text = ret.Abreviation; 
                txtDesignation.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, ret.Designation);
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        var retLang = MeasureUnitController.GetMeasureUnitByLocale(Key, langObj.Key);
                        if (retLang != null)
                            txtDesignation.SetTextFieldValueByLocale(langObj.Key, retLang.Designation );
                    }
                    else
                        txtDesignation.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Designation);

                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.QueryString["mode"] != null)
            {
                string mode = HttpContext.Current.Request.QueryString["mode"].ToString();
                if (mode == "add")
                    AddMeasureUnit();
                else
                    EditMeasureUnit();                
            }
        }

        private void EditMeasureUnit()
        {
            if (HttpContext.Current.Request.QueryString["key"] != null)
            {
                int retRef = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                string defaultLanguageValue = txtDesignation.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);                
                string designation = string.Empty;
                if (defaultLanguageValue != "")
                    designation = defaultLanguageValue;
                else
                    designation = txtDesignation.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                MeasureUnitController.UpdateMeasureUnit(retRef, designation, txtAbbreviation.Text, Convert.ToInt32(cmbSystemeMesure.Value), Convert.ToInt32(cmbFamilyUnit.Value), CurrentUser.UserID);
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        var Existe = MeasureUnitController.FindMeasureUnitByLocale(retRef, langObj.Key);
                        if (Existe)
                            MeasureUnitController.AddMeasureUnitML(retRef, txtDesignation.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                        else
                            MeasureUnitController.UpdateMeasureUnitML(retRef, txtDesignation.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                        
                    }
                }
                
                popupValidation.ShowOnPageLoad = true;
            }
        }
      
        private void AddMeasureUnit()
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            string defaultLanguageValue = txtDesignation.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            string designation = string.Empty;
            if (defaultLanguageValue != "")
                designation = defaultLanguageValue;
            else
                designation = txtDesignation.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            int key = MeasureUnitController.AddMeasureUnit(designation, txtAbbreviation.Text, Convert.ToInt32(cmbSystemeMesure.Value), Convert.ToInt32(cmbFamilyUnit.Value), CurrentUser.UserID);
            foreach (var langObj in languages)
            {
                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                {
                    designation = txtDesignation.GetTextFieldValueByLocale(langObj.Key);
                    MeasureUnitController.AddMeasureUnitML(key, designation, langObj.Key);
                }
            }
            
            popupValidation.ShowOnPageLoad = true;

        }

        protected void cmbSystemeMesure_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            cmbSystemeMesure.DataBind(); 
        }

        protected void cmbFamilyUnit_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            cmbFamilyUnit.DataBind(); 
        }
    }
}