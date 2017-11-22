using DataLayer;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Localization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VD.Modules.VBFramework;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class AddBrandCtrl : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            btnSave.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            lblDesignation.Text = DotNetNuke.Services.Localization.Localization.GetString("hNom", ressFilePath);
            if (!IsPostBack)
            {                
                if (HttpContext.Current.Request.QueryString["mode"] != null)
                {
                    string mode = HttpContext.Current.Request.QueryString["mode"].ToString();
                    if (mode == "edit")
                    {

                        if (HttpContext.Current.Request.QueryString["key"] != null)
                        {
                            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                            int Key = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
                            var ms = BrandController.GetBrandByID(Key);
                            txtDesignation.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, ms.Designation);
                            foreach (var langObj in languages)
                            {
                                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                                {
                                    var retLang = BrandController.GetBrandMLByLang(Key, langObj.Key); 
                                    if (retLang != null)                                    
                                        txtDesignation.SetTextFieldValueByLocale(langObj.Key, retLang.Designation);                                    
                                }
                                else                                                                    
                                        txtDesignation.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ms.Designation);                                
                            }
                        }                        
                    }

                }
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
                            
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                string defaultLanguageValue = txtDesignation.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                string designation = string.Empty; 
                if (HttpContext.Current.Request.QueryString["mode"] != null)
                {
                    string mode = HttpContext.Current.Request.QueryString["mode"].ToString();
                    if (mode == "add")
                    {                        
                        if (defaultLanguageValue != "")
                           designation = defaultLanguageValue;
                        else
                            designation = txtDesignation.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                        int key = BrandController.AddBrand(designation);
                        if (key > -1)
                        {
                            foreach (var langObj in languages)
                            {                                
                                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                                {
                                    designation = txtDesignation.GetTextFieldValueByLocale(langObj.Key);
                                BrandController.AddBrandML(key , designation , langObj.Key);                                    
                                }
                            }
                                                
                        popupValidation.ShowOnPageLoad = true;
                        }

                    }
                    else
                    {
                        int retRef = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
                        
                            if (defaultLanguageValue != "")
                                designation = defaultLanguageValue;
                            else
                                designation  = txtDesignation.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    BrandController.UpdateBrand(retRef, designation); 
                        foreach (var langObj in languages)
                        {
                            if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                            {                                
                                var existe  = BrandController.FindBrandByLocale(retRef, langObj.Key); 
                                designation = txtDesignation.GetTextFieldValueByLocale(langObj.Key) ; 
                                if (existe)
                                BrandController.AddBrandML(retRef, designation , langObj.Key); 
                                else
                                BrandController.UpdateBrandByLocale(retRef, designation , langObj.Key);
                            }
                        }
                        
                        popupValidation.ShowOnPageLoad = true;
                }
            }
        }
    }
}