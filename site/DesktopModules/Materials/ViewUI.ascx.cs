using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GlobalAPI;
using System.Drawing;
using System.Data.SqlClient;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;
using VD.Modules.Framework;

namespace VD.Modules.Materials
{
    public partial class ViewUI : DotNetNuke.Entities.Modules.PortalModuleBase 
    {
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected string _portalAlias = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            TranslateUtility.localizeGrid(grdMaterials, ressFilePath);
            grdMaterials.Columns["Code"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hCode", ressFilePath);
            grdMaterials.Columns["DisplayName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hCreator", ressFilePath);
            grdMaterials.Columns["CreatedOnDate"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hCreated", ressFilePath);
            grdMaterials.Columns["BrandDesignation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("mnBrand", ressFilePath);

            tlsSpec.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lbName", ressFilePath);
            
            grdMaterials.SettingsText.Title = DotNetNuke.Services.Localization.Localization.GetString("hMaterialsList", ressFilePath);
            lbSpec.Text = DotNetNuke.Services.Localization.Localization.GetString("hSpecifications", ressFilePath);
            
            lbDiscipline.Text = DotNetNuke.Services.Localization.Localization.GetString("hDisciplines", ressFilePath);
            imExpand2.AlternateText = DotNetNuke.Services.Localization.Localization.GetString("mnExpandTree", ressFilePath);
            imExpand2.Attributes.Add("title", DotNetNuke.Services.Localization.Localization.GetString("mnExpandTree", ressFilePath));
            imCollapse2.AlternateText = DotNetNuke.Services.Localization.Localization.GetString("mnCollapseTree", ressFilePath);
            imCollapse2.Attributes.Add("title", DotNetNuke.Services.Localization.Localization.GetString("mnCollapseTree", ressFilePath));
            ImageButton imgBtn = ((ImageButton)grdMaterials.FindTitleTemplateControl("imExpand2"));
         //   imgBtn.AlternateText = DotNetNuke.Services.Localization.Localization.GetString("mnExpandTree", ressFilePath);
           // imgBtn.Attributes.Add("title", DotNetNuke.Services.Localization.Localization.GetString("mnExpandTree", ressFilePath));
            mnMaterialsActions.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDuplicate", ressFilePath);
            mnMaterialsActions.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            mnMaterialsActions.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEitProperties", ressFilePath);
            mnMaterialsActions.Items[3].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDeleteMaterial", ressFilePath);
            mnMaterialsActions.Items[4].Text = DotNetNuke.Services.Localization.Localization.GetString("lbTechDetails", ressFilePath);
            mnMaterialsActions.Items[5].Text = DotNetNuke.Services.Localization.Localization.GetString("mnValidateMaterial", ressFilePath);

            TranslateUtility.localizeGrid(gvwSuppliers, ressFilePath);
            gvwSuppliers.SettingsText.Title = DotNetNuke.Services.Localization.Localization.GetString("hSuppliers", ressFilePath);
            gvwSuppliers.Columns["ContactName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("lbName", ressFilePath);
            
            mnSpecActions.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignToDiscipline", ressFilePath);
            mnSpecActions.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignToSupplier", ressFilePath);
            mnSpecActions.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignToNorms", ressFilePath);
            mnSpecActions.Items[3].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAssignProperties", ressFilePath);
            mnSpecActions.Items[4].Text = DotNetNuke.Services.Localization.Localization.GetString("addSpecGrp", ressFilePath);
            mnSpecActions.Items[5].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAddSpec", ressFilePath);
            mnSpecActions.Items[6].Text = DotNetNuke.Services.Localization.Localization.GetString("editSpec", ressFilePath);
            mnSpecActions.Items[7].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAddMaterial", ressFilePath);

            if (!IsPostBack)
            {
                Session["DisciplineID"] = null;
                Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;

                if (Request.QueryString["MaterialKey"] != null)
                {
                    var ret = MaterialsController.getMaterialByID(Int32.Parse(Request.QueryString["MaterialKey"].ToString()));
                    if (ret != null)
                    {
                        cmbDisciplines.SelectedIndex = 0;
                        Session["DisciplineID"] = "ALL";
                        tlsSpec.DataBind();
                        Session["FilterID"] = ret.ID_MaterialsSpecifications.ToString();
                        Session["FilterType"] = 0;
                        grdMaterials.DataBind();
                    }
                }
            }
        }


        /// <summary>
        /// Handles the BeforePerformDataSelect event of the gvwDetails control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void gvwDetails_BeforePerformDataSelect(object sender, EventArgs e)
        {
             Session["MaterialID"] = (sender as ASPxGridView).GetMasterRowKeyValue(); 
        }

        /// <summary>
        /// Handles the CustomCallback event of the tlsSpec control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxTreeList.TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void tlsSpec_CustomCallback(object sender, DevExpress.Web.ASPxTreeList.TreeListCustomCallbackEventArgs e)
        { 
            if (cmbDisciplines.SelectedItem != null)
            {
                Session["DisciplineID"] = cmbDisciplines.SelectedItem.Value;
                tlsSpec.DataBind();
                if (e.Argument != "")
                {
                    tlsSpec.JSProperties.Add("cpFilterBtnSpec", null);
                    tlsSpec.JSProperties["cpFilterBtnSpec"] = e.Argument;
                }
            } 
        }

        /// <summary>
        /// Handles the CustomCallback event of the grdMaterials control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdMaterials_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        { 
            if (e.Parameters != "")
            {
                var tabParam = e.Parameters.ToString().Split(new string[] { "##" }, StringSplitOptions.None);
                if (tabParam[1] != "")
                {
                    Session["FilterID"] = tabParam[1] == "null" ? "0" : tabParam[1];
                    Session["FilterType"] = tabParam[0];
                    grdMaterials.DataBind();
                }
                if (tabParam.Length >= 3)
                {
                    grdMaterials.JSProperties.Add("cpFilterBtnMaterial", null);
                    grdMaterials.JSProperties["cpFilterBtnMaterial"] = tabParam[2];
                }
            } 
        }

        /// <summary>
        /// Handles the DataBound event of the cmbDisciplines control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void cmbDisciplines_DataBound(object sender, EventArgs e)
        { 
            cmbDisciplines.Items.Add(DotNetNuke.Services.Localization.Localization.GetString("lbTous", ressFilePath), "ALL").Index = 0;
            cmbDisciplines.SelectedIndex = 0; 
        }

        /// <summary>
        /// Handles the Click event of the btnPdfExport control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnPdfExport_Click(object sender, EventArgs e)
        {
             gridExport.WritePdfToResponse(); 
        }

        /// <summary>
        /// Handles the Click event of the btnXlsExport control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnXlsExport_Click(object sender, EventArgs e)
        {
             gridExport.WriteXlsToResponse(); 
        }

        /// <summary>
        /// Handles the Selecting event of the SpecificationsDS control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="LinqDataSourceSelectEventArgs"/> instance containing the event data.</param>
        protected void SpecificationsDS_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        { 
            if (cmbDisciplines.SelectedItem != null)
                e.Result = SpecificationController.getMaterialsSpecification(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
         }

        /// <summary>
        /// Handles the Selecting event of the MaterialsPropertiesDS control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="LinqDataSourceSelectEventArgs"/> instance containing the event data.</param>
        protected void MaterialsPropertiesDS_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            if (Session["MaterialID"] != null)
                e.Result = MaterialsController.getMaterialPropertiesByID(Int32.Parse(Session["MaterialID"].ToString()), System.Threading.Thread.CurrentThread.CurrentCulture.Name);
        }

        /// <summary>
        /// Handles the Load event of the gvwDetails control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void gvwDetails_Load(object sender, EventArgs e)
        {
             
            ASPxGridView grdDetails = (ASPxGridView)(sender); //.FindDetailRowTemplateControl(e.VisibleIndex, "gvwDetails");
            grdDetails.Columns["Valeur"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValue", ressFilePath);
            grdDetails.Columns["UnitDesignation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hUnit", ressFilePath);
            grdDetails.Columns["PropertyDesignation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperty", ressFilePath);
            TranslateUtility.localizeGrid(grdDetails, ressFilePath); 
        }

        /// <summary>
        /// Handles the Click event of the btnFilter control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnFilter_Click(object sender, EventArgs e)
        { 
            try
            {
                System.Web.UI.Control ctrl = CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;

                if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                {
                    tlsSpec.CollapseAll();
                    string matID = lbtokeninputvalue.Items[0].Value.ToString().Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();
                    lbtokeninputvalue.Items.Clear();
                    var ret = MaterialsController.getMaterialByID(Int32.Parse(matID));
                    //cmbDisciplines.SelectedItem.Value = ret.EIFMaterials_MaterialsSpecification.EIFMaterials_MaterialsSpecifications_Disciplines..EIFMaterials_MaterialsSpecification..Designation;
                    cmbDisciplines.SelectedIndex = 0;
                    DevExpress.Web.ASPxTreeList.TreeListNode node = tlsSpec.FindNodeByKeyValue(ret.ID_MaterialsSpecifications.ToString());
                    while (node.ParentNode.Key != "")
                    {
                        node = node.ParentNode;
                    }
                    TreeListNodeIterator iterator = tlsSpec.CreateNodeIterator(node);
                    while (iterator.Current != null)
                    {
                        iterator.Current.Expanded = true;
                        iterator.Current.Focus();

                        if (iterator.Current.Key == ret.ID_MaterialsSpecifications.ToString())
                        {
                            Session["FilterID"] = ret.ID_MaterialsSpecifications.ToString();
                            Session["FilterType"] = 0;
                            grdMaterials.DataBind();
                            grdMaterials.FocusedRowIndex = grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                            grdMaterials.DetailRows.ExpandRow(grdMaterials.FindVisibleIndexByKeyValue(ret.ID));
                            return;
                        }
                        else
                        {
                            iterator.GetNext();
                        }
                    }
                }
            }
            catch (Exception)
            {

            } 
        }

        /// <summary>
        /// Handles the PreRender event of the gvwSuppliers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void gvwSuppliers_PreRender(object sender, EventArgs e)
        { 
            if (!IsPostBack)
                gvwSuppliers.FocusedRowIndex = -1; 
        }

        /// <summary>
        /// Handles the Callback event of the cbOperations control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.CallbackEventArgs"/> instance containing the event data.</param>
        protected void cbOperations_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        { 
            e.Result = "";
            try
            {
                //Filter materials by tokeninput field when specifications tree is selected
                if (e.Parameter == "searchFilter")
                {
                    System.Web.UI.Control ctrl = CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                    DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;

                    if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                    {
                        string matID = lbtokeninputvalue.Items[0].Value.ToString().Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();
                        lbtokeninputvalue.Items.Clear();
                        var ret = MaterialsController.getMaterialByID(Int32.Parse(matID));
                        e.Result = ret.ID_MaterialsSpecifications.ToString() + "@@" + ret.ID + "@@" + grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                    }
                }
                else
                {
                    //Filter materials by tokeninput field when supplier grid is selected
                    if (e.Parameter == "filter")
                    {

                        System.Web.UI.Control ctrl = CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                        DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;

                        if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                        {
                            string matID = lbtokeninputvalue.Items[0].Value.ToString().Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();
                            lbtokeninputvalue.Items.Clear();
                            var ret = MaterialsController.getMaterialByID(Int32.Parse(matID));
                            var retSuppliers = MaterialsController.getMaterialSuppliers(Int32.Parse(matID));
                            if (retSuppliers.Count > 0)
                                e.Result = retSuppliers.Count.ToString() + "@@" + ret.ID + "@@" + retSuppliers[0].IDContact.ToString() + "@@" + gvwSuppliers.FindVisibleIndexByKeyValue(retSuppliers[0].IDContact).ToString() + "@@" + grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                            else
                                e.Result = retSuppliers.Count.ToString() + "@@" + ret.ID + "@@" + grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                        }
                    }
                    //Filter materials grid when add or edit popup is closed
                    else if (e.Parameter.Split('#')[0] == "filterPop")
                    {
                        var matID = e.Parameter.Split('#')[1];
                        var ret = MaterialsController.getMaterialByID(Int32.Parse(matID));
                        var retSuppliers = MaterialsController.getMaterialSuppliers(Int32.Parse(matID));
                        if (retSuppliers.Count > 0)
                            e.Result = retSuppliers.Count.ToString() + "@@" + ret.ID + "@@" + retSuppliers[0].IDContact.ToString() + "@@" + gvwSuppliers.FindVisibleIndexByKeyValue(retSuppliers[0].IDContact).ToString() + "@@" + grdMaterials.FindVisibleIndexByKeyValue(ret.ID) + "@@" + ret.ID_MaterialsSpecifications.ToString();
                        else
                            e.Result = retSuppliers.Count.ToString() + "@@" + ret.ID + "@@-@@-@@" + grdMaterials.FindVisibleIndexByKeyValue(ret.ID) + "@@" + ret.ID_MaterialsSpecifications.ToString();
                    }
                    else
                    {
                        if (e.Parameter.Split('#')[0] == "filterURL")
                        {
                            var matID = e.Parameter.Split('#')[1];
                            var ret = MaterialsController.getMaterialByID(Int32.Parse(matID));
                            e.Result = ret.ID_MaterialsSpecifications.ToString() + "@@" + ret.ID + "@@" + grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                        }
                        else
                            e.Result = grdMaterials.FindVisibleIndexByKeyValue(e.Parameter.ToString()).ToString();
                    }
                }
            }
            catch (Exception)
            {

            } 
        }




        /// <summary>
        /// Handles the Callback event of the cbFilterSpec control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.CallbackEventArgs"/> instance containing the event data.</param>
        protected void cbFilterSpec_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
             
            try
            {
                e.Result = "";
                if (e.Parameter != "")
                {
                    string key = "-1";
                    TreeListNodeIterator iterator = tlsSpec.CreateNodeIterator(tlsSpec.RootNode);
                    while ((iterator.Current != null) && (key == "-1"))
                    {
                        key = CheckNode(iterator.Current, e.Parameter);
                        iterator.GetNext();
                    }
                    if (key != "")
                    {
                        if (Int32.Parse(key) >= 0)
                        {
                            e.Result = key;
                        }
                    }
                }
            }
            catch (Exception)
            { } 
        }

        /// <summary>
        /// Handles the Click event of the btnFilterBySupplier control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnFilterBySupplier_Click(object sender, EventArgs e)
        { 
            try
            {
                System.Web.UI.Control ctrl = CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;

                if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                {
                    tlsSpec.CollapseAll();
                    string matID = lbtokeninputvalue.Items[0].Value.ToString().Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();
                    lbtokeninputvalue.Items.Clear();
                    var ret = MaterialsController.getMaterialByID(Int32.Parse(matID));
                    var retSuppliers = MaterialsController.getMaterialSuppliers(Int32.Parse(matID));
                    if (retSuppliers.Count > 0)
                    {
                        gvwSuppliers.FocusedRowIndex = gvwSuppliers.FindVisibleIndexByKeyValue(retSuppliers[0].IDContact);
                        Session["FilterID"] = retSuppliers[0].IDContact;
                        Session["FilterType"] = 1;
                        grdMaterials.DataBind();
                        grdMaterials.FocusedRowIndex = grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                        grdMaterials.DetailRows.ExpandRow(grdMaterials.FindVisibleIndexByKeyValue(ret.ID));
                    }
                    else
                    {
                        gvwSuppliers.FocusedRowIndex = -1;
                        Session["FilterID"] = matID;
                        Session["FilterType"] = 2;
                        grdMaterials.DataBind();
                        grdMaterials.FocusedRowIndex = grdMaterials.FindVisibleIndexByKeyValue(ret.ID);
                        grdMaterials.DetailRows.ExpandRow(grdMaterials.FindVisibleIndexByKeyValue(ret.ID));
                    }
                }
                rdbtnSlider.SelectedIndex = 1;
            }
            catch (Exception)
            {

            }
        
             
        }

        /// <summary>
        /// Handles the Selecting event of the DisciplinesDS control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="SqlDataSourceSelectingEventArgs"/> instance containing the event data.</param>
        protected void DisciplinesDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters[0].Value = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
        }


        /// <summary>
        /// Handles the CustomColumnDisplayText event of the gvwDetails control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ASPxGridViewColumnDisplayTextEventArgs"/> instance containing the event data.</param>
        protected void gvwDetails_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            try
            {
                if (e.Column.FieldName == "Valeur")
                {
                    if (e.GetFieldValue("Format") != null)
                        e.DisplayText = string.Format(e.GetFieldValue("Format").ToString(), e.Value.ToString());
                }
            }
            catch (Exception)
            { }
        }

        /// <summary>
        /// Gets the cell text.
        /// </summary>
        /// <param name="container">The container.</param>
        /// <returns>Cell text as string</returns>
        protected string GetCellText(TreeListDataCellTemplateContainer container)
        {
            string serchText = "";
            string cell_text = container.Text;
            if (serchText.Length > cell_text.Length)
            {
                return cell_text;
            }
            if (serchText != "")
            {

                string cell_text_lower = cell_text.ToLower();
                string serchText_lower = serchText.ToLower();
                if (serchText != "")
                {
                    int start_pos = cell_text_lower.IndexOf(serchText_lower);
                    int span_length = ("<span class='highlight'>").Length;
                    if (start_pos >= 0)
                    {
                        cell_text = cell_text.Insert(start_pos, "<span class='highlight'>");
                        cell_text = cell_text.Insert(start_pos + span_length + serchText_lower.Length, "</span>");
                    }
                }
            }
            return cell_text;
        }

        /// <summary>
        /// Checks the node.
        /// </summary>
        /// <param name="node">The node.</param>
        /// <param name="data">The data.</param>
        /// <returns>Node key as string</returns>
        private string CheckNode(TreeListNode node, string data)
        {
            string keyNode = "-1";
            string s_text = data.ToLower();
            object node_value = node.GetValue("Designation");
            if (node_value == null)
                return keyNode;
            if (node_value.ToString().TrimEnd().ToLower().Equals(s_text.TrimEnd())) //.IndexOf(s_text) >= 0)
            {
                node.MakeVisible();
                node.Expanded = true;
                node.Focus();
                keyNode = node.Key;
            }
            return keyNode;
        }

        /// <summary>
        /// Handles the Callback event of the cmbFilterSpec control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="CallbackEventArgsBase"/> instance containing the event data.</param>
        protected void cmbFilterSpec_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
             
            ASPxComboBox cmbSpec = (ASPxComboBox)(tlsSpec.FindHeaderCaptionTemplateControl(tlsSpec.Columns["Designation"], "cmbFilterSpec"));
            cmbSpec.DataBind(); 
        }

        /// <summary>
        /// Handles the Load event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroups_Load(object sender, EventArgs e)
        {
            ASPxTreeList treeDetails = (ASPxTreeList)sender;
            Session["MaterialID"] = ((DevExpress.Web.GridViewDetailRowTemplateContainer)treeDetails.Parent).KeyValue;
            treeDetails.Columns["Valeur"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValue", ressFilePath);
            treeDetails.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hGroup", ressFilePath);
            treeDetails.Columns["PropertyDesignation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperty", ressFilePath);
            treeDetails.DataBind();
        }

        /// <summary>
        /// Handles the Selecting event of the PropertiesHiearchyDS control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="SqlDataSourceSelectingEventArgs"/> instance containing the event data.</param>
        protected void PropertiesHiearchyDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            SqlParameter a = new SqlParameter();
            a.ParameterName = "LocaleParam";
            a.Value = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            e.Command.Parameters.Add(a);
        }

        /// <summary>
        /// Handles the HtmlDataCellPrepared event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListHtmlDataCellEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroups_HtmlDataCellPrepared(object sender, TreeListHtmlDataCellEventArgs e)
        {
            //Fomat property value
            if (e.Column.FieldName == "Valeur")
            {
                try
                {
                    if (e.GetValue("Format") != null)
                    {
                        if (e.GetValue("Format").ToString() != "")
                            e.Cell.Text = string.Format(e.GetValue("Format").ToString(), e.CellValue.ToString());
                    }
                }
                catch (Exception)
                { }
            }

            if (e.GetValue("Designation").ToString() == "")
            {
                if (e.Column.FieldName == "PropertyDesignation")
                {
                    if (e.CellValue.ToString() != "")
                    {
                        Color bColor = Color.FromName("#DBEBFF");
                        e.Cell.BackColor = bColor;
                    }
                }
                if (e.Column.FieldName == "Valeur")
                {
                    if (e.GetValue("PropertyDesignation").ToString() != "")
                    {
                        Color bColor = Color.FromName("#DBEBFF");
                        e.Cell.BackColor = bColor;
                    }
                }

                if (e.Column.FieldName == "UnitDesignation")
                {
                    if (e.GetValue("PropertyDesignation").ToString() != "")
                    {
                        Color bColor = Color.FromName("#DBEBFF");
                        e.Cell.BackColor = bColor;
                    }
                }
            }
        }

        protected void grdMaterials_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["FilterID"] = null;
                Session["FilterType"] = null;
            }
        }

        protected void MaterialsDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
            SqlParameter a = new SqlParameter();
            a.ParameterName = "Locale";
            a.Value = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            e.Command.Parameters.Add(a);
        }


    }
}