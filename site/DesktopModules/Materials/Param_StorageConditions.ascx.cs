using DevExpress.Web;
using DevExpress.Web.ASPxTreeList;
using GlobalAPI; 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VD.Modules.Materials
{
    public partial class Param_StorageConditions : System.Web.UI.UserControl
    {
         
        protected String ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
                Init_Traduction();
                treeList.ExpandToLevel(3);
            }
            treeList.JSProperties["cpDeleted"] = "";
        }

       
        protected void cmbFilter_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ASPxComboBox cmbCat = (ASPxComboBox)(treeList.FindHeaderCaptionTemplateControl(treeList.Columns["Designation"], "cmbFilter"));
            cmbCat.DataBind();
        }

         
        protected void treeList_CustomCallback(object sender, DevExpress.Web.ASPxTreeList.TreeListCustomCallbackEventArgs e)
        {
                    treeList.DataBind();
        }

      
        private string CheckNode(TreeListNode node, string data)
        {
            string keyNode = "-1";
            string s_text = data.ToLower();
            object node_value = node.GetValue("Designation");
            if (node_value == null)
                return keyNode;
            if (node_value.ToString().TrimEnd().ToLower().Equals(s_text.TrimEnd()))
            {
                node.MakeVisible();
                node.Expanded = true;
                node.Focus();
                keyNode = node.Key;
            }
            return keyNode;
        }

         
        protected void cbFilter_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            try
            {
                e.Result = "";
                if (e.Parameter != "")
                {
                    string key = "-1";
                    TreeListNodeIterator iterator = treeList.CreateNodeIterator(treeList.RootNode);
                    while ((iterator.Current != null) && (key == "-1"))
                    {
                        key = CheckNode(iterator.Current, e.Parameter);
                        iterator.GetNext();
                    }
                    if (key != "")
                    {
                        if (int.Parse(key) >= 0)
                        {
                            e.Result = key;
                        }
                    }
                }
            }
            catch (Exception)
            { }
        }
 
        public void Init_Traduction()
        {

            //Menu translation
            MenuCondition.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("storageCondition", ressFilePath);
            MenuCondition.Items[0].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            MenuCondition.Items[0].Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            MenuCondition.Items[0].Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);
            MenuConditions.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            MenuConditions.Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            MenuConditions.Items[2].Text = DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);
        }

       
        protected void cbAssign_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
          /*  int idCondition = int.Parse(treeList.FocusedNode["ID"].ToString());
            DataLayer.Materials_StorageConditions condition = StorageConditionController.GetStorageCondition(idCondition);
            //get the list of storage location which have the same parent(selected node)
            List<DataLayer.Materials_StorageConditions> StorageList = new List<DataLayer.Materials_StorageConditions>();
            StorageList = StorageConditionController.GetStorageConditionByIdParent(condition.ID);
            TreeListNode node = treeList.FindNodeByKeyValue(treeList.FocusedNode["ID"].ToString());
            if (condition.Id_Parent == null)
            {
                if (!StorageConditionController.IsUsedStorageCondition(condition.ID) && !GlobalAPI.StockUtility.IsUsedSorageConditionInLocation(condition.ID))
                {
                    if (StorageList.Count>0)
                    {
                        foreach (var cond in StorageList)
                        {
                            if (!StorageConditionController.IsUsedStorageCondition(cond.ID) && !GlobalAPI.StockUtility.IsUsedSorageConditionInLocation(cond.ID))
                            {
                                e.Result = "delete";
                            }
                            else
                                e.Result = "dontdelete";
                        }
                    }
                    else
                        e.Result = "delete";
                }
                
                else
                    e.Result = "dontdelete";

            }
            else
            {
                if (!node.HasChildren)
                {
                    if (!StorageConditionController.IsUsedStorageCondition(condition.ID) && !GlobalAPI.StockUtility.IsUsedSorageConditionInLocation(condition.ID))
                    {
                        e.Result = "delete";
                    }
                    else
                        e.Result = "dontdelete";

                }
                else
                {
                    foreach (var cond in StorageList)
                    {
                        if (!StorageConditionController.IsUsedStorageCondition(cond.ID) && !GlobalAPI.StockUtility.IsUsedSorageConditionInLocation(cond.ID))
                        {
                            e.Result = "delete";
                        }
                        else
                            e.Result = "dontdelete";
                    }
                }
            }
            treeList.DataBind();*/
        }

    }
}