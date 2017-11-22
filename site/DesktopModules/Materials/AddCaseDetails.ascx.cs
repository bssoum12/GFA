using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using DotNetNuke.Entities.Users;
using GlobalAPI;
using VD.Modules.VBFramework;
using DotNetNuke.Services.Localization;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web;

namespace VD.Modules.Materials
{ 
    public partial class AddCaseDetails : DotNetNuke.Entities.Modules.PortalModuleBase
    {
         
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();
 
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";

       
        protected string TransfertFichierPath = System.Web.Configuration.WebConfigurationManager.AppSettings["TransfertFichierPath"].ToString();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = DotNetNuke.Services.Localization.Localization.GetString("mnuCases", ressFilePath).Replace(@"\", "");
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            cmdValider.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            if (!IsPostBack)
            {
                Session["tempPath"] = null;
                if (HttpContext.Current.Request.QueryString["IsNewCase"] != null)
                {
                    if (HttpContext.Current.Request.QueryString["stdId"].ToString() != null)
                    {
                        string stdId = HttpContext.Current.Request.QueryString["stdId"].ToString();
                        DataLayer.Materials_Norm standard =StandardController.GetNormByID(Int32.Parse(stdId));
                        if (standard != null)
                        {
                            lblStandard.Text = standard.Designation;
                        }
                    }
                    bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewCase"]);
                    if (!ControlStatus)
                    {
                        if (HttpContext.Current.Request.QueryString["idCase"].ToString() != null)
                        {
                            int caseId = Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"].ToString());
                            DataLayer.Materials_Cases standardCase = StandardController.GetStantardCaseByID(caseId);
                            if (standardCase != null)
                            {
                                var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                                foreach (var langObj in languages)
                                {
                                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                                    {
                                        var ret = StandardController.GetStantardCaseMLByLocale(standardCase.ID, langObj.Key);
                                        if (ret != null)
                                        {
                                            htmlAddComment.SetHtmlFieldValueByLocale(langObj.Key, ret.DescriptionHTML);
                                            if (!string.IsNullOrEmpty(ret.LibCase))
                                                txtTitle.SetTextFieldValueByLocale(langObj.Key, ret.LibCase);
                                            else
                                            {
                                                txtTitle.SetTextFieldValueByLocale(langObj.Key, standardCase.LibCase);
                                            }
                                        }
                                    }
                                    else
                                    {
                                        htmlAddComment.SetHtmlFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, standardCase.DescriptionHTML);
                                        if (!string.IsNullOrEmpty(standardCase.LibCase))
                                            txtTitle.SetTextFieldValueByLocale(langObj.Key, standardCase.LibCase);
                                    }
                                }   
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdValider control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void cmdValider_Click(object sender, EventArgs e)
        {
            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
            //Get stadard case name
            string defaultLanguageValue = this.txtTitle.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            if (defaultLanguageValue == "")
            {
                defaultLanguageValue = this.txtTitle.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            }
            //Get standard case description
            string defaultLanguageHTMLValue = this.htmlAddComment.GetHtmlFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            if (defaultLanguageHTMLValue == "")
            {
                defaultLanguageHTMLValue = this.htmlAddComment.GetHtmlFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            }
            int ret = -1;
            if (Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewCase"]))
            {
                //Insert default language value
                ret = StandardController.SetStandardCases(
                defaultLanguageValue,
                defaultLanguageHTMLValue
                );
                if (ret != -1)
                {
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            string MultiLanguageValue = this.txtTitle.GetTextFieldValueByLocale(langObj.Key);
                            string MultiLanguageHTMLValue = this.htmlAddComment.GetTextFieldValueByLocale(langObj.Key);
                            StandardController.SetStandardCasesML(ret,
                                                            langObj.Key,
                                                            MultiLanguageValue,
                                                            MultiLanguageHTMLValue);
                        }
                    }
                    //Set case to standard
                    StandardController.SetStandardCase(Convert.ToInt32(HttpContext.Current.Request.QueryString["stdId"]), ret);
                }
            }
            else
            {
                //update default language value
                ;
                if (!StandardController.UpdateCase(
                Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]),
                defaultLanguageValue,
                defaultLanguageHTMLValue
                ))
                {
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            string MultiLanguageValue = this.txtTitle.GetTextFieldValueByLocale(langObj.Key);
                            string MultiLanguageHTMLValue = this.htmlAddComment.GetTextFieldValueByLocale(langObj.Key);
                            StandardController.UpdateCaseML(Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]),
                                                            MultiLanguageValue,
                                                            MultiLanguageHTMLValue,
                                                            langObj.Key
                                                            );
                        }
                    }
                }
            }
            //manage standard attachements
                if (HttpContext.Current.Request.QueryString["IsNewCase"] != null)
                {
                    bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewCase"]);
                    if (ControlStatus)
                    {
                        if (ret != -1)
                        {
                            //lire les fichier du dossier temp
                            if (Session["tempPath"] != null)
                            {
                                string path = TransfertFichierPath + @"\KB\_cases\" + Session["tempPath"].ToString().Replace("/", @"\");
                                System.IO.DirectoryInfo temp = new System.IO.DirectoryInfo(path);
                                foreach (FileInfo file in temp.GetFiles())
                                {
                                    string newPath = TransfertFichierPath + @"\KB\_cases\" 
                                        + @"\" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) 
                                        + @"\" + ret;
                                    if (!Directory.Exists(newPath))
                                        Directory.CreateDirectory(newPath);
                                    file.MoveTo(newPath + @"\" + file.Name);
                                    StandardController.AddCaseAttachment(ret, "KB/_cases/" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) + "/"
                                        + ret + "/" + file.Name, CurrentUser.UserID);
                                }
                                try
                                {
                                    //Delete the temp\Session["tempPath"] folder if exist
                                    temp.Delete(true);
                                }
                                catch (Exception)
                                { }  
                            }
                        }
                    }
                    else
                    {
                        //Delete standard attachement from the db table
                        StandardController.deleteObseleteCaseAttachments(Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]));
                        //lire les fichiers du dossier idStandard 
                        string path = TransfertFichierPath + @"\KB\_cases\" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) + @"\" + Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]);
                        System.IO.DirectoryInfo caseAttachFolder = new System.IO.DirectoryInfo(path);
                        if (caseAttachFolder.Exists)
                        {
                            foreach (FileInfo file in caseAttachFolder.GetFiles())
                            {
                                string filePath = TransfertFichierPath + @"\KB\_cases\"
                                    + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) + @"\" + Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]) + @"\" + file.Name;
                                StandardController.AddCaseAttachment(
                                    Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]),
                                    "KB/_cases/" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) + "/" + Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]) + "/" + file.Name,
                                    CurrentUser.UserID
                                    );
                            }
                        }
                        //lire les fichier du dossier temp
                        if (Session["tempPath"] != null)
                        {
                            string tpath = TransfertFichierPath + @"\KB\_cases\" + Session["tempPath"].ToString().Replace("/", @"\");
                            System.IO.DirectoryInfo temp = new System.IO.DirectoryInfo(tpath);
                            try
                            {
                                //Delete the temp folder
                                temp.Delete(true);
                            }
                            catch (Exception)
                            {}
                           
                        }
                    }
                }
                popupValidation.ShowOnPageLoad = true;
        }

        /// <summary>
        /// Saves the posted files.
        /// </summary>
        /// <param name="uploadedFile">The uploaded file.</param>
        /// <returns>Uploaded file parameters (Size and path) as String</returns>
        protected string SavePostedFiles(DevExpress.Web.UploadedFile uploadedFile)
        {
            try
            {
                if (HttpContext.Current.Request.QueryString["IsNewCase"] != null)
                {
                    if (Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewCase"]))
                    {
                        Session["tempPath"] = "temp/" + Guid.NewGuid().ToString(); 
                    }
                    else
                    {
                        Session["tempPath"] = HttpContext.Current.Request.QueryString["stdId"].ToString() + 
                            "/" + HttpContext.Current.Request.QueryString["idCase"].ToString();
                    }
                    //Format attachment title
                    string title = uploadedFile.FileName;
                    if (uploadedFile.FileName.Contains("."))
                    {
                        string fname = "";
                        if (uploadedFile.IsValid)
                        {
                            fname = DecodeNameFile(uploadedFile.FileName.ToString());
                            //Create Material docs folder
                            string path = TransfertFichierPath + @"\KB\_cases\" + Session["tempPath"].ToString().Replace("/", @"\");
                            if (!Directory.Exists(path))
                                Directory.CreateDirectory(path);
                            //Save file to material docs folder
                            uploadedFile.SaveAs(path + @"\" + fname);
                            //Return file infos
                            string file = string.Format("{0} ({1}KB)", fname, uploadedFile.ContentLength / 1024);
                            string url = "http://" + PortalAlias.HTTPAlias + "/KB/_cases/" + Session["tempPath"].ToString() + "/" + fname;
                            return file + "|" + url;
                        }
                    }
                }
            }
            catch (Exception)
            { }
            return "";
        }

        /// <summary>
        /// Decodes the name file.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <returns>Decoded file name as String</returns>
        protected string DecodeNameFile(string fileName)
        {
            string ret = null;
            ret = fileName.Replace("'", "");
            ret = ret.Replace(" ", "");
            ret = ret.Replace("&", "");
            ret = ret.Replace("\\", "");
            ret = ret.Replace("?", "");
            ret = ret.Replace(";", "");
            ret = ret.Replace(":", "");
            ret = ret.Replace("@", "");
            ret = ret.Replace("=", "");
            ret = ret.Replace("+", "");
            ret = ret.Replace("$", "");
            ret = ret.Replace(",", "");
            ret = ret.Replace("|", "");
            ret = ret.Replace("\"", "");
            ret = ret.Replace("<", "");
            ret = ret.Replace(">", "");
            ret = ret.Replace("*", "");
            ret = ret.Replace("#", "");
            return ret;
        }

        /// <summary>
        /// Handles the FileUploadComplete event of the uplFile control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.FileUploadCompleteEventArgs"/> instance containing the event data.</param>
        protected void uplFile_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            try
            {
                e.CallbackData = SavePostedFiles(e.UploadedFile);
            }
            catch (Exception ex)
            {
                e.IsValid = false;
                e.ErrorText = ex.Message;
            }
        }

        /// <summary>
        /// Handles the Callback event of the cbEditMaterials control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="DevExpress.Web.CallbackEventArgs"/> instance containing the event data.</param>
        protected void cbEditMaterials_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            if (e.Parameter == "0")
            {
                string retFiles = "";
                if (HttpContext.Current.Request.QueryString["idCase"] != null)
                {
                    string idCase = HttpContext.Current.Request.QueryString["idCase"].ToString();
                    List<DataLayer.Materials_Case_Attachement_KB> caseAttachments = StandardController.Get_Case_Attachement_KB(Int32.Parse(idCase));
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
                e.Result = retFiles;
            }
            else if (e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[0] == "deleteFile")
            {
                if (HttpContext.Current.Request.QueryString["IsNewCase"] != null)
                {
                    string path = "";
                    if (Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewCase"]))
                    {
                        path = TransfertFichierPath + @"\KB\_cases\" + Session["tempPath"].ToString().Replace("/", @"\") + @"\" + e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[1];

                    }
                    else
                    {
                        path = TransfertFichierPath + @"\KB\_cases\" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) 
                            + @"\" + Convert.ToString(HttpContext.Current.Request.QueryString["idCase"])
                            + @"\" + e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[1];
                        string dbFileURL = "KB/_standards/" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"])
                            + "/" + Convert.ToString(HttpContext.Current.Request.QueryString["idCase"])
                            + "/" + e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[1];
                        StandardController.DeleteCaseAttachementByIdStd(Convert.ToInt32(HttpContext.Current.Request.QueryString["idCase"]), dbFileURL);
                    }
                    System.IO.FileInfo toDelete = new System.IO.FileInfo(path);
                    toDelete.Delete();
                }
            }
            else
            {
                if (e.Parameter != "")
                {
                    ////Set standard attachement
                    //string[] filesData = e.Parameter.Split(new string[] { "@@" }, StringSplitOptions.None);
                    //MaterialsUtility.deleteObseleteStandardAttachments(IdStd, filesData);
                    //int h = 0;
                    //while (h < filesData.Length)
                    //{
                    //    string fpath = filesData[h];
                    //    fpath = fpath.Substring(fpath.IndexOf("/") + 2);
                    //    fpath = fpath.Substring(fpath.IndexOf("/") + 1);
                    //    MaterialsUtility.AddStandardAttachment(IdStd, fpath, GlobalAPI.CommunUtility.GetCurrentUserInfo().UserID);
                    //    h++;
                    //}
                }
                else
                    StandardController.deleteObseleteCaseAttachments(Int32.Parse(HttpContext.Current.Request.QueryString["idCase"]));
            }
        }

        /// <summary>
        /// Handles the Click event of the btnCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <history>
        ///   <para>[Fahd.Belaid] 16/04/2013 Created</para>
        /// </history>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.QueryString["IsNewCase"] != null)
            {
                if (Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewCase"]))
                {
                    if (Session["tempPath"] != null)
                    {
                        string tpath = TransfertFichierPath + @"\KB\_cases\" + Session["tempPath"].ToString().Replace("/", @"\");
                        System.IO.DirectoryInfo temp = new System.IO.DirectoryInfo(tpath);
                        try
                        {
                            //Delete the temp folder
                            temp.Delete(true);
                        }
                        catch (Exception)
                        { }
                    }
                }
            }
        }

    }
}
