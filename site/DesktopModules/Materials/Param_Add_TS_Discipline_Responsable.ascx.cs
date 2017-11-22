using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GlobalAPI;
using DevExpress.Web;
using VD.Modules.VBFramework; 
using VD.Modules.Framework;

namespace VD.Modules.Materials
{
    public partial class Param_Add_TS_Discipline_Responsable : DotNetNuke.Entities.Modules.PortalModuleBase
    {
       
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";



        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "jquery.js", ResolveClientUrl("~/Resources/Shared/scripts/jquery/jquery.js"));
            btnSave.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            btnSave2.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            TranslateUtility.localizeGrid(grdLookEmp, ressFilePath);
            grdLookEmp.Columns["Username"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hMatricule", ressFilePath);
            grdLookEmp.Columns["DisplayName"].Caption = DotNetNuke.Services.Localization.Localization.GetString("tDisplayName", ressFilePath);
            pcAssignments.TabPages[0].Text = DotNetNuke.Services.Localization.Localization.GetString("hByFunction", ressFilePath);
            pcAssignments.TabPages[1].Text = DotNetNuke.Services.Localization.Localization.GetString("hByEmployee", ressFilePath);
            if (!IsPostBack)
            {
                if (HttpContext.Current.Request.QueryString["ActiveTab"] != null)
                {
                    if (HttpContext.Current.Request.QueryString["ActiveTab"].ToString() == "1")
                        pcAssignments.ActiveTabIndex = 1;
                }
            }
        }


        /// <summary>
        /// Handles the Click event of the btnSave control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string discipline ="";
            if (cmbDiscipline.Value != null)
                discipline =  cmbDiscipline.Value.ToString() ;             
            int technicalsoftwareID ;
            int.TryParse(cmbtechnicalSoftware.Value.ToString(), out technicalsoftwareID);

            var lsRoles = grdLookRoles.GetSelectedFieldValues("RoleID");
            foreach (object role in lsRoles)
            {                

                int roleID  = Convert.ToInt32(role.ToString()); 
                SoftwareController.AddTechnicalSoftwareDsciplineResponsable(discipline, technicalsoftwareID, roleID, null, UserId);

            }

             
            popupValidation.ShowOnPageLoad = true;
        }

        /// <summary>
        /// Handles the Click event of the btnSave control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void btnSave2_Click(object sender, EventArgs e)
        {
            string discipline="";
            if(cmbDiscipline2.Value!=null)
                discipline = cmbDiscipline2.Value.ToString();
            int technicalsoftwareID;
            int.TryParse(cmbtechnicalSoftware2.Value.ToString(), out technicalsoftwareID);

            var lsMatricule = grdLookEmp.GetSelectedFieldValues("UserID");
            foreach (object matricule in lsMatricule)
            {
                int empID = Convert.ToInt32(matricule.ToString());
                SoftwareController.AddTechnicalSoftwareDsciplineResponsable(discipline, technicalsoftwareID, null, empID, UserId);
            }

            popupValidation.ShowOnPageLoad = true;
        }

        /// <summary>
        /// Handles the DataBound event of the cmbDiscipline control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <history>
        /// 	<para>[Anis Zouari]	09/10/2015  Created</para>
        /// </history>
        protected void cmbDiscipline_DataBound(object sender, EventArgs e)
        {
            cmbDiscipline.Items.Add(DotNetNuke.Services.Localization.Localization.GetString("lbTous", ressFilePath), "ALL").Index = 0;
            cmbDiscipline.SelectedIndex = 0;
        }

        /// <summary>
        /// Handles the DataBound event of the cmbDiscipline2 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <history>
        /// 	<para>[Anis Zouari]	09/10/2015  Created</para>
        /// </history>
        protected void cmbDiscipline2_DataBound(object sender, EventArgs e)
        {
            cmbDiscipline2.Items.Add(DotNetNuke.Services.Localization.Localization.GetString("lbTous", ressFilePath), "ALL").Index = 0;
            cmbDiscipline2.SelectedIndex = 0;
        }
    }
}