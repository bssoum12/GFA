using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework; 
using DevExpress.Web;
using DataLayer;
using System.Collections;
using DotNetNuke.Services.Localization;
using System.Drawing;
using GlobalAPI;
using VD.Modules.VBFramework; 



namespace VD.Modules.Materials
{
    public partial class AddMaterials : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        /// <summary>
        /// The current user
        /// </summary>
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        /// <summary>
        /// The ressource file path
        /// </summary>
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
            Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "jquery.js", ResolveClientUrl("~/Resources/Shared/scripts/jquery/jquery.js")); 
            if (!IsPostBack)
            {
                Session["ID_Discipline"] = null ;
                Session["NormList"] =  null  ; 
                Session["SpecID"]  =  null ; 
                Session["ID_Properties"]  =  null  ;  
                Session["IDNormCase"]  =  null  ;
                Session["ArticleID"] = null;
                Session["entete"] = null; 
                grdLookCases.GridView.Width = grdLookCases.Width;
                Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name; 
                TranslateUtility.localizeGrid(grdMaterialsSpec, ressFilePath);                                                            
                grdMaterialsSpec.Columns["DescProperties"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath);
                grdMaterialsSpec.Columns["Valeur"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hValeur", ressFilePath);
                grdMaterialsSpec.Columns["MeasureUnit"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMeasureUnit", ressFilePath);                
                popupValidation.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("hAddArticle", ressFilePath);
                rdbtnListFilter.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("lbParFamille", ressFilePath);
                rdbtnListFilter.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("lbParNorm", ressFilePath);

                rdbtnListCode.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mDefault", ressFilePath);
                rdbtnListCode.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mBarcode", ressFilePath);
                rdbtnListCode.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mGenerated", ressFilePath);
                btnNextGeneral.Text = DotNetNuke.Services.Localization.Localization.GetString("mNext", ressFilePath);
                btnFinish.Text = DotNetNuke.Services.Localization.Localization.GetString("mFinish", ressFilePath);
                btnCancel.Text =  btnAnnuler1.Text = DotNetNuke.Services.Localization.Localization.GetString("mCancel", ressFilePath);
                SaveProperties.Text = DotNetNuke.Services.Localization.Localization.GetString("mSelect", ressFilePath);
                DropDownEdit.ValidationSettings.RequiredField.ErrorText = DotNetNuke.Services.Localization.Localization.GetString("mSelectSpecification", ressFilePath);

                //Init Case Spec Selected
                if (HttpContext.Current.Request.QueryString["SpecKey"] != null)
                {
                    int IdSpec = Convert.ToInt32(HttpContext.Current.Request.QueryString["SpecKey"].ToString());
                    MaterialsDataContext layer = new MaterialsDataContext();
                    var matspec = (from d in layer.Materials_MaterialsSpecifications where d.ID == IdSpec select d).SingleOrDefault();
                    DropDownEdit.KeyValue = matspec.ID;
                    DropDownEdit.Text = matspec.Designation;
                }
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
        /// Saves the materials norm.
        /// </summary>
        /// <param name="ID_Article">The I d_ article.</param>
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
                        MaterialsController.AddMaterialsNorm(ID_Article, Convert.ToInt32(item));
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
        /// Save the language.
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
        /// Handles the CustomCallback event of the grdMaterialsSpec control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.ASPxGridViewCustomCallbackEventArgs"/> instance containing the event data.</param>
        protected void grdMaterialsSpec_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {              
                grdMaterialsSpec.DataBind();
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
        /// Handles the CustomJSProperties event of the treeList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomJSPropertiesEventArgs"/> instance containing the event data.</param>
        protected void treeList_CustomJSProperties(object sender, TreeListCustomJSPropertiesEventArgs e)
        {
            ASPxTreeList tree = (ASPxTreeList)DropDownEdit.FindControl("treeList");
            object[] employeeNames = new object[tree.GetAllNodes().Count ];
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
        /// Handles the CustomCallback event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListCustomCallbackEventArgs"/> instance containing thes event data.</param>
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
            if (container.Value.ToString()  == "") 
               textBox.Visible = false; 
        }

        /// <summary>
        /// Handles the HtmlDataCellPrepared event of the tlsPropertiesGroups control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="TreeListHtmlDataCellEventArgs"/> instance containing the event data.</param>
        protected void tlsPropertiesGroups_HtmlDataCellPrepared(object sender, TreeListHtmlDataCellEventArgs e)
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
        /// Handles the Callback event of the cmbMeasureUnit control.
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
        /// Handles the Callback event of the cmbMeasureUnitNorm control..
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
        /// Handles the Callback event of the StepCallback control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.CallbackEventArgs"/> instance containing the event data.</param>
      protected void StepCallback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
      {
          try
          {
              if (Page.IsValid)
              {
                  if (e.Parameter.ToString() == "0")
                  {
                      string code = string.Empty;
                      if ((rdbtnListCode.SelectedItem.Value.ToString() == "0") && (txtCode.Text == ""))
                      {
                          e.Result = "erreur#" + DotNetNuke.Services.Localization.Localization.GetString("mCodeVide", ressFilePath);
                      }
                      else
                      {
                          if ((rdbtnListCode.SelectedItem.Value.ToString() == "0") && MaterialsController.IsCodeExiste(txtCode.Text))
                          {
                              e.Result = "erreur#" + DotNetNuke.Services.Localization.Localization.GetString("mExisteCode", ressFilePath);
                          }
                          else
                          {
                              if (SaveMaterials())
                                  e.Result = "ok#" + e.Parameter.ToString() + "#" + Session["ArticleID"].ToString();
                          }
                      }



                  }
                  else if (e.Parameter.ToString() == "1")
                  {
                      if (Session["ArticleID"] != null)
                      {
                          var key = Convert.ToInt32(Session["ArticleID"]);
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
                              //    MaterialProcess.SendNotificationForMaterialsActors(key, 0, link, DotNetNuke.Entities.Host.Host.SMTPServer.ToString(), 0, CurrentUser.UserID, null, CurrentUser.DisplayName, CurrentUser.Username, ModuleId);
                              }
                              catch (Exception)
                              {}                               
                              e.Result = "ok#" + e.Parameter.ToString() + "#" + Session["ArticleID"].ToString();
                          }
                      }
                  }
                  else if (e.Parameter.ToString() == "cancel")
                  {
                      if (Session["ArticleID"] != null)
                      {
                          var key = Convert.ToInt32(Session["ArticleID"].ToString());
                          MaterialsController.deleteMaterialByID(key);
                      }
                      e.Result = "del#2";                      
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
      /// <returns></returns>
      private bool SaveMaterials()
      {
          bool ret = false;     
          int MaterialsID = -1 ;       
              int MaterialsSpecID = Convert.ToInt32(DropDownEdit.KeyValue);              
              string code = txtCode.Text; 
              string nom ;
              string description = string.Empty;
              int typecode = Convert.ToInt32(rdbtnListCode.Value);
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
               if(txtStockLimit.Text != "" )  _alertstock = double.Parse(txtStockLimit.Text)  ;
            double? _stockoptimal = null;
            if ( txtStockdesire.Text != "") _stockoptimal = double.Parse(txtStockdesire.Text);
            string _codedouane = txtcodeDouane.Text;
            bool? _etatAchat = ( double.Parse(cmbEtatAchat.Value.ToString() )  ==  1) ? true : false;
            bool? _etatVente = (double.Parse( cmbEtatVente.Value.ToString()) == 1) ? true : false;
            var brand = (cmbBrands.Value != null) ? Int32.Parse(cmbBrands.Value.ToString()) : -1 ;
            int? _paysorigine = null;
            if( cmbPaysOrigine.Value != null) _paysorigine =  Int32.Parse(cmbPaysOrigine.Value.ToString() ) ;

            if (Session["ArticleID"] == null)
              {
                

                  MaterialsID = MaterialsController.AddMaterials(code, typecode, description, nom, MaterialsSpecID, CurrentUser.UserID , brand , _alertstock , _stockoptimal , _codedouane , _etatAchat , _etatVente , _paysorigine);
                  Session["ArticleID"] = MaterialsID; 
              }
              else
              {
                  MaterialsID = Convert.ToInt32(Session["ArticleID"].ToString());
                  MaterialsController.UpdateMaterials(MaterialsID, nom, description, MaterialsSpecID, CurrentUser.UserID , brand , _alertstock, _stockoptimal, _codedouane, _etatAchat, _etatVente , _paysorigine);
            }
              if (MaterialsID > -1)
              {
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
                  Session["entete"] = code + "#" +  nom  + "#" + description + "#" + cmbDiscipline.Text + "#" + DropDownEdit.Text  + "#" + DropDownEditNorm.Text ; 
              }

          return ret;
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
                        MaterialsController.AddMaterialsProperties(IdArticle, IdProperties, IdMesureUnit, txtVal.Text, CurrentUser.UserID);
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

        /// <summary>
        /// Handles the Callback event of the cmbFilterSpec control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="CallbackEventArgsBase"/> instance containing the event data.</param>
        protected void cmbFilterSpec_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ASPxTreeList tlsSpec = (ASPxTreeList)DropDownEdit.FindControl("treeList");
            ASPxComboBox cmbSpec = (ASPxComboBox)(tlsSpec.FindHeaderCaptionTemplateControl(tlsSpec.Columns["Designation"], "cmbFilterSpec"));
            cmbSpec.DataBind();
        }
    }
}