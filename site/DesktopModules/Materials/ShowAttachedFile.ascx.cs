using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Services.Localization;
using GlobalAPI;

namespace VD.Modules.Materials
{
    public partial class ShowAttachedFile : DotNetNuke.Entities.Modules.PortalModuleBase
    {
         
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        
        protected string src = "";
         
        protected int standardId = 0;
         
        protected int caseId = 0;

        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            if (HttpContext.Current.Request.QueryString["source"] != null)
            {
                src = HttpContext.Current.Request.QueryString["source"].ToString();
            }
            if (src == "standard")
            {
                if (HttpContext.Current.Request.QueryString["id"] != null)
                {
                    standardId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);
                    DataLayer.Materials_Norm standard = StandardController.GetNormByID(standardId);
                    if (standard != null)
                    {
                        //Set title
                        lblTitle.Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("lbListStdFileAttachment", ressFilePath), standard.Designation);
                    }
                }
            }
            else if (src == "standardcase")
            {
                if (HttpContext.Current.Request.QueryString["id"] != null)
                {
                    caseId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);
                     DataLayer.Materials_Cases standardCase = StandardController.GetStantardCaseByID(caseId);
                     if (standardCase != null)
                     {
                         //Set title
                         lblTitle.Text = String.Format(DotNetNuke.Services.Localization.Localization.GetString("lbListCaseFileAttachment", ressFilePath).Replace(@"\",""), standardCase.LibCase);
                     }
                }
            }
        }

       
        protected void cbEditMaterials_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            if (e.Parameter == "0")
            {
                string retFiles = "";
                if (HttpContext.Current.Request.QueryString["source"] != null)
                {
                    src = HttpContext.Current.Request.QueryString["source"].ToString();
                }
                if (src == "standard")
                {
                    if (HttpContext.Current.Request.QueryString["id"] != null)
                    {
                        standardId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);
                        //Load std attached file
                        List<DataLayer.Materials_Norm_Attachement_KB> caseAttachments = StandardController.getStandardAttachement_KB(standardId);
                        if (caseAttachments.Count > 0)
                        {
                            int k = 0;
                            while (k < caseAttachments.Count)
                            {
                                string link = caseAttachments[k].Link;
                                string fname = link.Substring(link.LastIndexOf("/") + 1);
                                //string url = "http://" + PortalAlias.HTTPAlias + "/" + link;
                                string url = "/" + link;
                                if (retFiles != "")
                                    retFiles = retFiles + "@@" + fname + "|" + url;
                                else
                                    retFiles = fname + "|" + url;
                                k++;
                            }
                        }
                    }
                }
                else if (src == "standardcase")
                {
                    if (HttpContext.Current.Request.QueryString["id"] != null)
                    {
                        caseId = Convert.ToInt32(HttpContext.Current.Request.QueryString["id"]);
                        //Load case attached file
                        List<DataLayer.Materials_Case_Attachement_KB> caseAttachments = StandardController.Get_Case_Attachement_KB(caseId);
                        if (caseAttachments.Count > 0)
                        {
                            int k = 0;
                            while (k < caseAttachments.Count)
                            {
                                string link = caseAttachments[k].Link;
                                string fname = link.Substring(link.LastIndexOf("/") + 1);
                                //string url = "http://" + PortalAlias.HTTPAlias + "/" + link;
                                string url = "/" + link;
                                if (retFiles != "")
                                    retFiles = retFiles + "@@" + fname + "|" + url;
                                else
                                    retFiles = fname + "|" + url;
                                k++;
                            }
                        }
                    }
                }
                e.Result = retFiles;
            }
        }

    }
}