using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class AssignNormToSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        //Declaration variables
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
      //  protected string ressFilePathContactMgr = "~/DesktopModules/GestionTiers/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string _portalAlias = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            grdNormes.DataBind();
            tlSpec.DataBind();
            if (!IsPostBack)
            {
                Session["lang"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                Session["Id_Discipline"] = null;
                grdNormes.ExpandAll();
                tlSpec.ExpandAll();
            }
            //Traduction UI
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            pupAssignSpecToNormes.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("lbPupSpecNormesHeader", ressFilePath);
            lblDisciplineUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDisciplineUI", ressFilePath);
            tlSpec.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            grdNormes.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hDesignationNormes", ressFilePath);
            lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSpecUI", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnCloseWin.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            TranslateUtility.localizeGrid(grdNormes , ressFilePath );
        }

        protected void grdNormes_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "refreshSelection")
            {
                // Désélectionner tous les noeuds
                grdNormes.Selection.UnselectAll();
                try
                {
                    //Recuperer les spec affectée en cours
                    List<DataLayer.Materials_MaterialsSpecifications_Norm> listSpecNormes = StandardController.getSpecNormesBySpec(int.Parse(e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[1]));
                    //Sélectionner les noeuds dans la treeList
                    foreach (DataLayer.Materials_MaterialsSpecifications_Norm item in listSpecNormes)
                    {
                        grdNormes.Selection.SelectRowByKey(item.ID_Norm);
                    }
                }
                catch (Exception)
                {

                }
            }
            else if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "Init")
            {
                // Désélectionner tous les noeuds
                grdNormes.Selection.UnselectAll();
                ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
                try
                {
                    tlSpec.UnselectAll();
                }
                catch (Exception)
                {
                    throw;
                }
            }
            else
            {
                grdNormes.DataBind();
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

        protected void callback_AssignSpecToNormes_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
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
                SpecificationController.deleteMaterialsSpecificationNormesBySpec(int.Parse(e.Parameter));
                try
                {
                    foreach (var norme in grdNormes.GetSelectedFieldValues("ID"))
                    {
                        int idNorme = int.Parse(norme.ToString());
                        StandardController.setSpecNormes(int.Parse(e.Parameter), idNorme, Utili.UserID);
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

        protected void grdNormes_DataBound(object sender, EventArgs e)
        {
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            if (!IsPostBack)
            {
                string specId;
                if (Request.QueryString["specid"] != null)
                {
                    specId = Request.QueryString["specid"];
                    // Désélectionner tous les noeuds
                    grdNormes.Selection.UnselectAll();
                    try
                    {
                        //Recuperer les spec affectée en cours
                        List<DataLayer.Materials_MaterialsSpecifications_Norm> listSpecNormes = StandardController.getSpecNormesBySpec(int.Parse(specId));
                        //Sélectionner les noeuds dans la treeList
                        foreach (DataLayer.Materials_MaterialsSpecifications_Norm item in listSpecNormes)
                        {
                            grdNormes.Selection.SelectRowByKey(item.ID_Norm);
                        }
                    }
                    catch (Exception)
                    {

                    }
                }
            }
        }

    }
}