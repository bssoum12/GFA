using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using GlobalAPI;
using VD.Modules.Framework;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Services.Localization;
using System.Collections;

namespace VD.Modules.Materials
{
    public partial class SearchUI : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        /// <summary>
        /// The ressource file path
        /// </summary>
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TranslateUtility.localizeGrid(grdMaterials, ressFilePath);
                TranslateUtility.localizeGrid(grdMaterialsFullText, ressFilePath);
                Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                Session["Discipline"] = "";
                Session["Famille"] = "";
                Session["Norme"] = "";
                Session["SearchText"] = "" ;
                Session["ParamDS"] = "pleintext";
                lblFilter1.Text = DotNetNuke.Services.Localization.Localization.GetString("mnFullTextSearch", ressFilePath);
                lblFilter2.Text = DotNetNuke.Services.Localization.Localization.GetString("mnSearchbyDiscipline", ressFilePath);
                lblFilter3.Text = DotNetNuke.Services.Localization.Localization.GetString("mnSearchBySupplier", ressFilePath);
                grdMaterials.SettingsText.Title = string.Format(DotNetNuke.Services.Localization.Localization.GetString("mnSearchTitle", ressFilePath), "---");
                grdMaterials.Columns["Code"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hCode", ressFilePath);
                grdMaterials.Columns["Nom"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hName", ressFilePath);
                grdMaterials.Columns["Description"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lbDescriptionTitle", ressFilePath);
                grdMaterials.Columns["Specification"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lblFamille", ressFilePath);
                grdMaterialsFullText.SettingsText.Title = string.Format(DotNetNuke.Services.Localization.Localization.GetString("mnSearchTitle", ressFilePath), "---");
                grdMaterialsFullText.Columns["Code"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hCode", ressFilePath);
                grdMaterialsFullText.Columns["Nom"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hName", ressFilePath);
                grdMaterialsFullText.Columns["Description"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lbDescriptionTitle", ressFilePath);
                grdMaterialsFullText.Columns["Specification"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lblFamille", ressFilePath);
                //"Liste des articles <br />Résultat de recherche selon les critères suivants : ---";
                //List of materials <br /> Result based on the following criteria: ---
                btnClearFilter2.Image.AlternateText = GlobalAPI.CommunUtility.getRessourceEntry("mnClearFields", ressFilePath );
                btnClearFilter2.Image.ToolTip = GlobalAPI.CommunUtility.getRessourceEntry("mnClearFields", ressFilePath );
                btnClearFilter1.Image.AlternateText = GlobalAPI.CommunUtility.getRessourceEntry("mnClearFields", ressFilePath );
                btnClearFilter1.Image.ToolTip = GlobalAPI.CommunUtility.getRessourceEntry("mnClearFields", ressFilePath);
                btnClearFilter3.Image.AlternateText = GlobalAPI.CommunUtility.getRessourceEntry("mnClearFields", ressFilePath);
                btnClearFilter3.Image.ToolTip = GlobalAPI.CommunUtility.getRessourceEntry("mnClearFields", ressFilePath);
                
                mnMaterialsActions.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDuplicate", ressFilePath);
                mnMaterialsActions.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
                mnMaterialsActions.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEitProperties", ressFilePath);
                mnMaterialsActions.Items[3].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDeleteMaterial", ressFilePath);
                mnMaterialsActions.Items[4].Text = DotNetNuke.Services.Localization.Localization.GetString("lbTechDetails", ressFilePath);
                mnMaterialsActions.Items[5].Text = DotNetNuke.Services.Localization.Localization.GetString("mnValidateMaterial", ressFilePath);
            }           
        }


        /// <summary>
        /// Handles the CustomCallback event of the treeList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void treeList_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            //ASPxComboBox cmbDiscipline = (ASPxComboBox)NavBarSearch.Groups.FindByName("grpSearchBySpec").FindControl("cmbDiscipline"); 
            ASPxTreeList treeList = sender as ASPxTreeList;
            if (e.Argument != "")
            {
                TreeListNode node = treeList.FindNodeByKeyValue(e.Argument);
                if (node != null)
                {
                    node.Focus();
                    node.MakeVisible();
                }
            }
            else
            {
                Session["ID_Discipline"] = cmbDiscipline.Value;
                treeList.DataBind();
            }
        }

         
        /// <summary>
        /// Handles the CustomJSProperties event of the treeList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomJSPropertiesEventArgs"/> instance containing the event data.</param>
        protected void treeList_CustomJSProperties(object sender, TreeListCustomJSPropertiesEventArgs e)
        {
            //ASPxDropDownEdit DropDownEdit = (ASPxDropDownEdit)NavBarSearch.Groups.FindByName("grpSearchBySpec").FindControl("DropDownEdit"); 
            ASPxTreeList tree = (ASPxTreeList)DropDownEdit.FindControl("treeList");
            object[] employeeNames = new object[tree.GetAllNodes().Count];
            object[] keyValues = new object[tree.GetAllNodes().Count];
            for (int i = 0; i < tree.GetAllNodes().Count; i++)
            {
                employeeNames[i] = tree.GetAllNodes().ElementAt(i).GetValue("Designation"); // grid.GetRowValues(i, "FirstName") + " " + grid.GetRowValues(i, "LastName");
                keyValues[i] = tree.GetAllNodes().ElementAt(i).Key;
            }
            e.Properties["cpEmployeeNames"] = employeeNames;
            e.Properties["cpKeyValues"] = keyValues;
        }

        /// <summary>
        /// Handles the CustomCallback event of the treeListNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void treeListNorm_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            //ASPxDropDownEdit DropDownEdit = (ASPxDropDownEdit)NavBarSearch.Groups.FindByName("grpSearchBySpec").FindControl("DropDownEdit"); 
            if (e.Argument != "ValueChanged") return;
            Session["SpecID"] = DropDownEdit.KeyValue;
            ASPxTreeList tree = sender as ASPxTreeList;
            tree.DataBind();
        }


        /// <summary>
        /// Handles the CustomJSProperties event of the treeListNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomJSPropertiesEventArgs"/> instance containing the event data.</param>
        protected void treeListNorm_CustomJSProperties(object sender, TreeListCustomJSPropertiesEventArgs e)
        {
            //ASPxDropDownEdit DropDownEditNorm = (ASPxDropDownEdit) NavBarSearch.Groups.FindByName("grpSearchBySpec").FindControl("DropDownEditNorm"); 
            ASPxTreeList tree = (ASPxTreeList)DropDownEditNorm.FindControl("treeListNorm");
            object[] NormNames = new object[tree.GetAllNodes().Count];
            object[] NormkeyValues = new object[tree.GetAllNodes().Count];
            for (int i = 0; i < tree.GetAllNodes().Count; i++)
            {
                NormNames[i] = tree.GetAllNodes().ElementAt(i).GetValue("Designation");
                NormkeyValues[i] = tree.GetAllNodes().ElementAt(i).Key;
            }
            e.Properties["cpNormNames"] = NormNames;
            e.Properties["cpNormKeyValues"] = NormkeyValues;
        }

   
        
        /// <summary>
        /// Handles the CustomCallback event of the grdMaterials control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdMaterials_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "pleintext")
            {
                
                Session["ParamDS"] = "pleintext"; 
                System.Web.UI.Control ctrl =  CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                    DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;
                    int PropertiesID = (cmbProperties.Value == null) ? -1 : Convert.ToInt32(cmbProperties.Value.ToString());                    
                    Session["PropertiesID"] = PropertiesID;
                    if (lbtokeninputvalue.Items.Count > 0)
                    {
                        if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                        {
                            string searchtext = lbtokeninputvalue.Items[0].Value.ToString();
                            Session["SearchText"] = searchtext; //.Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();                                                    
                            grdMaterials.DataBind();
                        }
                    }
               grdMaterials.SettingsText.Title = string.Format(DotNetNuke.Services.Localization.Localization.GetString("mnSearchTitle", ressFilePath), Session["SearchText"].ToString());
            }
            else if (e.Parameters == "spec")
            {
                Session["ParamDS"] = "spec";
                Session["Discipline"] = cmbDiscipline.Text;
                Session["Famille"] = DropDownEdit.Text;
                Session["Norme"] = DropDownEditNorm.Text;
                string[] param = new string[] { (Session["Discipline"].ToString() == "") ? "---" : Session["Discipline"].ToString()
                    , (Session["Famille"].ToString() == "" )? "---" : Session["Famille"].ToString() 
                    , (Session["Norme"].ToString() == "") ? "---" : Session["Norme"].ToString() };
                grdMaterials.DataBind();
                grdMaterials.SettingsText.Title = string.Format(DotNetNuke.Services.Localization.Localization.GetString("mnSearchTitle_DisciplineNorm", ressFilePath), param);
            }
            else
            {
                if (e.Parameters == "supp")
                {
                    Session["ParamDS"] = "supp";
                    string[] param = new string[] { (cmbSuppliers.Text == "") ? "---" : cmbSuppliers.Text
                    , (cmbBrands.Text == "") ? "---" : cmbBrands.Text};
                    grdMaterials.DataBind();
                    grdMaterials.SettingsText.Title = string.Format(DotNetNuke.Services.Localization.Localization.GetString("mnSearchTitle_SupplierBrand", ressFilePath), param);
                }
                else
                {
                    Session["Discipline"] = "";
                    Session["Famille"] = "";
                    Session["Norme"] = "";
                    Session["SearchText"] = "";
                    Session["ParamDS"] = "";
                    grdMaterials.DataBind();
                }
            }
        }

        /// <summary>
        /// Handles the Selecting event of the LinqSearchFullTextDS control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs"/> instance containing the event data.</param>
        protected void LinqSearchFullTextDS_Selecting(object sender, DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs e)
        {
            if (Session["ParamDS"].ToString() == "spec")
            {
                string specId = "";
                if (DropDownEdit.Text != "")
                {
                    ASPxTreeList specTree = ((ASPxTreeList)DropDownEdit.FindControl("treeList"));
                    specId = specTree != null ? specTree.FocusedNode != null ? specTree.FocusedNode.Key : "" : "";
                }
                string normId = "";
                if (DropDownEditNorm.Text != "")
                {
                    ASPxTreeList normTree = ((ASPxTreeList)DropDownEditNorm.FindControl("treeListNorm"));
                    normId = normTree != null ? normTree.FocusedNode != null ? normTree.FocusedNode.Key : "" : "";
                }
                e.QueryableSource = MaterialsController.SearchMaterialsByDisciplineSpecNorm(cmbDiscipline.Value == null ? "" : cmbDiscipline.Value.ToString(), specId, normId);
            }
            else
            {
                if (Session["ParamDS"].ToString() == "supp")
                {
                    e.QueryableSource = MaterialsController.SearchMaterialsBySuppliersAndBrands(
                        (cmbSuppliers.SelectedItem == null) ? null : (int?)Convert.ToInt32(cmbSuppliers.Value.ToString()),
                        (cmbBrands.SelectedItem == null) ? null : (int?)Convert.ToInt32(cmbBrands.Value.ToString()));
                }
                else
                {
                    e.QueryableSource = MaterialsController.SearchMaterialsByDisciplineSpecNorm("","","");

                    //Updated to remove full search scenario  from linq datasource
                    /*if (Session["SearchText"] == null)
                    {
                        e.QueryableSource = MaterialsUtility.SearchMaterialsFullText("", -1, 0, 0);
                    }
                    else
                    {
                        if (Session["SearchText"].ToString() == "")
                        {
                            e.QueryableSource = MaterialsUtility.SearchMaterialsFullText("", -1, 0, 0);
                        }
                        else
                        {
                            ASPxTextBox txtInitValue = txtValeurInit;
                            ASPxTextBox txtEndValue = txtValeurEnd;
                            double ValueInit= double.MinValue;
                            double ValueMax = double.MaxValue;
                            double.TryParse(txtInitValue.Text, out ValueInit);
                            double.TryParse(txtEndValue.Text, out ValueMax);
                            int PropertiesID = (Session["PropertiesID"] == null) ? -1 : Convert.ToInt32(Session["PropertiesID"].ToString());
                            e.KeyExpression = "ID";
                            e.QueryableSource = MaterialsUtility.SearchMaterialsFullText(Session["SearchText"].ToString(), PropertiesID, ValueInit, ValueMax);
                        }
                    }*/
                }
            }                
        }

        /// <summary>
        /// Handles the Click event of the btnPdfExport control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnPdfExport_Click(object sender, EventArgs e)
        {
            gridExport.WritePdfToResponse("M" + DateTime.Now.ToString("yyyyMMddHHmm"));
        }

        /// <summary>
        /// Handles the Click event of the btnXlsExport control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnXlsExport_Click(object sender, EventArgs e)
        {
            gridExport.WriteXlsToResponse("M" + DateTime.Now.ToString("yyyyMMddHHmm"));
        }

        /// <summary>
        /// Handles the CustomCallback event of the grdMaterialsFullText control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        /// <history>
        /// 	<para>[Anis Zouari]	18/09/2015  Created</para>
        /// </history>
        protected void grdMaterialsFullText_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "pleintext")
            {
                Session["ParamDS"] = "pleintext";
                System.Web.UI.Control ctrl = CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;
                int PropertiesID = (cmbProperties.Value == null) ? -1 : Convert.ToInt32(cmbProperties.Value.ToString());
                Session["PropertiesID"] = PropertiesID;
                if (lbtokeninputvalue.Items.Count > 0)
                {
                    if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                    {
                        string searchtext = lbtokeninputvalue.Items[0].Value.ToString();
                        Session["SearchText"] = searchtext; //.Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();                                                    
                        grdMaterialsFullText.DataBind();
                    }
                }
                grdMaterialsFullText.SettingsText.Title = string.Format(DotNetNuke.Services.Localization.Localization.GetString("mnSearchTitle", ressFilePath), Session["SearchText"].ToString());
            }
            else
            {
                Session["PropertiesID"] = "-1";
                Session["SearchText"] = "";
                grdMaterialsFullText.DataBind();
            }
        }

        /// <summary>
        /// Handles the Selecting event of the SqlSearchMaterialsDS control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="SqlDataSourceSelectingEventArgs"/> instance containing the event data.</param>
        protected void SqlSearchMaterialsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 300;
        }
    }
}