using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Localization;
using VD.Modules.VBFramework;
using DataLayer;
using DevExpress.Web.ASPxTreeList;
using GlobalAPI; 

namespace VD.Modules.Materials
{
    public partial class Param_GroupProperties : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            tlProtertiesGrpMgr.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
        }

        protected void tlProtertiesGrpMgr_CustomCallback(object sender, DevExpress.Web.ASPxTreeList.TreeListCustomCallbackEventArgs e)
        {
            tlProtertiesGrpMgr.DataBind();
        }

        private void EditRow()
        {
            int nodeId = (int)tlProtertiesGrpMgr.FocusedNode.GetValue("ID");
            string nodeLib = (string)tlProtertiesGrpMgr.FocusedNode.GetValue("Designation");
            xTextBoxML txtBoxML = (xTextBoxML)tlProtertiesGrpMgr.FindEditFormTemplateControl("txtDesignation");
            txtBoxML.SetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name, nodeLib);
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            foreach (var langObj in languages)
            {
                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                {
                    var retLang = PropertyGroupController.GetPropertyGroupML(nodeId, langObj.Key);
                    if (retLang != null)
                    {
                        txtBoxML.SetTextFieldValueByLocale(langObj.Key, retLang.Designation);
                    }
                }
                else
                {
                    Materials_Properties_Groups protertyGrp = PropertyGroupController.GetPropertyGroup(nodeId);
                    if (protertyGrp!=null)
                    {
                        txtBoxML.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, protertyGrp.Designation);   
                    }
                }
            }
        }

        protected void tlProtertiesGrpMgr_HtmlRowPrepared(object sender, DevExpress.Web.ASPxTreeList.TreeListHtmlRowEventArgs e)
        {
            if (tlProtertiesGrpMgr.IsEditing)
            {
                ASPxButton btnCancel = tlProtertiesGrpMgr.FindEditFormTemplateControl("btnCancel") as ASPxButton;
                btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
                ASPxButton btnUpdate = tlProtertiesGrpMgr.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
                btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
                if (!tlProtertiesGrpMgr.IsNewNodeEditing)
                    EditRow(); 
            }
        }

        protected void tlProtertiesGrpMgr_CustomErrorText(object sender, TreeListCustomErrorTextEventArgs e)
        {
            if (e.ErrorText == "The node has descendant nodes.")
            {
                e.ErrorText = DotNetNuke.Services.Localization.Localization.GetString("deleteGrpPropertyErr", ressFilePath);
            }
        }

        protected void tlProtertiesGrpMgr_CustomDataCallback(object sender, TreeListCustomDataCallbackEventArgs e)
        {
            if (e.Argument.ToString() == "save")
            {
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                xTextBoxML txtBoxML = tlProtertiesGrpMgr.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                string defaultLanguageValue = txtBoxML.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                if (tlProtertiesGrpMgr.IsNewNodeEditing)
                {
                    int parentId = -1;
                    string libPropertyGroup;
                    if (defaultLanguageValue != "")
                        libPropertyGroup = defaultLanguageValue;
                    else
                        libPropertyGroup = txtBoxML.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);

                    if (tlProtertiesGrpMgr.FocusedNode != null)
                    {
                        parentId = Convert.ToInt32(tlProtertiesGrpMgr.FocusedNode.Key);
                    }

                    int newNodeId = PropertyGroupController.SetPropertyGroup(parentId, libPropertyGroup, CurrentUser.UserID);

                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            if (txtBoxML.GetTextFieldValueByLocale(langObj.Key) != "")
                            {
                                PropertyGroupController.SetPropertyGroupML(newNodeId, langObj.Key, txtBoxML.GetTextFieldValueByLocale(langObj.Key));   
                            }
                        }
                    }
                    tlProtertiesGrpMgr.CancelEdit();
                }
                else
                {
                    int nodeId = (int)tlProtertiesGrpMgr.FocusedNode.GetValue("ID");
                    Materials_Properties_Groups propertyGroup = PropertyGroupController.GetPropertyGroup(nodeId);
                    if (propertyGroup != null)
                    {
                        string designation;
                        if (defaultLanguageValue != "")
                            designation = defaultLanguageValue;
                        else
                            designation = txtBoxML.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                        PropertyGroupController.UpdatePropertyGroup(nodeId, designation, CurrentUser.UserID);
                    }
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            Materials_Properties_GroupsML propertyGroupML = PropertyGroupController.GetPropertyGroupML(nodeId, langObj.Key);
                            string designationML = txtBoxML.GetTextFieldValueByLocale(langObj.Key);
                            if (propertyGroupML == null)
                            {
                                if (designationML != "")
                                {
                                    PropertyGroupController.SetPropertyGroupML(nodeId, langObj.Key, designationML);   
                                }
                            }
                            else
                            {
                                if (designationML != "")
                                {
                                    PropertyGroupController.UpdatePropertyGroupML(nodeId, langObj.Key, designationML);
                                }
                            }
                        }
                    }
                }
                e.Result = "databingTree";
            }
            else if (e.Argument == "delete")
            {
                int nodeId = (int)tlProtertiesGrpMgr.FocusedNode.GetValue("ID");
                if (PropertyGroupController.deletePropertyGroupByID(nodeId))
                {
                    e.Result = DotNetNuke.Services.Localization.Localization.GetString("deleteGrpPropertyErr", ressFilePath);
                }
                else
                {
                    e.Result = "databingTree";
                }
            }
        }

    }
}