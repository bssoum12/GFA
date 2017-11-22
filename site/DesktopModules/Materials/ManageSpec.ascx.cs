using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DotNetNuke.Entities.Users;
using VD.Modules.VBFramework; 
using DevExpress.Web;
using System.Data.SqlClient;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class EIF_Materials_ManageSpec : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        //Declaration variables
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();
        protected string _portalAlias = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            _portalAlias = GlobalAPI.CommunUtility.GetPortalAlias();

            Session["lang"] = Request.QueryString["lang"];

            //lblAddNewSpecUI
            //lblNewSpecLib.Text = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            //btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            //btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
                        
            //Traduction TreeList
            tlMatSpec.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            tlMatSpec.SettingsPopupEditForm.Caption = DotNetNuke.Services.Localization.Localization.GetString("addSpec", ressFilePath);
            tlMatSpec.SettingsText.CommandNew = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdNew", ressFilePath);
            tlMatSpec.SettingsText.CommandUpdate = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdEdit", ressFilePath);
            tlMatSpec.SettingsText.CommandCancel = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            btnFilter.Text = DotNetNuke.Services.Localization.Localization.GetString("lbBtnFilter", ressFilePath);

            //Traduction menu popup
            pupMnuManageSpec.Items.FindByName("editSpec").Text = DotNetNuke.Services.Localization.Localization.GetString("editSpec", ressFilePath);
            pupMnuManageSpec.Items.FindByName("editSpec").ToolTip = DotNetNuke.Services.Localization.Localization.GetString("editSpec", ressFilePath);
            pupMnuManageSpec.Items.FindByName("deleteSpec").Text = DotNetNuke.Services.Localization.Localization.GetString("deleteSpec", ressFilePath);
            pupMnuManageSpec.Items.FindByName("deleteSpec").ToolTip = DotNetNuke.Services.Localization.Localization.GetString("deleteSpec", ressFilePath);

            pupMnuManageSpec.Items.FindByName("assignToDiscipline").Text = DotNetNuke.Services.Localization.Localization.GetString("lbAssignToDiscipline", ressFilePath);
            pupMnuManageSpec.Items.FindByName("assignToDiscipline").ToolTip = DotNetNuke.Services.Localization.Localization.GetString("lbAssignToDiscipline", ressFilePath);

            pupMnuManageSpec.Items.FindByName("assignToSupplier").Text = DotNetNuke.Services.Localization.Localization.GetString("lbAddSpecToSupplier", ressFilePath);
            pupMnuManageSpec.Items.FindByName("assignToSupplier").ToolTip = DotNetNuke.Services.Localization.Localization.GetString("lbAddSpecToSupplier", ressFilePath);

            pupMnuManageSpec.Items.FindByName("assignToProperties").Text = DotNetNuke.Services.Localization.Localization.GetString("lbAddSpecToProperties", ressFilePath);
            pupMnuManageSpec.Items.FindByName("assignToProperties").ToolTip = DotNetNuke.Services.Localization.Localization.GetString("lbAddSpecToProperties", ressFilePath);


            tlMatSpec.DataBind();
            /*if (! IsPostBack )
            {
                Session["specid"] = tlMatSpec.FocusedNode.Key;
            }*/
           
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            try
            {
                System.Web.UI.Control ctrl = GlobalAPI.CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox) ctrl;
                
                if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                {
                    
                    tlMatSpec.CollapseAll();
                    
                    string specID = lbtokeninputvalue.Items[0].Value.ToString().Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();

                    DevExpress.Web.ASPxTreeList.TreeListNode node = tlMatSpec.FindNodeByKeyValue(specID);
                    while (node.ParentNode.Key != "")
                    {
                        node = node.ParentNode;
                    }
                    TreeListNodeIterator iterator = tlMatSpec.CreateNodeIterator(node);
                    while (iterator.Current != null)
                    {
                        iterator.Current.Expanded = true;
                        iterator.Current.Focus();
                        if (iterator.Current.Key == specID)
                        {
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

        protected void tlMatSpec_NodeInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            try
            {
                string IDParent;
                try
                {
                    IDParent = e.NewValues[tlMatSpec.ParentFieldName].ToString();
                }
                catch (Exception)
                {
                    IDParent = "";
                }


                string result = SpecificationController.AddNewSpec(IDParent, e.NewValues["Designation"].ToString(), Utili.UserID);
                if (!result.Equals("ID"))
                {
                    GlobalAPI.CommunUtility.logEvent("Error insert new spec : " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles);
                }
                //bind treeList 
                tlMatSpec.DataBind();

                e.Cancel = true;
                tlMatSpec.CancelEdit();

            }
            catch (Exception ex)
            {
                GlobalAPI.CommunUtility.logEvent("Error tlMatSpec_NodeInserted : " + ex.Message, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles);
            }
        }

        protected void tlMatSpec_NodeUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            try
            {
                string result = "";
                if (e.OldValues.Contains("Id_Parent"))
                    result = SpecificationController.EditSpec(tlMatSpec.FocusedNode.Key, e.NewValues["Id_Parent"].ToString(), tlMatSpec.FocusedNode.GetValue("Designation").ToString(), Utili.UserID);
                else
                    result = SpecificationController.EditSpec(tlMatSpec.FocusedNode.Key, tlMatSpec.FocusedNode.ParentNode.Key, e.NewValues["Designation"].ToString(), Utili.UserID);
                if (!result.Equals("ok"))
                {
                    GlobalAPI.CommunUtility.logEvent("Error update spec : " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles);
                }
                //bind treeList 
                tlMatSpec.DataBind();

                e.Cancel = true;
                tlMatSpec.CancelEdit();
                
            }
            catch (Exception ex)
            {
                GlobalAPI.CommunUtility.logEvent("Error tlMatSpec_NodeUpdated : " + ex.Message, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles );
            }
        }

        protected void tlMatSpec_NodeDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int idSpec = int.Parse(tlMatSpec.FocusedNode.Key);
            if (SpecificationController.deleteMaterialsSpecification(idSpec))
            {
                e.Cancel = false;
                throw new System.InvalidOperationException(DotNetNuke.Services.Localization.Localization.GetString("deleteSpecErr", ressFilePath));
            }
            else
            {
                //bind treeList     
                tlMatSpec.DataBind();
                e.Cancel = true;
            } 
        }
         
        protected void tlMatSpec_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            tlMatSpec.DataBind();
        }

        /*protected void tlMatSpec_FocusedNodeChanged(object sender, EventArgs e)
        {
            Session["specid"] = tlMatSpec.FocusedNode.Key;
        }*/

        protected void tlMatSpec_CustomErrorText(object sender, TreeListCustomErrorTextEventArgs e)
        {
            if (e.ErrorText == "The node has descendant nodes.")
            {
                e.ErrorText = DotNetNuke.Services.Localization.Localization.GetString("deleteSpecErr", ressFilePath);
            }
        }

        protected void tlMatSpec_DataBound(object sender, EventArgs e)
        {

        }

        protected void tlMatSpec_InitNewNode(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {

            //ASPxLabel lblAddNewSpecUI = (ASPxLabel)tlMatSpec.FindEditFormTemplateControl("lblAddNewSpecUI");
            //lblAddNewSpecUI.Text = DotNetNuke.Services.Localization.Localization.GetString("addSpec", ressFilePath);

            //ASPxLabel lblNewSpecLib = (ASPxLabel)tlMatSpec.FindEditFormTemplateControl("lblNewSpecLib");
            //lblNewSpecLib.Text = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);

            //ASPxButton btnApply = (ASPxButton)tlMatSpec.FindEditFormTemplateControl("lblNewSpecLib");
            //btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);

            //ASPxButton btnClose = (ASPxButton)tlMatSpec.FindEditFormTemplateControl("btnClose");
            //btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
        }

        protected void sqlMatSpec_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = "Id_Discipline";
            if (HttpContext.Current.Request.QueryString["DisciplineID"] != null)
                param.Value = HttpContext.Current.Request.QueryString["DisciplineID"].ToString();
            else
                param.Value = "all";
            e.Command.Parameters.Add(param);
        }
    }
}