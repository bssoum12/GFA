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
    public partial class AssignSpecToSupplier : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        //Declaration variables
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        //protected string ressFilePathContactMgr = "~/DesktopModules/EIF.ContactsManager/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string _portalAlias = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            grdSupplier.DataBind();
            ASPxTreeList tlSpec = (ASPxTreeList)ddeSpec.FindControl("tlSpec");
            tlSpec.DataBind();
            if (! IsPostBack )
            {
                Session["lang"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                Session["Id_Discipline"] = null;
               // ddeSupplier.Text = DotNetNuke.Services.Localization.Localization.GetString("hSupplier", ressFilePath);
                grdSupplier.ExpandAll();
                tlSpec.ExpandAll();
            }
            //Traduction UI
            TranslateUtility.localizeGrid(grdSupplier, ressFilePath);
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnCloseWin.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            pupAssignSpecToSupplier.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("lbPupS2SHeader", ressFilePath);
            lblDisciplineUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDisciplineUI", ressFilePath);
          //  lblSupplierUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSupplierUI", ressFilePath);
            tlSpec.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            grdSupplier.Columns["ContactName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hContactName", ressFilePath);
            grdSupplier.Columns["LibePays"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hLibePays", ressFilePath);
            lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSpecUI", ressFilePath); 
        }

        public string setIcon(object icon) {
            try
            {
                if (icon == null)
                {
                    return "~/images/category.gif";
                }
                else
                {
                    return (string)icon;
                }
            }
            catch (Exception)
            {
                return "~/images/category.gif";
            }
        }

         

        protected void grdSupplier_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0]== "refresh")
            {
                Session["TypeContactID"] = e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[1];
                grdSupplier.DataBind();
                grdSupplier.ExpandAll();
            }
            else if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "refreshSelection")
            {
                // Désélectionner tous les noeuds
                grdSupplier.Selection.UnselectAll();
                try
                {
                    //Recuperer les spec affectée en cours
                    IQueryable<DataLayer.Materials_Supplier_MaterialsSpecifications> listSpecSupplier = SpecificationController.getSpecSupplierbySpec(int.Parse(e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[1]));
                    //Sélectionner les noeuds dans la treeList
                    foreach (DataLayer.Materials_Supplier_MaterialsSpecifications item in listSpecSupplier)
                    {
                        grdSupplier.Selection.SelectRowByKey(item.IDContact);
                    }
                }
                catch (Exception)
                {

                }
            }
            else if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "Init")
            {
                // Désélectionner tous les noeuds
                grdSupplier.Selection.UnselectAll();
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
                // Désélectionner tous les noeuds
                tlSpec.UnselectAll();
                try
                {
                    //Recuperer les spec affectée en cours
                    IQueryable<DataLayer.Materials_Supplier_MaterialsSpecifications> listSpecSupplier = SpecificationController.getSpecSupplierbyDiscipline(e.Argument);
                    //Sélectionner les noeuds dans la treeList
                    foreach (DataLayer.Materials_Supplier_MaterialsSpecifications item in listSpecSupplier)
                    {
                        tlSpec.FindNodeByKeyValue(item.IDMatSpec.ToString()).Selected = true;
                    }
                }
                catch (Exception)
                {

                }
            }
        }

        protected void callback_AssignSpecToSupplier_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
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
                    SpecificationController.deleteMaterialsSpecificationSupplierBySpec(int.Parse(e.Parameter));
                    try
                    {
                        foreach (var supplier in grdSupplier.GetSelectedFieldValues("ContactID"))
                        {
                            int idSupplier = int.Parse(supplier.ToString());
                            string result = SpecificationController.AssignMatSpecToSupplier(idSupplier,int.Parse(e.Parameter) , Utili.UserID);
                            if (result != "ok")
                            {
                                GlobalAPI.CommunUtility.logEvent("Error assign supplier to spec: " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles );
                            }
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

    }
}