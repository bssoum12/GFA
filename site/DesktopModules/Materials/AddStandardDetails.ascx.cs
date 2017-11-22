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
    /// <summary>
    /// This class represents code file of the editing standard knowledge base UI (AddStandardDetails)
    /// </summary>
    public partial class AddStandardDetails : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        /// <summary>
        /// The current user
        /// </summary>
        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();         
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";         
        protected string TransfertFichierPath = System.Web.Configuration.WebConfigurationManager.AppSettings["TransfertFichierPath"].ToString();
         
        protected void Page_Load(object sender, EventArgs e)
        {
            btnCancel.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            cmdValider.Text = DotNetNuke.Services.Localization.Localization.GetString("lbSave", ressFilePath);
            Session["Locale"] = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            lblRacine.Text = DotNetNuke.Services.Localization.Localization.GetString("lblRootStandard", ressFilePath);
            if (!IsPostBack)
            {
                if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                    bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]);
                    if (!ControlStatus)
                    {
                        string stdId = HttpContext.Current.Request.QueryString["stdId"].ToString();
                        DataLayer.Materials_Norm standard = StandardController.GetNormByID(Int32.Parse(stdId));

                        if (standard != null)
                        {
                            var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                            foreach (var langObj in languages)
                            {
                                if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                                {
                                    var ret = StandardController.GetNormML(standard.ID, langObj.Key);
                                    if (ret != null)
                                    {
                                        htmlAddComment.SetHtmlFieldValueByLocale(langObj.Key, ret.DescriptionHTML);
                                        if (!string.IsNullOrEmpty(ret.Designation))
                                            txtTitle.SetTextFieldValueByLocale(langObj.Key, ret.Designation);
                                        else
                                        {
                                            txtTitle.SetTextFieldValueByLocale(langObj.Key, standard.Designation);                                        }
                                    }
                                }
                                else
                                {
                                    htmlAddComment.SetHtmlFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, standard.DescriptionHTML);
                                    if (!string.IsNullOrEmpty(standard.Designation))
                                        txtTitle.SetTextFieldValueByLocale(langObj.Key, standard.Designation);
                                }
                            }
                        }
                    } 
                }

                if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                    if (HttpContext.Current.Request.QueryString["stdId"].ToString() != null)
                    {
                        string stdId = HttpContext.Current.Request.QueryString["stdId"].ToString();
                        bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]);
                        if (ControlStatus)
                        {
                            DataLayer.Materials_Norm norm = StandardController.GetNormByID(Convert.ToInt32(stdId));
                            ddeParentStd.Text = norm.Designation;
                        }
                        else
                        {
                            ASPxTreeList tlNorm = ddeParentStd.FindControl("tlNorm") as ASPxTreeList;
                            tlNorm.DataBind();
                            if (tlNorm.FindNodeByKeyValue(stdId).ParentNode.Key != "")
                            {
                                DataLayer.Materials_Norm norm = StandardController.GetNormByID(Convert.ToInt32(tlNorm.FindNodeByKeyValue(stdId).ParentNode.Key));
                                ddeParentStd.Text = norm.Designation;
                                chkIsParent.Checked = false;
                                ddeParentStd.ClientVisible = true;
                            }
                            else
                            {
                                chkIsParent.Checked = true;
                                ddeParentStd.ClientVisible = false;
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
            //Get stadard name
            string defaultLanguageValue = this.txtTitle.GetTextFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            if (defaultLanguageValue != "")
            {
                defaultLanguageValue = this.txtTitle.GetTextFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            }
            //Get standard description
            string defaultLanguageHTMLValue = this.htmlAddComment.GetHtmlFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            if (defaultLanguageHTMLValue != "")
            {
                defaultLanguageHTMLValue = this.htmlAddComment.GetHtmlFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
            }
            //Insert default language value
            int IdStd = -2;
            ASPxTreeList tlNorm = ddeParentStd.FindControl("tlNorm") as ASPxTreeList;
            string parentID = chkIsParent.Checked ? null : tlNorm.FocusedNode.Key;
            int ret = -2;
            if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
            {
                bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]);
                if (ControlStatus)
                {
                    ret = StandardController.SetStandard(
                                parentID,
                                defaultLanguageValue,
                                defaultLanguageHTMLValue
                                );
                }
                else
                {
                    ret = StandardController.UpdateStandard(
                            Convert.ToInt32(HttpContext.Current.Request.QueryString["stdId"].ToString()),
                            parentID,
                            defaultLanguageValue,
                            defaultLanguageHTMLValue
                            ); 
                }
            }
            if (ret != -2)
            {
                if (ret != -1)
                {
                    IdStd = ret;
                }
                foreach (var langObj in languages)
                {
                    if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                    {
                        StandardController.SetLocalizedStandard(IdStd,
                            this.txtTitle.GetTextFieldValueByLocale(langObj.Key),
                            this.htmlAddComment.GetHtmlFieldValueByLocale(langObj.Key),
                            langObj.Key);
                    }
                }
            }
            //manage standard attachements
                if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                    bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]);
                    if (ControlStatus)
                    {
                        if (IdStd != -2)
                        {
                            //lire les fichier du dossier temp
                            if (Session["tempPath"] != null)
                            {
                                string path = TransfertFichierPath + @"\E255\KB\_standards\" + Session["tempPath"].ToString().Replace("/", @"\");
                                System.IO.DirectoryInfo temp = new System.IO.DirectoryInfo(path);
                                foreach (FileInfo file in temp.GetFiles())
                                {
                                    string newPath = TransfertFichierPath + @"\E255\KB\_standards\" + IdStd;
                                    if (!Directory.Exists(newPath))
                                        Directory.CreateDirectory(newPath);
                                    file.MoveTo(newPath + @"\" + file.Name);
                                    StandardController.SetStandardKB(IdStd, "E255/KB/_standards/" + IdStd + "/" + file.Name, CurrentUser.UserID);
                                }
                                //Delete the temp folder
                                temp.Delete(true);
                            }
                        }
                    }
                    else
                    {
                        //Delete standard attachement from the db table
                        StandardController.deleteObseleteStandardAttachments(IdStd);
                        //lire les fichiers du dossier idStandard 
                        string path = TransfertFichierPath + @"\E255\KB\_standards\" + IdStd;
                        System.IO.DirectoryInfo stdAttachFolder = new System.IO.DirectoryInfo(path);
                        if (stdAttachFolder.Exists)
                        {
                            foreach (FileInfo file in stdAttachFolder.GetFiles())
                            {
                                string filePath = TransfertFichierPath + @"\E255\KB\_standards\" + IdStd + @"\" + file.Name;
                                StandardController.SetStandardKB(IdStd, "E255/KB/_standards/" + IdStd + @"/" + file.Name, CurrentUser.UserID);
                            }
                        }
                        
                        if (Session["tempPath"] != null)
                        {
                            string tpath = TransfertFichierPath + @"\E255\KB\_standards\" + Session["tempPath"].ToString().Replace("/", @"\");
                            System.IO.DirectoryInfo temp = new System.IO.DirectoryInfo(tpath);
                            try
                            {
                                //Delete the temp\Session["tempPath"] folder if exist
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
                if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                    if (Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]))
                    {
                        if (Session["tempPath"] == null)
                        {
                            Session["tempPath"] = "temp/" + Guid.NewGuid().ToString();
                        }
                    }
                    else
                    {
                        if (Session["tempPath"] == null)
                        {
                             Session["tempPath"] = HttpContext.Current.Request.QueryString["stdId"].ToString();
                        }
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
                            string path = TransfertFichierPath + @"\E255\KB\_standards\" + Session["tempPath"].ToString().Replace("/",@"\");
                            if (!Directory.Exists(path))
                                Directory.CreateDirectory(path);
                            //Save file to material docs folder
                            uploadedFile.SaveAs(path + @"\" + fname);
                            //Return file infos
                            string file = string.Format("{0} ({1}KB)", fname, uploadedFile.ContentLength / 1024);
                            string url = "http://" + PortalAlias.HTTPAlias + "/E255/KB/_standards/" + Session["tempPath"].ToString() +"/" + fname;
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
                if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                    bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]);
                    if (!ControlStatus)
                    {
                        if (HttpContext.Current.Request.QueryString["stdId"] != null)
                        {
                            string stdId = HttpContext.Current.Request.QueryString["stdId"].ToString();
                            List<DataLayer.Materials_Norm_Attachement_KB> standardAttachments = StandardController.getStandardAttachement_KB(Int32.Parse(stdId));
                            if (standardAttachments.Count > 0)
                            {
                                int k = 0;
                                while (k < standardAttachments.Count)
                                {
                                    string link = standardAttachments[k].Link;
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
                }
            }
            else if (e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[0] == "deleteFile")
	        {
                if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                    string path ="";
                    if (Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]))
                    {
                        path = TransfertFichierPath + @"\E255\KB\_standards\" + Session["tempPath"].ToString().Replace("/",@"\") + @"\" + e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[1];
                        
                    }
                    else
                    {
                        path = TransfertFichierPath + @"\E255\KB\_standards\" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) + @"\" + e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[1];
                        string dbFileURL = "E255/KB/_standards/" + Convert.ToString(HttpContext.Current.Request.QueryString["stdId"]) + "/" + e.Parameter.Split(new string[] { "_" }, StringSplitOptions.None)[1];
                        StandardController.DeleteStandardAttachementByIdStd(Convert.ToInt32(HttpContext.Current.Request.QueryString["stdId"]), dbFileURL);
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
                    StandardController.deleteObseleteStandardAttachments(Int32.Parse(HttpContext.Current.Request.QueryString["stdId"]));
            }
        }

        /// <summary>
        /// Handles the DataBound event of the tlNorm control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <history>
        ///   <para>[Fahd.Belaid] 28/03/2013 Created</para>
        /// </history>
        protected void tlNorm_DataBound(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.QueryString["IsNewNorm"] != null)
                {
                bool ControlStatus = Convert.ToBoolean(HttpContext.Current.Request.QueryString["IsNewNorm"]);
                if (ControlStatus)
                {
                    ASPxTreeList tlNorm = sender as ASPxTreeList;
                    string stdId = HttpContext.Current.Request.QueryString["stdId"].ToString();
                    tlNorm.FindNodeByKeyValue(stdId).Focus();
                }
                else
                {
                    ASPxTreeList tlNorm = sender as ASPxTreeList;
                    string stdId = HttpContext.Current.Request.QueryString["stdId"].ToString();
                    if ( tlNorm.FindNodeByKeyValue(stdId).ParentNode.Key  != "")
                    {
                        tlNorm.FindNodeByKeyValue(stdId).ParentNode.Focus();   
                    }
                }
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
                        string tpath = TransfertFichierPath + @"\E255\KB\_cases\" + Session["tempPath"].ToString().Replace("/", @"\");
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
