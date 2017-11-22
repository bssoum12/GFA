using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Users;
using VD.Modules.VBFramework;
using VD.Modules.Framework;
using DevExpress.Web;
using DataLayer;
using DotNetNuke.Services.Localization;
using System.Data.SqlClient;
using GlobalAPI;


namespace VD.Modules.Materials
{
    public partial class Param_TechnicalSoftware : DotNetNuke.Entities.Modules.PortalModuleBase
    {

        /// <summary>
        /// The current user
        /// </summary>
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        /// <summary>
        /// The ress file path
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
            toolbarMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnTechnicalSoftware", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

        }
        /// <summary>
        /// Handles the HtmlEditFormCreated event of the grdParam control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewEditFormEventArgs"/> instance containing the event data.</param>
        protected void grdParam_HtmlEditFormCreated(object sender, DevExpress.Web.ASPxGridViewEditFormEventArgs e)
        {
            ASPxButton btnCancel = grdParam.FindEditFormTemplateControl("btnCancel") as ASPxButton;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            ASPxButton btnUpdate = grdParam.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
            btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            if (!grdParam.IsNewRowEditing)
                EditRow();
        }

        /// <summary>
        /// Edits the current row.
        /// </summary>
        private void EditRow()
        {
            Object[] retRef = (Object[])grdParam.GetRowValues(grdParam.FocusedRowIndex, new string[] { "ID", "Name", "Editor", "Version" });
            xTextBoxML txtName = grdParam.FindEditFormTemplateControl("txtName") as xTextBoxML;
            xTextBoxML txtEditor = grdParam.FindEditFormTemplateControl("txtEditor") as xTextBoxML;
            ASPxTextBox txtVersion = grdParam.FindEditFormTemplateControl("txtVersion") as ASPxTextBox;
            txtName.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, retRef[1].ToString());
            txtEditor.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, retRef[2].ToString());
            txtVersion.Text = retRef[3].ToString(); 

            int Ref = Convert.ToInt32(retRef[0].ToString());
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            foreach (var langObj in languages)
            {
                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                {
                    var retLang = SoftwareController.GetTechnicalSoftwareByLang(Ref, langObj.Key);
                    if (retLang != null)
                    {
                        txtName.SetTextFieldValueByLocale(langObj.Key, retLang.Name);
                        txtEditor.SetTextFieldValueByLocale(langObj.Key, retLang.Editor);
                    }
                }
                else
                {
                    var ret = SoftwareController.GetTechnicalSoftwareByID(Ref);
                    if (ret != null)
                    {
                        txtEditor.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Editor );
                        txtName.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, ret.Name );
                    }
                }
            } 
        }

        /// <summary>
        /// Handles the CustomCallback event of the grdParam control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdParam_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "save")
            {                
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);                
                xTextBoxML txtName = grdParam.FindEditFormTemplateControl("txtName") as xTextBoxML;
                xTextBoxML txtEditor = grdParam.FindEditFormTemplateControl("txtEditor") as xTextBoxML;
                ASPxTextBox txtVersion = grdParam.FindEditFormTemplateControl("txtVersion") as ASPxTextBox;
                string Name = string.Empty;
                string Editor = string.Empty;                 
                if (grdParam.IsNewRowEditing)
                {
                    Materials_TechnicalSoftwares fam = new Materials_TechnicalSoftwares();
                    if (txtName.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code) != "")
                        Name = txtName.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                    else
                        Name = txtName.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);

                    if (txtEditor.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code) != "")
                        Editor = txtEditor.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                    else
                        Editor = txtEditor.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);


                    int key = SoftwareController.AddTechnicalSoftware(Name, Editor, txtVersion.Text); 
                    if (key > -1)
                    {
                        foreach (var langObj in languages)
                        {
                            if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                                SoftwareController.AddTechnicalSoftwareML(key, txtName.GetTextFieldValueByLocale(langObj.Key), txtEditor.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                        }
                    }
                }
                else
                {
                    int retRef = Convert.ToInt32(grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID"));
                    if (txtName.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code) != "")
                        Name = txtName.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                    else
                        Name = txtName.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    if (txtEditor.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code) != "")
                        Editor = txtEditor.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                    else
                        Editor = txtEditor.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    SoftwareController.UpdateTechnicalSoftware(retRef , Name , Editor , txtVersion.Text );
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            if (!SoftwareController.FindTechnicalSoftwareByLocale(retRef, langObj.Key))
                                SoftwareController.AddTechnicalSoftwareML(retRef, txtName.GetTextFieldValueByLocale(langObj.Key), txtEditor.GetTextFieldValueByLocale(langObj.Key), langObj.Key);
                            else
                                SoftwareController.UpdateTechnicalSoftwareByLocale(retRef, txtName.GetTextFieldValueByLocale(langObj.Key), txtEditor.GetTextFieldValueByLocale(langObj.Key), langObj.Key);

                        }
                    }
                }
                grdParam.DataBind();
                grdParam.CancelEdit();
            }
        }

    }
}