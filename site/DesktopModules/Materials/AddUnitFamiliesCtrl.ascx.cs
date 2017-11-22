using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VD.Modules.VBFramework;
using GlobalAPI;
using DataLayer;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Localization;

namespace VD.Modules.Materials
{
    public partial class AddUnitFamiliesCtrl : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
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
                var ret = UnitFamilyController.GetUnitFamiliesByID(Key);
                txtDesignation.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, ret.Designation);
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        var retLang = UnitFamilyController.GetUnitFamiliesByLocale(Key, langObj.Key);
                        if (retLang != null)
                            txtDesignation.SetTextFieldValueByLocale(langObj.Key, retLang.Description);
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
                    AddUnitFamilies();                 
                else                
                    EditUnitFamilies();                 
            }
        }

        private void EditUnitFamilies()
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            string defaultLanguageValue = txtDesignation.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            int retRef = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
            string designation = string.Empty;
            if (defaultLanguageValue != "")
                designation = defaultLanguageValue;
            else
                designation = txtDesignation.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            UnitFamilyController.UpdateUnitFamilies(retRef, designation);
            foreach (var langObj in languages)
            {
                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                {
                    var Existe = UnitFamilyController.FindUnitFamiliesByLocale(retRef, langObj.Key);
                    if (Existe)
                        UnitFamilyController.AddUnitFamiliesML(retRef, txtDesignation.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                    else
                        UnitFamilyController.UpdateUnitFamiliesML(retRef, txtDesignation.GetTextFieldValueByLocale(langObj.Key), langObj.Key);                                           
                }
            }            
            popupValidation.ShowOnPageLoad = true;
        }

        private void AddUnitFamilies()
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            string defaultLanguageValue = txtDesignation.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            string designation = string.Empty;
            if (defaultLanguageValue != "")
                designation = defaultLanguageValue;
            else
                designation = txtDesignation.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            int key = UnitFamilyController.AddUnitFamilies(designation);
            if (key > -1)
            {
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        UnitFamilyController.AddUnitFamiliesML(key, txtDesignation.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                }                
                popupValidation.ShowOnPageLoad = true;
            }

        }
    }
}