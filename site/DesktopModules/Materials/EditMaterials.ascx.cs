using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Localization;
using VD.Modules.Framework;
using VD.Modules.VBFramework;
using System.Drawing;
using GlobalAPI;


namespace VD.Modules.Materials
{
    public partial class EditMaterials : DotNetNuke.Entities.Modules.PortalModuleBase
    {
         
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();         
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        protected string _portalAlias = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();
            Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "jquery.js", ResolveClientUrl("~/Resources/Shared/scripts/jquery/jquery.js")); 
            if (!IsPostBack)
            {
                Session["ID_Discipline"] = null;
                Session["NormList"] = null;
                Session["SpecID"] = null;
                Session["ID_Properties"] = null;
                Session["IDNormCase"] = null;
                Session["ArticleID"] = null;
                Session["entete"] = null; 
                grdLookCases.GridView.Width = grdLookCases.Width;
                TranslateFrm(); 
                Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                if (HttpContext.Current.Request.QueryString["key"] != null)
                {                    
                    int Id = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
                    Session["ArticleID"] = Id;                    
                    var materials = MaterialsController.getMaterialByID(Id);
                    txtCode.Text = materials.Code;                    
                    switch ( materials.TypeCode  )
                    {
                        case 1:
                            rdbtnListCode.SelectedIndex = 1;
                            myBarCode.Visible = true;                                                        
                            myBarCode.ImageUrl = "BarCode.aspx?code=" + materials.Code ;
                            txtCode.Visible = false;
                            lblCodeGenerer.Visible = false;
                            break;
                        case 2:
                            rdbtnListCode.SelectedIndex = 2; 
                            lblCodeGenerer.Visible = true;                                                        
                            lblCodeGenerer.Text = materials.Code ;
                            myBarCode.Visible = false;
                            txtCode.Visible = false;
                            break;
                        default:
                            rdbtnListCode.SelectedIndex   = 0;                            
                            txtCode.Text = materials.Code;
                            txtCode.Enabled = false; 
                            myBarCode.Visible = false;
                            lblCodeGenerer.Visible = false;
                            break;
                    }
                    string mode = string.Empty;
                    if (HttpContext.Current.Request.QueryString["mode"] != null)
                        mode = HttpContext.Current.Request.QueryString["mode"].ToString();
                    if( mode != "duplicat" ) 
                        rdbtnListCode.Enabled = false; 
                    this.txtDescription.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, materials.Description);
                    this.txtNom.SetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, materials.Nom);

                    SettxtLanaguage(Id);                   
                    DropDownEdit.KeyValue = materials.ID_MaterialsSpecifications;
                    Session["SpecID"] = materials.ID_MaterialsSpecifications;
                    DropDownEdit.Text = SpecificationController.GetMaterialsSpecDescriptionById(materials.ID_MaterialsSpecifications); 
                    GetMaterialsNorm(Id);
                    if (materials.ID_Brand != null)
                        cmbBrands.Value = materials.ID_Brand;
                    txtcodeDouane.Text = materials.Codedouane; 
                    txtStockLimit.Text = materials.AlerteStock.ToString() ;
                    txtStockdesire.Text = materials.StockOptimal.ToString();
                    cmbEtatAchat.Value = (materials.EtatAchat == true) ? 1 : 0; 
                    cmbEtatVente.Value = (materials.EtatVente == true) ? 1 : 0;                    
                    var brand = (cmbBrands.Value != null) ? Int32.Parse(cmbBrands.Value.ToString()) : -1;
                    if (materials.ID_PaysOrigne != null)
                        cmbPaysOrigine.Value = materials.ID_PaysOrigne; 
                    

                }
            }
        }


        /// <summary>
        /// Translates the label control.
        /// </summary>
        private void TranslateFrm()
        {
            TranslateUtility.localizeGrid(grdMaterialsSpec, ressFilePath);

            grdMaterialsSpec.Columns["DescProperties"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
            grdMaterialsSpec.Columns["Valeur"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValeur", ressFilePath);
            grdMaterialsSpec.Columns["MeasureUnit"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);            
            SaveProperties.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSelect", ressFilePath);
            popupValidation.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("hAddArticle", ressFilePath);
            rdbtnListFilter.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("lbParFamille", ressFilePath);
            rdbtnListFilter.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("lbParNorm", ressFilePath);
            rdbtnListCode.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mDefault", ressFilePath);
            rdbtnListCode.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mBarcode", ressFilePath);
            rdbtnListCode.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mGenerated", ressFilePath);
            btnNextGeneral.Text = DotNetNuke.Services.Localization.Localization.GetString("mNext", ressFilePath);
            btnFinish.Text = DotNetNuke.Services.Localization.Localization.GetString("mFinish", ressFilePath);
            btnCancel.Text = btnAnnuler1.Text = DotNetNuke.Services.Localization.Localization.GetString("mCancel", ressFilePath);
            btnPrevious.Text = DotNetNuke.Services.Localization.Localization.GetString("mPrevious", ressFilePath);
            SaveProperties.Text = DotNetNuke.Services.Localization.Localization.GetString("mSelect", ressFilePath);
                
        }

        /// <summary>
        /// Handles the CustomCallback event of the treeListNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void treeListNorm_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            if (e.Argument != "ValueChanged") return;
            Session["SpecID"] = DropDownEdit.KeyValue;
            ASPxTreeList tree = sender as ASPxTreeList;
            tree.DataBind();
        }

        /// <summary>
        /// CMBs the measure unit norm_ callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The e.</param>
        protected void cmbMeasureUnitNorm_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ASPxComboBox cmBox = sender as ASPxComboBox;
            TreeListDataCellTemplateContainer container = cmBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() != "")
            {
                Session["ID_Properties"] = container.Value;
                cmBox.DataBind();
            }
        }


        /// <summary>
        /// Handles the Init event of the cmbMeasureUnitNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void cmbMeasureUnitNorm_Init(object sender, EventArgs e)
        {
            ASPxComboBox cmBox = sender as ASPxComboBox;
            TreeListDataCellTemplateContainer container = cmBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() == "")
                cmBox.Visible = false;
        }


        /// <summary>
        /// Handles the CustomJSProperties event of the treeListNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomJSPropertiesEventArgs"/> instance containing the event data.</param>
        protected void treeListNorm_CustomJSProperties(object sender, TreeListCustomJSPropertiesEventArgs e)
        {
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
        /// Gets the materials norm.
        /// </summary>
        /// <param name="ID_Article">The I d_ article.</param>
        private void GetMaterialsNorm(int ID_Article)
        {
            string norm = "";
            ASPxTreeList treelistnorm = (ASPxTreeList)DropDownEditNorm.FindControl("treeListNorm"); 
            var ret = MaterialsController.GetNormsByMaterialsId(ID_Article);            
            foreach (Materials_Materials_Norm elem in ret)
            {            
                treelistnorm.FindNodeByKeyValue(elem.ID_Norm.ToString()).Selected = true; 
               if (norm == "")
                {                    
                    Session["NormList"] = elem.ID_Norm; 
                    norm = StandardController.GetNormDescription(elem.ID_Norm, Session["Locale"].ToString());
                }
                else
                {                    
                    Session["NormList"] = Session["NormList"].ToString() + ","+ elem.ID_Norm; 
                    norm = norm + ";" + StandardController.GetNormDescription(elem.ID_Norm, Session["Locale"].ToString());
                }                
            }
            if (Session["NormList"] != null )
            {
                DropDownEditNorm.KeyValue = Session["NormList"].ToString();
                DropDownEditNorm.Text = norm;
            }            
        }

        /// <summary>
        /// Handles the DataBound event of the cmbDiscipline control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void cmbDiscipline_DataBound(object sender, EventArgs e)
        {
            cmbDiscipline.Items.Add(DotNetNuke.Services.Localization.Localization.GetString("lbTous", ressFilePath), "ALL").Index = 0;
            Session["ID_Discipline"] = "ALL";
            cmbDiscipline.SelectedIndex = 0;
        }

        /// <summary>
        /// Update the lanaguage of description control.
        /// </summary>
        /// <param name="idArticle">The materials identifier.</param>
        private void SettxtLanaguage(int idArticle)
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);            
            foreach (var langObj in languages)
            {
                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                {
                    var retLang = MaterialsController.GetMaterialsByLocale(idArticle, langObj.Key);
                    if (retLang != null)
                    {
                        this.txtDescription.SetTextFieldValueByLocale(langObj.Key, retLang.Designation);
                        this.txtNom.SetTextFieldValueByLocale(langObj.Key,retLang.Name);
                    }
                }
            }
        }

        /// <summary>
        /// Saves the materials norm.
        /// </summary>
        /// <param name="ID_Article">The materials identifier.</param>
        private void SaveMaterialsNorm(int ID_Article)
        {
            string ret = "";
            if (DropDownEditNorm.KeyValue != null)
            {
                MaterialsController.DeleteMaterialsNormByMaterialsId(ID_Article);
                var keys = DropDownEditNorm.KeyValue.ToString().Split(';');
                foreach (object item in keys)
                {
                    if (item.ToString() != "")
                    {
                        int IdNorm = Convert.ToInt32(item);
                        MaterialsController.AddMaterialsNorm(ID_Article, IdNorm);
                        if (ret == "")
                            ret = item.ToString();
                        else
                            ret = ret + "," + item.ToString();
                    }
                }
            }
            Session["NormList"] = ret; 
        }

        /// <summary>
        /// save the language of the materials.
        /// </summary>
        /// <param name="Id">The id.</param>
        private void SavetxtLanguage(int Id)
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);            
            foreach (var langObj in languages)
            {
                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    MaterialsController.UpdateMaterialsML(Id,this.txtNom.GetTextFieldValueByLocale(langObj.Key),  this.txtDescription.GetTextFieldValueByLocale(langObj.Key), langObj.Key, CurrentUser.UserID);                                     
            }

        }
        /// <summary>
        /// Handles the CustomCallback event of the treeList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void treeList_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
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
        /// Handles the CustomCallback event of the gridView control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        public void gridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters != "ValueChanged") return;
            Session["SpecID"] = DropDownEdit.KeyValue;
            ASPxGridView grid = sender as ASPxGridView;
            grid.DataBind();
        }


        /// <summary>
        /// Handles the CustomCallback event of the grdMaterialsSpec control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdMaterialsSpec_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            grdMaterialsSpec.DataBind();
        }

        /// <summary>
        /// Handles the CustomCallback event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroups_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            Session["SpecID"] = DropDownEdit.KeyValue;
            tlsPropertiesGroups.DataBind();
        }

        /// <summary>
        /// Handles the CustomCallback event of the tlsPropertiesGroupsNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroupsNorm_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            Session["IDNormCase"] = grdLookCases.Value;
            tlsPropertiesGroupsNorm.DataBind(); 
        }

        /// <summary>
        /// Handles the HtmlDataCellPrepared event of the tlsPropertiesGroupsNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListHtmlDataCellEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroupsNorm_HtmlDataCellPrepared(object sender, TreeListHtmlDataCellEventArgs e)
        {
            if (e.GetValue("Designation").ToString() == "")
            {
                if (e.Column.FieldName == "PropertyDesignation")
                {
                    if (e.CellValue.ToString() != "")
                    {
                        Color bColor = Color.FromName("#c0e0e7");
                        e.Cell.BackColor = bColor;
                    }
                }
            }
        }

        /// <summary>
        /// Handles the Init event of the txtPropertyValue control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void txtPropertyValue_Init(object sender, EventArgs e)
        {
            ASPxTextBox textBox = sender as ASPxTextBox;
            TreeListDataCellTemplateContainer container = textBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() == "")
                textBox.Visible = false;
        }

        /// <summary>
        /// Handles the HtmlDataCellPrepared event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sebtnSave_Clicknder">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListHtmlDataCellEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroups_HtmlDataCellPrepared(object sebtnSave_Clicknder, TreeListHtmlDataCellEventArgs e)
        {
            if (e.GetValue("Designation").ToString() == "")
            {
                if (e.Column.FieldName == "PropertyDesignation")
                {
                    if (e.CellValue.ToString() != "")
                    {
                        Color bColor = Color.FromName("#c0e0e7");
                        e.Cell.BackColor = bColor;
                    }

                }
            }


        }

        /// <summary>
        /// Handles the Init event of the cmbMeasureUnit control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void cmbMeasureUnit_Init(object sender, EventArgs e)
        {
            ASPxComboBox cmBox = sender as ASPxComboBox;
            TreeListDataCellTemplateContainer container = cmBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() == "")
                cmBox.Visible = false;
        }

        /// <summary>
        /// CMBs the measure unit_ callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The e.</param>
        protected void cmbMeasureUnit_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ASPxComboBox cmBox = sender as ASPxComboBox;
            TreeListDataCellTemplateContainer container = cmBox.NamingContainer as TreeListDataCellTemplateContainer;
            if (container.Value.ToString() != "")
            {
                Session["ID_Properties"] = container.Value;
                cmBox.DataBind();
            }
        }

        /// <summary>
        /// Handles the HtmlRowPrepared event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListHtmlRowEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroups_HtmlRowPrepared(object sender, TreeListHtmlRowEventArgs e)
        {
            if (e.GetValue("Designation").ToString() != "")
            {
                foreach (TableCell cell in e.Row.Cells)
                {
                    if (cell is DevExpress.Web.ASPxTreeList.Internal.TreeListSelectionCell)
                    {
                        (cell as DevExpress.Web.ASPxTreeList.Internal.TreeListSelectionCell).Controls[0].Visible = false;
                        break;
                    }
                }
            }
        }

        /// <summary>
        /// Handles the HtmlRowPrepared event of the tlsPropertiesGroupsNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListHtmlRowEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroupsNorm_HtmlRowPrepared(object sender, TreeListHtmlRowEventArgs e)
        {
            if (e.GetValue("Designation").ToString() != "")
            {
                foreach (TableCell cell in e.Row.Cells)
                {
                    if (cell is DevExpress.Web.ASPxTreeList.Internal.TreeListSelectionCell)
                    {
                        (cell as DevExpress.Web.ASPxTreeList.Internal.TreeListSelectionCell).Controls[0].Visible = false;
                        break;
                    }
                }

            }
        }


        /// <summary>
        /// Handles the Callback event of the StepCallback control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.CallbackEventArgs" /> instance containing the event data.</param>
        protected void StepCallback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            try
            {
                if ( Page.IsValid ) 
                {
                int key  = Convert.ToInt32(HttpContext.Current.Request.QueryString["key"].ToString());
                string mode = string.Empty; 
                if (HttpContext.Current.Request.QueryString["mode"] !=  null) 
                    mode = HttpContext.Current.Request.QueryString["mode"].ToString();
                if (e.Parameter.ToString() == "0")
                {
                                  if (SaveMaterials(key , mode ))
                                      e.Result = "ok#" + e.Parameter.ToString() + "#" + key.ToString();                                   
                }
                else if (e.Parameter.ToString() == "1")
                {
                    if (MaterialsController.IsExisteMaterials(key))
                        e.Result = "erreur#" + DotNetNuke.Services.Localization.Localization.GetString("mMaterialsAlreayExiste", ressFilePath);
                    else
                    {
                        try
                        {
                            //Notify users
                            string link = DotNetNuke.Common.Globals.NavigateURL(Int32.Parse(HttpContext.Current.Request.QueryString["TabId"].ToString()));
                            if (link.Contains("?"))
                                link = link + "&" + "MaterialKey=" + key.ToString();
                            else
                                link = link + "?" + "MaterialKey=" + key.ToString();
                        //    MaterialProcess.SendNotificationForMaterialsActors(key, 1, link, DotNetNuke.Entities.Host.Host.SMTPServer.ToString(), 0, CurrentUser.UserID, null, CurrentUser.DisplayName, CurrentUser.Username, ModuleId);
                        }
                        catch (Exception)
                        { }   
                        e.Result = "ok#" + e.Parameter.ToString() + "#" + key.ToString();
                    }
                }
                else if (e.Parameter.ToString() == "cancel")
                {
                    if (Session["ArticleID"] != null)
                    {                                                
                        e.Result = "del#2";
                    }
                }
                }
            }
            catch
            {                
                e.Result = "erreur#" + DotNetNuke.Services.Localization.Localization.GetString("lbAssignS2SErr", ressFilePath); 
            }
        }


        /// <summary>
        /// Saves the materials.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        private bool SaveMaterials( int key , string mode  )
        {
            bool ret = false;
            
            if (Page.IsValid)
            {
                
                    Session["ArticleID"] = key ;                   
                    int MaterialsSpecId = Convert.ToInt32(DropDownEdit.KeyValue);                    
                    string nom = string.Empty ; 
                    string description = string.Empty; 
                    var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                    string defaultLanguageValue = txtDescription.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                    if (defaultLanguageValue != "")
                        description = defaultLanguageValue;
                    else
                        description = this.txtDescription.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);

                    string defaultLanguageName = txtNom.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
                    if (defaultLanguageName != "")
                        nom = defaultLanguageName;
                    else
                        nom = this.txtNom.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);

                double? _alertstock = null;
                if (txtStockLimit.Text != "") _alertstock = double.Parse(txtStockLimit.Text);
                double? _stockoptimal = null;
                if (txtStockdesire.Text != "") _stockoptimal = double.Parse(txtStockdesire.Text);
                string _codedouane = txtcodeDouane.Text;
                bool? _etatAchat = (double.Parse(cmbEtatAchat.Value.ToString()) == 1) ? true : false;
                bool? _etatVente = (double.Parse(cmbEtatVente.Value.ToString()) == 1) ? true : false;
                var brand = (cmbBrands.Value != null) ? Int32.Parse(cmbBrands.Value.ToString()) : -1;
                int? _paysorigine = null;
                if (cmbPaysOrigine.Value != null) _paysorigine = Int32.Parse(cmbBrands.Value.ToString());



                if (mode == "duplicat")
                    {
                        SaveDuplicateMaterial(key, txtCode.Text, Convert.ToInt32(rdbtnListCode.Value), description, nom, MaterialsSpecId, brand, _alertstock, _stockoptimal, _codedouane, _etatAchat, _etatVente, _paysorigine);

                    ret = true;    
                    }
                    else
                    {
                        MaterialsController.UpdateMaterials(key, nom, description, MaterialsSpecId, CurrentUser.UserID, brand, _alertstock, _stockoptimal, _codedouane, _etatAchat, _etatVente, _paysorigine);
                    Session["SpecID"] = DropDownEdit.KeyValue;
                        SavetxtLanguage(key);
                        SaveMaterialsNorm(key);
                        ret = true;             
                    }
                    Session["entete"] = txtCode.Text + "#" + nom + "#" + description + "#" + cmbDiscipline.Text + "#" + DropDownEdit.Text + "#" + DropDownEditNorm.Text; 

            }

            return ret;
        }


        /// <summary>
        /// Saves the duplicate materials.
        /// </summary>
        /// <returns></returns>
        private bool SaveDuplicateMaterial(int SourceKey , string code, int typecode, string description, string nom, int MaterialsSpecID, int? brandId, double? _alertstock, double? _stockoptimal, string _codedouane, bool? _etatAchat, bool? _etatVente, int? _paysorigine)
        {
            try
            {
                bool ret = false;
                int MaterialsID = MaterialsController.AddMaterials(code, typecode, description, nom, MaterialsSpecID, CurrentUser.UserID, brandId , _alertstock, _stockoptimal, _codedouane, _etatAchat, _etatVente, _paysorigine);
                if (MaterialsID > -1)
                {
                    MaterialsController.CopyMaterialsProperties(SourceKey, MaterialsID, CurrentUser.UserID);
                    Session["ArticleID"] = MaterialsID;
                    txtMaterialsID.Text = Session["ArticleID"].ToString();
                    Session["SpecID"] = DropDownEdit.KeyValue;
                    SavetxtLanguage(MaterialsID);
                    SaveMaterialsNorm(MaterialsID);
                    int caseSwitch = Convert.ToInt32(rdbtnListCode.Value);
                    switch (caseSwitch)
                    {
                        case 1:
                            myBarCode.Visible = true;
                            if (cmbDiscipline.Value != null)
                                code = cmbDiscipline.Value.ToString() + string.Format("{0:0000000}", MaterialsID);
                            else
                                code = "GE" + string.Format("{0:0000000}", MaterialsID);
                            if (MaterialsController.IsCodeExiste(code))
                                MaterialsController.UpdateMaterialsCode(MaterialsID, code + "0");
                            else
                                MaterialsController.UpdateMaterialsCode(MaterialsID, code);
                            myBarCode.ImageUrl = "BarCode.aspx?code=" + code;
                            txtCode.Visible = false;
                            lblCodeGenerer.Visible = false;
                            break;
                        case 2:
                            lblCodeGenerer.Visible = true;
                            if(cmbDiscipline.Value != null)
                                code = cmbDiscipline.Value.ToString() + string.Format("{0:0000000}", MaterialsID);
                            else
                                code = "GE" + string.Format("{0:0000000}", MaterialsID);
                            if (MaterialsController.IsCodeExiste(code))
                                MaterialsController.UpdateMaterialsCode(MaterialsID, code + "0");
                            else
                                MaterialsController.UpdateMaterialsCode(MaterialsID, code);
                            lblCodeGenerer.Text = code;
                            myBarCode.Visible = false;
                            txtCode.Visible = false;
                            break;
                        default:
                            txtCode.Enabled = false;
                            myBarCode.Visible = false;
                            lblCodeGenerer.Visible = false;
                            break;
                    }
                    ret = true;

                }
                Session["entete"] = txtCode.Text + "#" + nom + "#" + description + "#" + cmbDiscipline.Text + "#" + DropDownEdit.Text + "#" + DropDownEditNorm.Text; 
                return ret;
            }
            catch
            {
                return false; 
            }
        }


        /// <summary>
        /// Handles the Init event of the grdLookCases control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void grdLookCases_Init(object sender, EventArgs e)
        {
            ASPxGridLookup lookup = (ASPxGridLookup)sender;
            ASPxGridView gridView = lookup.GridView;
            gridView.CustomCallback += new ASPxGridViewCustomCallbackEventHandler(grdLookCases_gridView_CustomCallback);
        }

        /// <summary>
        /// Handles the CustomCallback event of the grdLookCases_gridView control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        void grdLookCases_gridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            ASPxGridView gridView = (ASPxGridView)sender;
            //Put code here to requery/rebind the datasource for the ASPxGridLookup control	
            SqlCasesByNormDS.DataBind();
            gridView.DataBind();
        }

       
        /// <summary>
        /// Handles the Callback event of the SelectPropertiesCallback control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.CallbackEventArgs"/> instance containing the event data.</param>
        protected void SelectPropertiesCallback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            int IdArticle;
            int IdProperties;
            int IdMesureUnit = -1;            
            //int UserID = Convert.ToInt32(CurrentUser.Username);
            if (rdbtnListFilter.Value.ToString() == "1")
            {
                List<TreeListNode> tls = tlsPropertiesGroupsNorm.GetSelectedNodes();
                foreach (TreeListNode tl in tls)
                {
                    if (tl.GetValue("PropertyID").ToString() != "")
                    {
                        IdArticle = Convert.ToInt32(Session["ArticleID"]);
                        IdProperties = Convert.ToInt32(tl.GetValue("PropertyID"));
                        ASPxComboBox cmbMesureUnit = tlsPropertiesGroupsNorm.FindDataCellTemplateControl(tl.Key, null, "cmbMeasureUnitNorm") as ASPxComboBox;
                        if (cmbMesureUnit.Value != null)
                            IdMesureUnit = Convert.ToInt32(cmbMesureUnit.Value.ToString());
                        else
                            IdMesureUnit = -1;
                        ASPxTextBox txtVal = tlsPropertiesGroupsNorm.FindDataCellTemplateControl(tl.Key, null, "txtPropertyValue") as ASPxTextBox;
                        MaterialsController.AddMaterialsProperties(IdArticle, IdProperties, IdMesureUnit, txtVal.Text, CurrentUser.UserID );
                    }
                }
                tlsPropertiesGroupsNorm.UnselectAll();
            }
            else
            {
                List<TreeListNode> tls = tlsPropertiesGroups.GetSelectedNodes();
                foreach (TreeListNode tl in tls)
                {
                    if (tl.GetValue("PropertyID").ToString() != "")
                    {
                        IdArticle = Convert.ToInt32(Session["ArticleID"]);
                        IdProperties = Convert.ToInt32(tl.GetValue("PropertyID"));
                        ASPxComboBox cmbMesureUnit = tlsPropertiesGroups.FindDataCellTemplateControl(tl.Key, null, "cmbMeasureUnit") as ASPxComboBox;
                        if (cmbMesureUnit.Value != null)
                            IdMesureUnit = Convert.ToInt32(cmbMesureUnit.Value.ToString());
                        else
                            IdMesureUnit = -1;
                        ASPxTextBox txtVal = tlsPropertiesGroups.FindDataCellTemplateControl(tl.Key, null, "txtPropertyValue") as ASPxTextBox;
                        MaterialsController.AddMaterialsProperties(IdArticle, IdProperties, IdMesureUnit, txtVal.Text,  CurrentUser.UserID );
                    }
                }
                tlsPropertiesGroups.UnselectAll();
            }
        }


        /// <summary>
        /// Callbacks the panel general_ callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The e.</param>
        protected void CallbackPanelGeneral_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (Session["entete"] != null)
            {
                var items = Session["entete"].ToString().Split('#');
                lblCode.Text = items[0].ToString();
                lblName.Text = items[1].ToString();
                lblDescription.Text = items[2].ToString();
                lblDiscipline.Text = items[3].ToString();
                lblSpec.Text = items[4].ToString();
                lblNorm.Text = items[5].ToString();
            }
        }
        
        /// <summary>
        /// CMBs the brands_ callback.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The e.</param>
        /// <history>
        /// 	<para>[Anis Zouari]	21/05/2014  Created</para>
        /// </history>
        protected void cmbBrands_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            cmbBrands.DataBind();
        }

    }
}