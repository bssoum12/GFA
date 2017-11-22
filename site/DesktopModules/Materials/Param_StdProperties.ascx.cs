using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Services.Localization;
using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using GlobalAPI;

namespace VD.Modules.Materials
{
     
    public partial class Param_StdProperties : DotNetNuke.Entities.Modules.PortalModuleBase
    {

       
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
         
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string _portalAlias = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;

            if (! IsPostBack )
            {
                Session["IDNorme"] = -1;
                Session["IDNC"] = -1;
                Session["GroupId"] = -1;
            }

            lblStd.Text = DotNetNuke.Services.Localization.Localization.GetString("hNormTitle", ressFilePath);
            lblCase.Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("mnuCases", ressFilePath).Replace(@"\", ""), "");
            
            //Traduction de PageControl
            PageControl.TabPages.FindByName("rangeTab").Text = DotNetNuke.Services.Localization.Localization.GetString("lbRangeTab", ressFilePath);
            PageControl.TabPages.FindByName("stepTab").Text = DotNetNuke.Services.Localization.Localization.GetString("lbStepTab", ressFilePath);
            PageControl.TabPages.FindByName("matrixTab").Text = DotNetNuke.Services.Localization.Localization.GetString("lbPropFct", ressFilePath);
            //Traduction grdProperty
            TranslateUtility.localizeGrid(grdProperty, ressFilePath);
            grdProperty.SettingsText.PopupEditFormCaption = DotNetNuke.Services.Localization.Localization.GetString("lbRangeTab", ressFilePath);    
            grdProperty.Columns["ValMin"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValMin", ressFilePath);
            grdProperty.Columns["ValMax"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValMax", ressFilePath);
            grdProperty.Columns["DesignationGrp"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            grdProperty.Columns["GroupId"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            grdProperty.Columns["ID_Properties"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdProperty.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdProperty.Columns["ID_UniteMeasure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);
            grdProperty.Columns["IsOptional"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hType", ressFilePath);
            grdProperty.SettingsText.Title = DotNetNuke.Services.Localization.Localization.GetString("lbRangeTabHeader", ressFilePath);
            hlAddRange.Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);


            //translate grdPropertyStep
            TranslateUtility.localizeGrid(grdPropertyStep, ressFilePath);
            grdPropertyStep.SettingsText.PopupEditFormCaption = DotNetNuke.Services.Localization.Localization.GetString("lbStepTab", ressFilePath);    
            grdPropertyStep.Columns["ValueSet"].Caption = DotNetNuke.Services.Localization.Localization.GetString("ValueSet", ressFilePath);
            grdPropertyStep.Columns["DesignationGrp"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            grdPropertyStep.Columns["GroupId"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            grdPropertyStep.Columns["ID_Properties"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdPropertyStep.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdPropertyStep.Columns["ID_UniteMeasure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);
            grdPropertyStep.Columns["IsOptional"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hType", ressFilePath);
            grdPropertyStep.SettingsText.Title = DotNetNuke.Services.Localization.Localization.GetString("lbRangeTabHeader", ressFilePath);
            hlAddStep.Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewStep", ressFilePath);

            //translate grdPropertyMatrix

            grdMatProperty.SettingsText.Title = DotNetNuke.Services.Localization.Localization.GetString("lbMatrixTabHeader", ressFilePath);
            TranslateUtility.localizeGrid(grdMatProperty, ressFilePath);
            grdMatProperty.Columns["ValMin"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValMin", ressFilePath);
            grdMatProperty.Columns["ValMax"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValMax", ressFilePath);
            grdMatProperty.Columns["DesignationGrp"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            grdMatProperty.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdMatProperty.Columns["Measure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);
            grdMatProperty.Columns["IsOptional"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hType", ressFilePath);
            hlDefPropRef.Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);

            //Translate menu
            mnuGrdRange.Items.FindByName("addRange").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);
            mnuGrdRange.Items.FindByName("editRange").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuGrdRange.Items.FindByName("deleteRange").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            mnuGrdStep.Items.FindByName("addStep").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewStep", ressFilePath);
            mnuGrdStep.Items.FindByName("editStep").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuGrdStep.Items.FindByName("deleteStep").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            mnuGrdMX.Items.FindByName("addMX").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);
            mnuGrdMX.Items.FindByName("editMX").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuGrdMX.Items.FindByName("deleteMX").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            mnuGrdMXDepend.Items.FindByName("addMXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);
            mnuGrdMXDepend.Items.FindByName("editMXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuGrdMXDepend.Items.FindByName("deleteMXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);


            //Translate menu
            mnuMain.Items.FindByName("rangeGrp").Text = DotNetNuke.Services.Localization.Localization.GetString("lbRangeTab", ressFilePath);
            mnuMain.Items.FindByName("rangeGrp").Items.FindByName("addRange").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);
            mnuMain.Items.FindByName("rangeGrp").Items.FindByName("editRange").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuMain.Items.FindByName("rangeGrp").Items.FindByName("deleteRange").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            mnuMain.Items.FindByName("stepGrp").Text = DotNetNuke.Services.Localization.Localization.GetString("lbStepTab", ressFilePath);
            mnuMain.Items.FindByName("stepGrp").Items.FindByName("addStep").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewStep", ressFilePath);
            mnuMain.Items.FindByName("stepGrp").Items.FindByName("editStep").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuMain.Items.FindByName("stepGrp").Items.FindByName("deleteStep").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            mnuMain.Items.FindByName("MX").Text = DotNetNuke.Services.Localization.Localization.GetString("lbPropFct", ressFilePath);
            mnuMain.Items.FindByName("MX").Items.FindByName("addMX").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);
            mnuMain.Items.FindByName("MX").Items.FindByName("editMX").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuMain.Items.FindByName("MX").Items.FindByName("deleteMX").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);

            mnuMain.Items.FindByName("MX").Items.FindByName("MXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("lbTabDepend", ressFilePath);
            mnuMain.Items.FindByName("MX").Items.FindByName("MXDepend").Items.FindByName("addMXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath);
            mnuMain.Items.FindByName("MX").Items.FindByName("MXDepend").Items.FindByName("editMXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnuMain.Items.FindByName("MX").Items.FindByName("MXDepend").Items.FindByName("deleteMXDepend").Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);
        }

         

         
        protected void cmbCase_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            Session["IDNorme"] = e.Parameter;
            cmbCase.DataBind();
        }
        

        
        protected void grdProperty_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName != "IsOptional")
            {
                return;
            }

            if (bool.Parse(e.GetFieldValue("IsOptional").ToString()))
            {
                e.DisplayText = DotNetNuke.Services.Localization.Localization.GetString("lbRequirementType2", ressFilePath);
            }
            else
            {
                e.DisplayText = DotNetNuke.Services.Localization.Localization.GetString("lbRequirementType1", ressFilePath);
            }
        }
 
        protected void grdProperty_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            Session["IDNC"] = e.Parameters;
            grdProperty.DataBind();
            grdProperty.ExpandAll();
        }

       
        protected void grdProperty_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int ID = int.Parse(grdProperty.GetRowValues(grdProperty.FocusedRowIndex,"ID").ToString());
            StandardController.DeletePropertyRequirement(ID);
            e.Cancel = true;
        }

         
        protected void grdProperty_CustomErrorText(object sender, ASPxGridViewCustomErrorTextEventArgs e)
        {
            if (e.Exception is NullReferenceException)
            {
                e.ErrorText = DotNetNuke.Services.Localization.Localization.GetString("NullCustomErr", ressFilePath); 
            }
            else if (e.Exception is InvalidOperationException)
            {
                e.ErrorText = DotNetNuke.Services.Localization.Localization.GetString("InvalidOpErr", ressFilePath); 
            }
        }
 
        private void FillProperty(ASPxComboBox combo, int idPropertyGrp)
        {
            List<DataLayer.Materials_GetPropertiesByGroupResult> Properties = GetProperties(idPropertyGrp);
            combo.Items.Clear();
            
            foreach (var  property in Properties)
                
                combo.Items.Add(property.Designation, property.ID);
        }

         
        List<DataLayer.Materials_GetPropertiesByGroupResult> GetProperties(int idPropertyGrp)
        {
            return PropertyController.GetPropertiesByGroup(idPropertyGrp, Session["Locale"].ToString());
        }

        
        void ID_Properties_OnCallback(object source, CallbackEventArgsBase e)
        {
            FillProperty(source as ASPxComboBox, int.Parse(e.Parameter.ToString()));
        }

      

        
            protected void grdPropertyStep_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
            {
                Session["IDNC"] = e.Parameters;
                grdPropertyStep.DataBind();
                grdPropertyStep.ExpandAll();
            }

             
            protected void grdPropertyStep_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
            {
                if (e.Column.FieldName != "IsOptional")
                {
                    return;
                }

                if (bool.Parse(e.GetFieldValue("IsOptional").ToString()))
                {
                    e.DisplayText = DotNetNuke.Services.Localization.Localization.GetString("lbRequirementType2", ressFilePath);
                }
                else
                {
                    e.DisplayText = DotNetNuke.Services.Localization.Localization.GetString("lbRequirementType1", ressFilePath);
                }
            }

           
            protected void grdPropertyStep_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
            {
                int ID = int.Parse(grdPropertyStep.GetRowValues(grdPropertyStep.FocusedRowIndex, "ID").ToString());
                StandardController.DeletePropertyRequirement(ID);
                e.Cancel = true;
            }
 
           
        
            protected void grdMatProperty_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
            {
                Session["IDNC"] = e.Parameters;
                grdMatProperty.DataBind();
                grdMatProperty.ExpandRow(0);
            }

            
            protected void grdPropDetail_BeforePerformDataSelect(object sender, EventArgs e)
            {
                Session["IDNCP"] = (sender as ASPxGridView).GetMasterRowKeyValue();
                (sender as ASPxGridView).JSProperties["cpMasterRowKeyValue"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            }

             
            protected void grdMatProperty_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
            {
                if (e.Column.FieldName != "IsOptional")
                {
                    return;
                }

                if (bool.Parse(e.GetFieldValue("IsOptional").ToString()))
                {
                    e.DisplayText = DotNetNuke.Services.Localization.Localization.GetString("lbRequirementType2", ressFilePath);
                }
                else
                {
                    e.DisplayText = DotNetNuke.Services.Localization.Localization.GetString("lbRequirementType1", ressFilePath);
                }
            }

             
            protected void grdPropDetail_Load(object sender, EventArgs e)
            {
                ASPxGridView grdDetails = (ASPxGridView)sender;
                TranslateUtility.localizeGrid(grdDetails, ressFilePath);
                grdDetails.Columns["ValMin"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValMin", ressFilePath);
                grdDetails.Columns["ValMax"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValMax", ressFilePath);
                grdDetails.Columns["DesignationGrp"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
                grdDetails.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
                grdDetails.Columns["Measure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);
            }

             
            protected void grdMatProperty_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
            {
                int id = int.Parse(grdMatProperty.GetRowValues(grdMatProperty.FocusedRowIndex, "ID").ToString());
                StandardController.DeletePropertyRequirement(id);
                e.Cancel = true;
            }

            
            protected void grdPropDetail_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
            {
                ASPxGridView grdPropDetail = (ASPxGridView)sender;
                int id = int.Parse(grdPropDetail.GetRowValues(grdPropDetail.FocusedRowIndex,"ID").ToString());
                StandardController.DeletePropertyMX(id);
                e.Cancel = true;
            }

        

    }
}