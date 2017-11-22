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
    public partial class AddNewSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        static string specIdParent;
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblAddNewSpecUI.Text = "";
            lblNewSpecLib.Text = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("lbClose", ressFilePath);
            if (Request.QueryString["specid"] != null)
            {
                try
                {
                    //Get id spec from url
                    specIdParent = Request.QueryString["specid"];
                }
                catch
                {

                }
            }
            else
            {
                try
                {
                    specIdParent = Session["specid"].ToString();
                }
                catch (Exception)
                {
                }
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {            
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            string defaultLanguageValue = this.txtEIFCtrl.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            string result = "";
            if (defaultLanguageValue != "")
            {
                //insert in default :  defaultLanguageValue
                result = SpecificationController.AddNewSpec(specIdParent, defaultLanguageValue, Utili.UserID);
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
                    lblAddNewSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAddNewSpec", ressFilePath);  
                }
                else
                {
                    lblAddNewSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
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
                result = SpecificationController.AddNewSpec(specIdParent, txtBoxCurrentLanguageValue, Utili.UserID);
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
                    lblAddNewSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAddNewSpec", ressFilePath);
                }
                else
                {
                    lblAddNewSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                }
                foreach (var lang in languages)
                {
                    this.txtEIFCtrl.SetTextFieldValueByLocale(lang.Key, "");
                }
            }
        }
    }
}
