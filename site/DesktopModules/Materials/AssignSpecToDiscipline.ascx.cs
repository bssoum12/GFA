using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DotNetNuke.Entities.Users;
using VD.Modules.Framework;
using VD.Modules.VBFramework;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class AssignSpecToDiscipline : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        //Declaration variables
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        public UserInfo Utili = GlobalAPI.CommunUtility.GetCurrentUserInfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Traduction UI
            tlMatSpecToDiscipline.Columns["Designation"].Caption = DotNetNuke.Services.Localization.Localization.GetString("Designation", ressFilePath);
            lblDisciplineUI.Text = DotNetNuke.Services.Localization.Localization.GetString("lbDisciplineUI", ressFilePath);
            btnClose.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            btnApply.Text = DotNetNuke.Services.Localization.Localization.GetString("lbApply", ressFilePath);
            btnCloseWin.Text = DotNetNuke.Services.Localization.Localization.GetString("btnClosePop", ressFilePath);
            pupAlert.HeaderText = DotNetNuke.Services.Localization.Localization.GetString("pupAlertHeader", ressFilePath);
            btnFilter.Text = DotNetNuke.Services.Localization.Localization.GetString("lbBtnFilter", ressFilePath);
            Session["lang"] = Request.QueryString["lang"];
        }

        protected void tlMatSpecToDiscipline_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            // Désélectionner tous les noeuds
            tlMatSpecToDiscipline.UnselectAll();
            try
            {
                //Recuperer les spec affectée sur la discipline en cours
                List<int> listIDMatSpec_Discipline = SpecificationController.GetIDMatSpecByDiscipline(e.Argument.ToString());
                //Sélectionner les noeuds dans la treeList
                foreach (int idSpec in listIDMatSpec_Discipline)
                {
                    tlMatSpecToDiscipline.FindNodeByKeyValue(idSpec.ToString()).Selected = true;
                }
            }
            catch (Exception)
            {

            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            try
            {
                System.Web.UI.Control ctrl =  GlobalAPI.CommunUtility.FindControlRecursive(this.FindControl("tokenId"), "lbtokeninputvalue");
                DevExpress.Web.ASPxListBox lbtokeninputvalue = (DevExpress.Web.ASPxListBox)ctrl;

                if (lbtokeninputvalue.Items[0].Value.ToString() != null)
                {

                    tlMatSpecToDiscipline.CollapseAll();

                    string specID = lbtokeninputvalue.Items[0].Value.ToString().Split(new string[] { "-" }, StringSplitOptions.None)[1].ToString();

                    DevExpress.Web.ASPxTreeList.TreeListNode node = tlMatSpecToDiscipline.FindNodeByKeyValue(specID);
                    while (node.ParentNode.Key != "")
                    {
                        node = node.ParentNode;
                    }
                    TreeListNodeIterator iterator = tlMatSpecToDiscipline.CreateNodeIterator(node);
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

        protected void callback_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (cmbDiscipline.Value == null)
            {
                //Si aucune discipline n'est selectionnée avertir l'utilisateur et annuler l'action
                hiddenField.Set("lblAlertMsg", DotNetNuke.Services.Localization.Localization.GetString("lbCmbDisciplineErr", ressFilePath));
                return;
            }
            else
            {
                //Recuperer les spec affectée sur la discipline en cours
                List<int> listIDMatSpec_Discipline = SpecificationController.GetIDMatSpecByDiscipline(cmbDiscipline.Value.ToString());

                //Supprimer un par un les spec affectée sur la discipline
                foreach (int idSpec in listIDMatSpec_Discipline)
                {
                    string result = SpecificationController.DeleteMatSpec_Discipline(cmbDiscipline.Value.ToString(), idSpec);
                    if (result != "ok")
                    {
                        GlobalAPI.CommunUtility.logEvent("Error delete spec : " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles);
                    }
                }



                //Inserer de nouveau les spec selectionnée à partir de la treeList
                foreach (var item in tlMatSpecToDiscipline.GetSelectedNodes())
                {
                    try
                    {
                        string result = SpecificationController.AssignMatSpecToDiscipline(cmbDiscipline.Value.ToString(), int.Parse(item.Key.ToString()), Utili.UserID);
                        if (result != "ok")
                        {
                            GlobalAPI.CommunUtility.logEvent("Error assign spec to discipline : " + result, GlobalAPI.CommunUtility.LogTypeEnum.Error, Utili.UserID, GlobalAPI.CommunUtility.LogSourceEnum.Articles);
                        }
                    }
                    catch (Exception)
                    {

                    }
                }
                //Avertir l'utilisateur si succes
                hiddenField.Set("lblAlertMsg", DotNetNuke.Services.Localization.Localization.GetString("lbMSAssignSuccess", ressFilePath));
            }
        }


    }
}