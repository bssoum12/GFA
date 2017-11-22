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
using GlobalAPI;
using VD.Modules.Framework;

namespace VD.Modules.Materials
{
    public partial class AssignSupplierToSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        static int specID;
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        //protected string ressFilePathContactMgr = "~/DesktopModules/EIF.ContactsManager/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Request.QueryString["specid"] != null)
                {
                     
                        if (Request.QueryString["specid"] !=  null )
                            specID = int.Parse(Request.QueryString["specid"].ToString() );
                     
                }
                //ddeSupplier.Text = DotNetNuke.Services.Localization.Localization.GetString("Fournisseur", ressFilePathContactMgr);
                grdSupplier.ExpandAll();
                try
                {
                    //Recuperer les spec affectée en cours
                    IQueryable<DataLayer.Materials_Supplier_MaterialsSpecifications> listSpecSupplier = SpecificationController.getSpecSupplierbySpec(specID);
                    //Sélectionner les noeuds dans la treeList
                    foreach (DataLayer.Materials_Supplier_MaterialsSpecifications item in listSpecSupplier)
                    {
                        grdSupplier.Selection.SelectRowByKey(item.IDContact);
                    }
                }
                catch (Exception)
                {

                }
              //  lblSupplierUI.ClientVisible = true;
              //  ddeSupplier.ClientVisible = true;
                grdSupplier.ClientVisible = true;
                btnApply.ClientVisible = true;
                // Get the spec row by specID
                List<DataLayer.Materials_SelectMaterialsSpecificationByIDResult> spec = SpecificationController.GetMatSpecByID(specID);
                lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignSupplierToSpec", ressFilePath) + " " + spec[0].Designation;
            }
            TranslateUtility.localizeGrid(grdSupplier, ressFilePath);
           // lblSupplierUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSupplierUI", ressFilePath);
            grdSupplier.Columns["ContactName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hContactName", ressFilePath);
            grdSupplier.Columns["LibePays"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hLibePays", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            
        }

        public string setIcon(object icon)
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

        public string TranslateCategorie(object toTranslate)
        {
            if (toTranslate != null)
            {
                if (toTranslate != DBNull.Value)
                {
                    //Translate the native categories and descriptions 
                    return (string)toTranslate;
                    /*if (DotNetNuke.Services.Localization.Localization.GetString((string)toTranslate, ressFilePathContactMgr) == null)
                    {
                       
                    }
                    else
                    {
                        return DotNetNuke.Services.Localization.Localization.GetString((string)toTranslate, ressFilePathContactMgr);
                    }*/
                }
            }
            return "";
        }

        protected void grdSupplier_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[0] == "refresh")
            {
                Session["TypeContactID"] = e.Parameters.Split(new string[] { ";" }, StringSplitOptions.None)[1];
                grdSupplier.DataBind();
                grdSupplier.ExpandAll();
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            SpecificationController.deleteMaterialsSpecificationSupplierBySpec(specID);
            try
            {
                foreach (var supplier in grdSupplier.GetSelectedFieldValues("ContactID"))
                {
                    int idSupplier = int.Parse(supplier.ToString());
                    string result = SpecificationController.AssignMatSpecToSupplier(idSupplier, specID, Utili.UserID);
                 //   lblSupplierUI.ClientVisible = false;
                  //  ddeSupplier.ClientVisible = false;
                    grdSupplier.ClientVisible = false;
                    btnApply.ClientVisible = false;
                    btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
                    if (result != "ok")
                    {
                        GlobalAPI.CommunUtility.logEvent("Error assign supplier to spec: " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles );

                        //Si aucune discipline n'est selectionnée avertir l'utilisateur et annuler l'action
                        lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath);
                    }
                    else
                    {
                        //Avertir l'utilisateur si succes
                        lblSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SSuccess", ressFilePath);
                    }
                }
            }
            catch (Exception)
            {
                return;
            }
               
        }
    }
}