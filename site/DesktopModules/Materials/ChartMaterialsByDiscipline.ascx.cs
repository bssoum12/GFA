using System;

namespace VD.Modules.Materials
{
    /// <summary>
    /// This class represents code file for the control displaying the chart materials by disciplines
    /// </summary>
    public partial class ChartMaterialsByDiscipline : System.Web.UI.UserControl
    {
        /// <summary>
        /// The ressource file path
        /// </summary>
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            chartMaterialByDiscipline.Titles[0].Text = DotNetNuke.Services.Localization.Localization.GetString("chartMaterialsByDiscipline", ressFilePath);
        }
    }
}