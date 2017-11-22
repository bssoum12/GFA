using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;
using DotNetNuke.Entities.Users;
using GlobalAPI;
using VD.Modules.Framework;

namespace VD.Modules.Materials
{
    public partial class AssignPropertiesToSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        //Declaration variables
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected string ressFilePathContactMgr = "~/DesktopModules/gTiers/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string _portalAlias = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            //grdProperties.DataBind();
            //ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            //tlSpec.DataBind();
            if (!IsPostBack)
            {
                Session["lang"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                Session["Id_Discipline"] = null;
                //grdProperties.ExpandAll();
                tlSpec.ExpandAll();
            }
            //tlProtertiesGrp.DataBind();
            //if (tlProtertiesGrp.FocusedNode != null)
            //{
            //    Session["GroupId"] = tlProtertiesGrp.FocusedNode.Key; 
            //}
            
            //Traduction UI
            TranslateUtility.localizeGrid(grdProperties, ressFilePath);
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnCloseWin.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            pupAssignSpecToProperties.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("lbPupSpecPropHeader", ressFilePath);
            lblDisciplineUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDisciplineUI", ressFilePath);
            tlSpec.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            grdProperties.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdProperties.Columns["GroupDesignation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            //tlProtertiesGrp.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath);
            lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSpecUI", ressFilePath);
            sqlGetPropertiesGroup.SelectParameters[1].DefaultValue = DotNetNuke.Services.Localization.Localization.GetString("lbNoPropertyGrp", ressFilePath);
        }

        protected void grdProperties_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "refreshSelection")
            {
                // Désélectionner tous les noeuds
                grdProperties.Selection.UnselectAll();
                try
                {
                    //Recuperer les spec affectée en cours
                    List<DataLayer.Materials_Specification_Properties> listSpecProperties = SpecificationController.getSpecPropertiesBySpec(int.Parse(e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[1]));
                    //Sélectionner les noeuds dans la treeList
                    foreach (DataLayer.Materials_Specification_Properties item in listSpecProperties)
                    {
                        grdProperties.Selection.SelectRowByKey(item.Id_Properties);
                    }
                }
                catch (Exception)
                {

                }
            }
            else if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "Init")
            {
                // Désélectionner tous les noeuds
                 grdProperties.Selection.UnselectAll();
                 ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
                 try
                 {
                     tlSpec.UnselectAll();
                 }
                 catch (Exception)
                 {

                 }
            }
            else
            {
                Session["GroupId"] = e.Parameters;
                grdProperties.DataBind();
            }
        }

        protected void tlSpec_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            if (e.Argument.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "FilterTree")
            {
                tlSpec.UnselectAll();
                tlSpec.FindNodeByKeyValue(e.Argument.Split(new string[] { ";" }, StringSplitOptions.None)[1]).Selected = true;
                tlSpec.FindNodeByKeyValue(e.Argument.Split(new string[] { ";" }, StringSplitOptions.None)[1]).Focus();
            }
            else
            {
                Session["Id_Discipline"] = e.Argument;
                tlSpec.DataBind();
                tlSpec.ExpandAll();
            }
        }

        protected void callback_AssignSpecToProperties_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            if (cmbDiscipline.Value == null)
            {
                //Si aucune discipline n'est selectionnée avertir l'utilisateur et annuler l'action
                hfAlertMsg.Set("lblAlertMsg", DotNetNuke.Services.Localization.Localization.GetString("lbCmbDisciplineErr", ressFilePath));
                return;
            }
            else
            {
                SpecificationController.deleteMaterialsSpecificationPropertiesBySpec(int.Parse(e.Parameter));
                try
                {
                    foreach (var property in grdProperties.GetSelectedFieldValues("ID"))
                    {
                        int idProperty = int.Parse(property.ToString());
                        SpecificationController.setSpecProperties(int.Parse(e.Parameter), idProperty, Utili.UserID);
                    }
                }
                catch (Exception)
                {
                    //Si aucune discipline n'est selectionnée avertir l'utilisateur et annuler l'action
                    hfAlertMsg.Set("lblAlertMsg", DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath));
                    return;
                }

                //Avertir l'utilisateur si succes
                hfAlertMsg.Set("lblAlertMsg", DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SSuccess", ressFilePath));
            }
        }

        protected void cmbDiscipline_DataBound(object sender, EventArgs e)
        {
            cmbDiscipline.Items.Add(DotNetNuke.Services.Localization.Localization.GetString("all", ressFilePath), "all").Index = 0;
            cmbDiscipline.SelectedIndex = 0;
        }

        protected void tlSpec_DataBound(object sender, EventArgs e)
        {
            ASPxTreeList tlSpec = (ASPxTreeList)sender;
            DisableParentNodeSelection(tlSpec);
            if (!IsPostBack)
            {
                string specId;
                if (Request.QueryString["specid"] != null)
                {
                    try
                    {
                        //Get id spec from url
                        specId = Request.QueryString["specid"];
                        DevExpress.Web.ASPxTreeList.TreeListNode node = tlSpec.FindNodeByKeyValue(specId);
                        TreeListNodeIterator ListNode = tlSpec.CreateNodeIterator(node);
                        while (ListNode.Current != null)
                        {
                            if (ListNode.Current.Key == specId)
                            {
                                ListNode.Current.Selected = true;
                                ListNode.Current.Focus();
                                ddeSpec.Text = ListNode.Current.GetValue("Designation").ToString();
                            }
                            ListNode.GetNext();
                        }
                    }
                    catch
                    {

                    }
                }
            }
        }

        protected void DisableParentNodeSelection(ASPxTreeList tree)
        {
            // Iterates through all nodes and prevents the display of selection check boxes within parent nodes
            TreeListNodeIterator iterator = tree.CreateNodeIterator();
            TreeListNode node = iterator.GetNext();
            while (node != null)
            {
                node.AllowSelect = !node.HasChildren;
                node = iterator.GetNext();
            }
        }

        protected void grdProperties_DataBound(object sender, EventArgs e)
        {
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            if (!IsPostBack)
            {
                string specId;
                if (Request.QueryString["specid"] != null)
                {
                    specId = Request.QueryString["specid"];
                    // Désélectionner tous les noeuds
                    grdProperties.Selection.UnselectAll();
                    try
                    {
                        //Recuperer les spec affectée en cours
                        List<DataLayer.Materials_Specification_Properties> listSpecProperties = SpecificationController.getSpecPropertiesBySpec(int.Parse(specId));
                        //Sélectionner les noeuds dans la treeList
                        foreach (DataLayer.Materials_Specification_Properties item in listSpecProperties)
                        {
                            grdProperties.Selection.SelectRowByKey(item.Id_Properties);
                        }
                    }
                    catch (Exception)
                    {

                    }
                }
            }
        }

        //protected void tlProtertiesGrp_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        //{
        //    tlProtertiesGrp.DataBind();
        //}
    }
}