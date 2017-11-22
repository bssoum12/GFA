using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VD.Modules.Framework;
using DotNetNuke.Entities.Users;
using System.Data.SqlClient;
using DevExpress.Web;
 


namespace VD.Modules.Materials
{
    public partial class Param_MeasureUnitFormula : System.Web.UI.UserControl
    {
         
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
         
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
         
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            TranslateUtility.localizeGrid(grdMeasureUnitFormula , ressFilePath);
            grdMeasureUnitFormula.Columns["ID_UniteMeasure"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hFrom", ressFilePath);
            grdMeasureUnitFormula.Columns["ID_UniteMeasure_To"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hTo", ressFilePath);
            grdMeasureUnitFormula.Columns["Formula"].Caption = DotNetNuke.Services.Localization.Localization.GetString("hFormula", ressFilePath);
            toolbarMenu.Items[0].Text = popupMenu.Items[0].Text  = DotNetNuke.Services.Localization.Localization.GetString("mnFormules", ressFilePath);
            toolbarMenu.Items[0].Items[0].Text = popupMenu.Items[0].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[0].Items[1].Text = popupMenu.Items[0].Items[1].Text = DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);
            toolbarMenu.Items[0].Items[2].Text = popupMenu.Items[0].Items[2].Text =  DotNetNuke.Services.Localization.Localization.GetString("mnDelete", ressFilePath);
            toolbarMenu.Items[1].Text = popupMenu.Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnMeasureUnits", ressFilePath);
            toolbarMenu.Items[1].Items[0].Text = popupMenu.Items[0].Items[0].Text = DotNetNuke.Services.Localization.Localization.GetString("mnAdd", ressFilePath);
            toolbarMenu.Items[1].Items[1].Text = popupMenu.Items[1].Items[1].Text =  DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath);            
        }

        
        protected void SqlMeasureUnitFormula_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            SqlParameter a = new SqlParameter();
            a.ParameterName = "LastModifiedByUserID";
            a.Value = CurrentUser.Username;
            e.Command.Parameters.Add(a);            
        }

         
        protected void SqlMeasureUnitFormula_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            SqlParameter a = new SqlParameter();
            a.ParameterName = "LastModifiedByUserID";
            a.Value = CurrentUser.Username;
            e.Command.Parameters.Add(a);       
        }
    }
}