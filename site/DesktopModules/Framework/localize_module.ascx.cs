using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VD.Modules.Framework
{
    public partial class localize_module : System.Web.UI.UserControl
    {
        protected void Page_Init(object sender, System.EventArgs e)
        {
            if (HttpContext.Current.Request.QueryString["lang"] != null  )
            {
                
                string selectedLanguage = HttpContext.Current.Request.QueryString["lang"];
                if ((selectedLanguage != System.Threading.Thread.CurrentThread.CurrentCulture.Name))
                {
                    Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);
                }

            }


        }
        
    }
}