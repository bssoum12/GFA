using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VD.Modules.Materials
{
    public partial class LoadControl : System.Web.UI.Page
    {
        #region " Page Events "
        protected void Page_Init(object sender, System.EventArgs e)
        {
            try
            {
                //Load Control From Query String
                if (HttpContext.Current.Request.QueryString["ctrl"] != null)
                {
                    string ctrlName = HttpContext.Current.Request.QueryString["ctrl"];
                    Control ctrlToLoad = this.LoadControl(ResolveUrl("~/DesktopModules/" + ctrlName));
                    plhDetails.Controls.Add(ctrlToLoad);
                }
            }
            catch (Exception)
            {
            }
        }
        #endregion

        public LoadControl()
        {
            Init += Page_Init;
        }
    }
}