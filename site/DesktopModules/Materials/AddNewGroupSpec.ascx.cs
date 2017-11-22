using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;
using DotNetNuke.Entities.Users;
using VD.Modules.VBFramework;  
using DotNetNuke.Services.Localization;
using GlobalAPI; 


namespace VD.Modules.Materials
{
    public partial class AddNewGroupSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblAddNewSpecGrpUI.Text = "";
            lblNewSpecGrpLib.Text = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("lbClose", ressFilePath);
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            try
            {
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            string defaultLanguageValue = this.txtEIFCtrl.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            string result = "";
            if (defaultLanguageValue != "")
            {
                //insert in default :  defaultLanguageValue
                result = SpecificationController.AddNewSpec("", defaultLanguageValue, Utili.UserID);
                if (result.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "ID")
                {
                    int idSpec = int.Parse(result.Split(new string[] { ";" }, StringSplitOptions.None)[1]);
                    //Add Spec To Discipline
                    if (Request.QueryString["DisciplineID"] != null)
                        SpecificationController.AssignMatSpecToDiscipline(Request.QueryString["DisciplineID"].ToString(), idSpec, Utili.UserID);
                    foreach (var lang in languages)
                    {
                        if (lang.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            String multiLanguageValue = this.txtEIFCtrl.GetTextFieldValueByLocale(lang.Key);
                            if (multiLanguageValue != "")
                            {
                                SpecificationController.SetSpecML(idSpec, multiLanguageValue, lang.Key,Utili.UserID);
                            }
                        }
                    }
                    lblAddNewSpecGrpUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAddNewGroupSpecMsg", ressFilePath);  
                }
                else
                {
                    lblAddNewSpecGrpUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                }
                foreach (var lang in languages)
                {
                    this.txtEIFCtrl.SetTextFieldValueByLocale(lang.Key, "");
                }
            }
            else
            {
                string txtBoxCurrentLanguageValue = this.txtEIFCtrl.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                if (txtBoxCurrentLanguageValue == "")
                {
                    return;
                }
                result = SpecificationController.AddNewSpec("", txtBoxCurrentLanguageValue, Utili.UserID);
                if (result.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "ID")
                {
                    int idSpec = int.Parse(result.Split(new string[] { ";" }, StringSplitOptions.None)[1]);
                    //Add Spec To Discipline
                    if (Request.QueryString["DisciplineID"] != null)
                        SpecificationController.AssignMatSpecToDiscipline(Request.QueryString["DisciplineID"].ToString(), idSpec, Utili.UserID);
                    foreach (var lang in languages)
                    {
                        if (lang.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            String multiLanguageValue = this.txtEIFCtrl.GetTextFieldValueByLocale(lang.Key);
                            if (multiLanguageValue != "")
                            {
                                SpecificationController.SetSpecML(idSpec, multiLanguageValue, lang.Key, Utili.UserID);
                            }
                        }
                    }
                    lblAddNewSpecGrpUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAddNewGroupSpecMsg", ressFilePath);
                }
                else
                {
                    lblAddNewSpecGrpUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                }
                foreach (var lang in languages)
                {
                    this.txtEIFCtrl.SetTextFieldValueByLocale(lang.Key, "");
                }
            }
            }
            catch (Exception ex)
            {
                GlobalAPI.CommunUtility.logEvent("Error tlMatSpec_NodeInserted : " + ex.Message, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles );
            }
        }
    }
}