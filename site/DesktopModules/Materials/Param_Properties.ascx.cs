using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VD.Modules.Framework;
using VD.Modules.VBFramework;
using DotNetNuke.Entities.Users;
using System.Data.SqlClient;
using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using DataLayer;
using DotNetNuke.Services.Localization;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class Param_Properties : DotNetNuke.Entities.Modules.PortalModuleBase
    {
       
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
       
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected string _portalAlias = "";
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            //************************ Grid Properties
            TranslateUtility.localizeGrid(grdParam, ressFilePath);            
            grdParam.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hNom", ressFilePath);
            
            

            //************************ Grid Mesure Unit
            TranslateUtility.localizeGrid(grdMeasureUnit, ressFilePath);
            grdMeasureUnit.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hNom", ressFilePath);
            grdMeasureUnit.Columns["Abreviation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hAbreviation", ressFilePath);
            grdMeasureUnit.Columns["ID_SystemMeasure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hSystemMeasure", ressFilePath);
            grdMeasureUnit.Columns["ID_FamilyUnites"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hFamilyUnit", ressFilePath);
            btnSaveUniteMesure.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            popupAffecterUniteMesure.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("hAffecterUniteMesure", ressFilePath);
            
        }

        /// <summary>
        /// Handles the CustomCallback event of the grdParam control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdParam_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "save")
            {
                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                ASPxTextBox txtFormat = grdParam.FindEditFormTemplateControl("txtFormat") as ASPxTextBox;

                string defaultLanguageValue = txtdesg.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                if (grdParam.IsNewRowEditing)
                {
                    string libProperty = "";
                    if (defaultLanguageValue != "")
                        libProperty = defaultLanguageValue;
                    else
                        libProperty = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    
                    string groupId = null;
                    try
                    {
                        if(hfPropertyGrp["Id_PropertyGrp"]!=null)
                            groupId = hfPropertyGrp["Id_PropertyGrp"].ToString();
                    }
                    catch (Exception)
                    {
                        groupId = null;
                    }

                    if (PropertyController.ExistsProperty(libProperty))
                        throw new Exception(DotNetNuke.Services.Localization.Localization.GetString("mAlreadyExistError", ressFilePath));

                    string result = PropertyController.NewProperty(libProperty, groupId, txtFormat.Text, CurrentUser.UserID);
                    if (result.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "ID")
                    {
                        int newPropertyId = Convert.ToInt32(result.Split(new string[] { ";" }, StringSplitOptions.None)[1]);
                        foreach (var langObj in languages)
                        {
                            if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                            {
                                if (txtdesg.GetTextFieldValueByLocale(langObj.Key) != "")
                                {
                                    PropertyController.NewPropertyML(newPropertyId, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key, CurrentUser.UserID);
                                }
                            }
                        }
                        grdParam.DataBind();
                        grdParam.CancelEdit();
                    }
                }
                else
                {
                    int retRef = Convert.ToInt32(grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID"));
                    string libProperty = "";
                    if (defaultLanguageValue != "")
                        libProperty = defaultLanguageValue;
                    else
                        libProperty = txtdesg.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                    string groupId = null;

                    try
                    {
                        if (hfPropertyGrp["Id_PropertyGrp"] != null)
                            groupId = hfPropertyGrp["Id_PropertyGrp"].ToString();
                    }
                    catch (Exception)
                    {
                        groupId = null;
                    }
                    
                    if((PropertyController.GetProperty(retRef).Designation!= libProperty) && (PropertyController.ExistsProperty(libProperty)))
                        throw new Exception(DotNetNuke.Services.Localization.Localization.GetString("mAlreadyExistError", ressFilePath));

                    PropertyController.UpdateProperty(retRef, libProperty, groupId, txtFormat.Text, CurrentUser.UserID);
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            Materials_PropertiesML PropertyML = PropertyController.GetPropertyML(retRef, langObj.Key);
                            if (PropertyML == null)
                            {
                                if (txtdesg.GetTextFieldValueByLocale(langObj.Key) != "")
                                {
                                    PropertyController.NewPropertyML(retRef, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key, CurrentUser.UserID);
                                }
                            }
                            else
                            {
                                if (txtdesg.GetTextFieldValueByLocale(langObj.Key) != "")
                                {
                                    PropertyController.UpdatePropertyML(retRef, txtdesg.GetTextFieldValueByLocale(langObj.Key), langObj.Key, CurrentUser.UserID);    
                                }
                            }
                        }
                    }
                    grdParam.DataBind();
                    grdParam.CancelEdit();
                }
            }
        }

        /// <summary>
        /// Handles the HtmlEditFormCreated event of the grdParam control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewEditFormEventArgs"/> instance containing the event data.</param>
        protected void grdParam_HtmlEditFormCreated(object sender, DevExpress.Web.ASPxGridViewEditFormEventArgs e)
        {
            
            ASPxLabel lblDesignation = (ASPxLabel)grdParam.FindEditFormTemplateControl("lblDesignation");
            lblDesignation.Text = DotNetNuke.Services.Localization.Localization.GetString("hDesignation", ressFilePath);
            ASPxLabel lblPropertyGrp = (ASPxLabel)grdParam.FindEditFormTemplateControl("lblPropertyGrp");
            lblPropertyGrp.Text = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            ASPxLabel lblFormat = (ASPxLabel)grdParam.FindEditFormTemplateControl("lblFormat");
            lblFormat.Text = DotNetNuke.Services.Localization.Localization.GetString("hFormat", ressFilePath);
            ASPxButton btnCancel = grdParam.FindEditFormTemplateControl("btnCancel") as ASPxButton;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            ASPxButton btnUpdate = grdParam.FindEditFormTemplateControl("btnUpdate") as ASPxButton;
            btnUpdate.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            if (!grdParam.IsNewRowEditing)
                EditRow();
        }

        /// <summary>
        /// Edits the focused row.
        /// </summary>
        private void EditRow()
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            if (grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID") != null)
            {
                int Id_property = Convert.ToInt32(grdParam.GetRowValues(grdParam.FocusedRowIndex, "ID"));
               Materials_Properties property = PropertyController.GetProperty(Id_property);
                xTextBoxML txtdesg = grdParam.FindEditFormTemplateControl("txtDesignation") as xTextBoxML;
                ASPxTextBox txtFormat = grdParam.FindEditFormTemplateControl("txtFormat") as ASPxTextBox;
                ASPxDropDownEdit ddePropertyGrp = (ASPxDropDownEdit)grdParam.FindEditFormTemplateControl("ddePropertyGrp");
                ASPxTreeList tlProtertiesGrpMgr = (ASPxTreeList)ddePropertyGrp.FindControl("tlProtertiesGrpMgr");
                
                if (property.Format != null)
                {
                    //Set property fromat
                    txtFormat.Text = property.Format;
                }
                if (property.GroupId != null)
                {
                    string Id_PropertyGrp = property.GroupId.ToString();
                    DevExpress.Web.ASPxTreeList.TreeListNode node = tlProtertiesGrpMgr.FindNodeByKeyValue(Id_PropertyGrp);
                    TreeListNodeIterator ListNode = tlProtertiesGrpMgr.CreateNodeIterator();
                    while (ListNode.Current != null)
                    {
                        if (ListNode.Current.Key == Id_PropertyGrp)
                        {
                            ListNode.Current.Focus();
                        }
                        ListNode.GetNext();
                    }
                    if (System.Threading.Thread.CurrentThread.CurrentCulture.Name
                                != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                       Materials_Properties_GroupsML propertyGrpML = PropertyGroupController.GetPropertyGroupML(Convert.ToInt32(Id_PropertyGrp), System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                        if (propertyGrpML != null)
                        {
                            ddePropertyGrp.Text = propertyGrpML.Designation;
                        }
                        else
                        {
                           Materials_Properties_Groups propertyGrp = PropertyGroupController.GetPropertyGroup(Convert.ToInt32(Id_PropertyGrp));
                            ddePropertyGrp.Text = propertyGrp.Designation;
                        }
                    }
                    else
                    {
                       Materials_Properties_Groups propertyGrp = PropertyGroupController.GetPropertyGroup(Convert.ToInt32(Id_PropertyGrp));
                        ddePropertyGrp.Text = propertyGrp.Designation;
                    }
                }
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                       Materials_PropertiesML propertyML = PropertyController.GetPropertyML(Id_property, langObj.Key);
                        if (propertyML != null)
                        {
                            //Set PropertyML Designation
                            txtdesg.SetTextFieldValueByLocale(langObj.Key, propertyML.Designation);
                        }
                    }
                    else
                    {
                        //Set Property Designation
                        if (property != null)
                            txtdesg.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, property.Designation);
                    }
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the btnSaveUniteMesure control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnSaveUniteMesure_Click(object sender, EventArgs e)
        {
            var LstMeasureUnit = grdMeasureUnit.GetSelectedFieldValues( grdMeasureUnit.KeyFieldName ); 
            int IdProperties = Convert.ToInt32(txtPropertiesID.Text ) ;
            if (PropertyController.DeletePropertiesMeasureUnit(IdProperties))
            {
                foreach (int IdMeasureUnit in LstMeasureUnit)
                {
                    PropertyController.InsertProperties_MeasureUnit(IdProperties, IdMeasureUnit, CurrentUser.UserID);
                }
                grdMeasureUnit.Dispose();
                grdMeasureUnit.DataBind();
                popupAffecterUniteMesure.ShowOnPageLoad = false;    
            }
        }

        /// <summary>
        /// Handles the CustomCallback event of the grdMeasureUnit control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdMeasureUnit_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters != null)
            {
                grdMeasureUnit.Dispose();
                grdMeasureUnit.Selection.UnselectAll(); 
                grdMeasureUnit.DataBind();
                int IdProperties = Convert.ToInt32(e.Parameters.ToString()  ) ;
                List<int> ret = PropertyController.GetListIdMeasureUnitByIdPropertiy(IdProperties);
                foreach (int IdMeasureUnit in ret)
                {
                    grdMeasureUnit.Selection.SelectRowByKey(IdMeasureUnit); 
                }
                
            }


        }

        /// <summary>
        /// Handles the DataBound event of the tlProtertiesGrpMgr control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void tlProtertiesGrpMgr_DataBound(object sender, EventArgs e)
        {
            ASPxTreeList tlProtertiesGrpMgr = (ASPxTreeList)sender;
            tlProtertiesGrpMgr.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
        }

        protected void grdParam_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            if (PropertyController.DeletePropertyByID(Convert.ToInt32(e.Keys["ID"])) != "ok")
            {
                Exception ex = new Exception(DotNetNuke.Services.Localization.Localization.GetString("deletePropertyErr", ressFilePath));
                throw ex;
            }
            e.Cancel = true;
        }

    }
}