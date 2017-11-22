using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Localization;
using VD.Modules.Framework;
using DataLayer;
using GlobalAPI;
using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;

namespace VD.Modules.Materials
{
    public partial class Param_StdPropertyRange : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
         
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();

         
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMaxVal.Text = DotNetNuke.Services.Localization.Localization.GetString("hValMax", ressFilePath);
            lblMinVal.Text = DotNetNuke.Services.Localization.Localization.GetString("hValMin", ressFilePath);
            lblProp.Text = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            lblPropGrp.Text = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            lblUnite.Text = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);
            cmdValiderPopup.Text = DotNetNuke.Services.Localization.Localization.GetString("lbClose", ressFilePath);
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            lblHelp.Text = DotNetNuke.Services.Localization.Localization.GetString("lblValValidation1", ressFilePath);
            cbIsOptional.Text = DotNetNuke.Services.Localization.Localization.GetString("lbIsOptional", ressFilePath);
            Session["IDNC"] = null;
            if (HttpContext.Current.Request.QueryString["IsEdit"] != null)
            {
                Session["IsEditMode"] = HttpContext.Current.Request.QueryString["IsEdit"].ToString();
                if (bool.Parse(HttpContext.Current.Request.QueryString["IsEdit"].ToString()))
                {
                    btnSubmit.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
                }
                else
                {
                    btnSubmit.Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
                }
            }
            if (HttpContext.Current.Request.QueryString["idnc"] != null)
            {
                Session["IDNC"] = HttpContext.Current.Request.QueryString["idnc"].ToString();
            }
            if (!IsPostBack)
            {
                if (HttpContext.Current.Request.QueryString["id"] != null)
                {
                    Session["id"] = HttpContext.Current.Request.QueryString["id"];
                    DataLayer.Materials_Norm_Cases_Properties property = StandardController.GetPropertyRequirement(int.Parse(Session["id"].ToString()));
                    if (property != null)
                    {
                        cbIsOptional.Checked = (bool)property.IsOptional;
                        Session["GroupId"] = property.Materials_Properties.GroupId;
                        cmbProp.DataBind();
                        if (cmbProp.Items.FindByValue(property.ID_Properties) != null)
                        {
                            cmbProp.Items.FindByValue(property.ID_Properties).Selected = true;
                        }
                        txtRefMaxVal.Text = property.ValMax;
                        txtRefMinVal.Text = property.ValMin;
                        Session["ID_Property"] = property.ID_Properties;
                        cmbUnite.DataBind();
                        if (cmbUnite.Items.FindByValue(property.ID_UniteMeasure) != null)
                        {
                            cmbUnite.Items.FindByValue(property.ID_UniteMeasure).Selected = true;
                        }
                    }
                }
                else
                {
                    Session["id"] = -1;
                }
            }
        }

         
        protected void cmbProp_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            try
            {
                Session["GroupId"] = e.Parameter;
                cmbProp.DataBind();
            }
            catch (Exception)
            { }
        }

         
        protected void cmbUnite_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            try
            {
                Session["ID_Property"] = e.Parameter;
                cmbUnite.DataBind();
            }
            catch (Exception)
            { }
        }

         
        
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            popupValidation.Text = "";
            //Formater la valeur minimale
            double minValue = double.NaN;
            if (txtRefMinVal.Text != "")
            {
                minValue = StandardController.CalculateValue(txtRefMinVal.Text);
            }

            //Formater la valeur maximale
            double maxValue = double.NaN;
            if (txtRefMaxVal.Text != "")
            {
                maxValue = StandardController.CalculateValue(txtRefMaxVal.Text);
            }

            //Evaluate minValue and maxValue
            if (!double.IsNaN(maxValue) && !double.IsNaN(minValue))
            {
                if (maxValue < minValue)
                {
                    //maxValue is inferior to minValue
                    popupValidation.Text = DotNetNuke.Services.Localization.Localization.GetString("InvalidOpErr", ressFilePath);
                    popupValidation.ShowOnPageLoad = true;
                    return;
                }
            }
            else if (!double.IsNaN(maxValue) && double.IsNaN(minValue))
            {
                //minValue is null
                minValue = maxValue;
            }
            else if (double.IsNaN(maxValue) && !double.IsNaN(minValue))
            {
                //maxValue is null
                maxValue = minValue;
            }
            else
            {
                //maxValue and minValue are null
                popupValidation.Text = DotNetNuke.Services.Localization.Localization.GetString("NullCustomErr", ressFilePath);
                popupValidation.ShowOnPageLoad = true;
                return;
            }

            //Set property requirement
            if (HttpContext.Current.Request.QueryString["IsEdit"] != null)
            {
                if (bool.Parse(HttpContext.Current.Request.QueryString["IsEdit"].ToString()))
                {
                    if (HttpContext.Current.Request.QueryString["id"] != null)
                    {
                        int id = int.Parse(HttpContext.Current.Request.QueryString["id"]);
                        if (StandardController.UpdatePropertyRange(id, (int)cmbProp.Value,
                            minValue.ToString(), maxValue.ToString(), (int)cmbUnite.Value, Utili.UserID, cbIsOptional.Checked))
                        {
                            popupValidation.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                        }
                        else
                        {
                            popupValidation.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath);
                        }
                    }
                }
                else
                {
                    if (HttpContext.Current.Request.QueryString["idnc"] != null)
                    {
                        int idnc = int.Parse(HttpContext.Current.Request.QueryString["idnc"]);
                        if (StandardController.SetNCPropertyRange(idnc, (int)cmbProp.Value,
                            maxValue.ToString(), minValue.ToString(), Utili.UserID, (int)cmbUnite.Value, cbIsOptional.Checked) != -1)
                        {
                            popupValidation.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath);
                        }
                        else
                        {
                            popupValidation.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                        }
                    }
                }
            }
            popupValidation.ShowOnPageLoad = true;
        }
 
        protected void tlProtertiesGrpMgr_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.QueryString["id"] != null)
            {
                Session["id"] = HttpContext.Current.Request.QueryString["id"];
                DataLayer.Materials_Norm_Cases_Properties propertyRef = StandardController.GetPropertyRef(Session["Locale"].ToString(),
                   int.Parse(Session["id"].ToString()));
                if (propertyRef != null)
                {
                    ASPxTreeList cmbGrpProp = sender as ASPxTreeList;
                    cmbGrpProp.DataBind();
                    if (cmbGrpProp.FindNodeByKeyValue(propertyRef.Materials_Properties.GroupId.ToString()) != null)
                    {
                        cmbGrpProp.FindNodeByKeyValue(propertyRef.Materials_Properties.GroupId.ToString()).Focus();
                    }

                    ddePropertyGrp.Text = cmbGrpProp.FindNodeByKeyValue(propertyRef.Materials_Properties.GroupId.ToString()).GetValue("Designation").ToString();
                    Session["GroupId"] = propertyRef.Materials_Properties.GroupId;
                    cmbProp.DataBind();
                    if (cmbProp.Items.FindByValue(propertyRef.ID_Properties) != null)
                    {
                        cmbProp.Items.FindByValue(propertyRef.ID_Properties).Selected = true;
                    }
                }
            }
        }

      
        protected void tlProtertiesGrpMgr_DataBound(object sender, EventArgs e)
        {
            ASPxTreeList tlProtertiesGrpMgr = (ASPxTreeList)sender;
            tlProtertiesGrpMgr.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
        }

    }
}
