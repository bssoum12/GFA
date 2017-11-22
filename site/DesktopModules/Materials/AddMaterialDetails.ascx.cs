using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using DotNetNuke.Entities.Users;
using GlobalAPI;
using VD.Modules.VBFramework; 
using DotNetNuke.Services.Localization;


namespace VD.Modules.Materials
{
    /// <summary>
    /// This class represents code file of the editing material knowledge base UI (AddMaterialDetails)
    /// </summary>
    public partial class AddMaterialDetails : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        /// <summary>
        /// The ressource file path
        /// </summary>
        protected string ressFilePath = "~/DesktopModules/Materials/App_LocalResources/View.ascx.resx";
        /// <summary>
        /// The transfert fichier path
        /// </summary>
        protected string TransfertFichierPath = System.Web.Configuration.WebConfigurationManager.AppSettings["TransfertFichierPath"].ToString();
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cmdValider.Text = DotNetNuke.Services.Localization.Localization.GetString("lbValidate", ressFilePath);
                if (HttpContext.Current.Request.QueryString["MaterialId"] != null)
                {
                    string matId = HttpContext.Current.Request.QueryString["MaterialId"].ToString();
                    DataLayer.Materials_Materials material = MaterialsController.getMaterialByID(Int32.Parse(matId));
                    DataLayer.Materials_KB materialsKB = MaterialsController.getMaterialsDetails(Int32.Parse(matId));
                    if (materialsKB != null)
                    {
                        var languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0);
                        foreach (var langObj in languages)
                        {
                            if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                            {
                                var ret = MaterialsController.getLocalizedMaterialsDetails(langObj.Key, materialsKB.ID);
                                if (ret != null)
                                {
                                    htmlAddComment.SetHtmlFieldValueByLocale(langObj.Key, ret.Article);
                                    if (!string.IsNullOrEmpty(ret.Title))
                                        txtTitle.SetTextFieldValueByLocale(langObj.Key, ret.Title);
                                    else                                    
                                        txtTitle.SetTextFieldValueByLocale(langObj.Key, material.Code);
                                    
                                }
                            }
                            else
                            {
                                htmlAddComment.SetHtmlFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code, materialsKB.Article);
                                if (!string.IsNullOrEmpty(materialsKB.Title))
                                    txtTitle.SetTextFieldValueByLocale(langObj.Key, materialsKB.Title);
                                else
                                {
                                    txtTitle.SetTextFieldValueByLocale(langObj.Key, material.Code);
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
            string defaultLanguageValue = this.htmlAddComment.GetHtmlFieldValueByLocale(LocaleController.Instance.GetDefaultLocale(0).Code);
            if (defaultLanguageValue != "")
            {
                //Insert default language value
                int ret = MaterialsController.AddMaterialsKB(
                    Int32.Parse(HttpContext.Current.Request.QueryString["MaterialId"]),
                    defaultLanguageValue,
                    GlobalAPI.CommunUtility.GetCurrentUserInfo().UserID);
                if (ret != -1)
                {
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            MaterialsController.AddLocalizedMaterialsKB(ret,
                                this.htmlAddComment.GetHtmlFieldValueByLocale(langObj.Key),
                                langObj.Key);
                        }
                    }
                }
            }
            else
            {
                defaultLanguageValue = this.htmlAddComment.GetHtmlFieldValueByLocale(System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                int ret = MaterialsController.AddMaterialsKB(
                    Int32.Parse(HttpContext.Current.Request.QueryString["MaterialId"]),
                    defaultLanguageValue,
                    GlobalAPI.CommunUtility.GetCurrentUserInfo().UserID);
                if (ret != -1)
                {
                    foreach (var langObj in languages)
                    {
                        if (langObj.Key != LocaleController.Instance.GetDefaultLocale(0).Code)
                        {
                            MaterialsController.AddLocalizedMaterialsKB(ret,
                                this.htmlAddComment.GetHtmlFieldValueByLocale(langObj.Key),
                                langObj.Key);
                        }
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
                if (HttpContext.Current.Request.QueryString["MaterialId"] != null)
                {
                    //Format attachment title
                    string title = uploadedFile.FileName;
                    if (uploadedFile.FileName.Contains("."))
                    {
                        string fname = "";
                        if (uploadedFile.IsValid)
                        {
                            fname = DecodeNameFile(uploadedFile.FileName.ToString());
                            //Create Material docs folder
                            string path = TransfertFichierPath + @"\E255\KB\" + HttpContext.Current.Request.QueryString["MaterialId"].ToString();
                            if (!Directory.Exists(path))
                                Directory.CreateDirectory(path);
                            //Save file to material docs folder
                            uploadedFile.SaveAs(path + @"\" + fname);
                            //Return file infos
                            string file = string.Format("{0} ({1}KB)", fname, uploadedFile.ContentLength / 1024);
                            string url = "http://" + PortalAlias.HTTPAlias + "/E255/KB/" + HttpContext.Current.Request.QueryString["MaterialId"].ToString() + "/" + fname;
                            return file + "|" + url;
                        }
                    }
                }
            }
            catch (Exception)
            {}
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
                if (HttpContext.Current.Request.QueryString["MaterialId"] != null)
                {
                    string matId = HttpContext.Current.Request.QueryString["MaterialId"].ToString();
                    List<DataLayer.Materials_Attachments> materialsAttachments = MaterialsController.getMaterialsAttachments(Int32.Parse(matId));
                    if (materialsAttachments.Count > 0)
                    {
                        int k = 0;
                        while (k < materialsAttachments.Count)
                        {
                            string link = materialsAttachments[k].Link;
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
            else
            {
                if (e.Parameter != "")
                {
                    string[] filesData = e.Parameter.Split(new string[] { "@@" }, StringSplitOptions.None);
                    MaterialsController.deleteObseleteMaterialsAttachments(Int32.Parse(HttpContext.Current.Request.QueryString["MaterialId"]), filesData);
                    int h = 0;
                    while (h < filesData.Length)
                    {
                        string fpath = filesData[h];
                        fpath = fpath.Substring(fpath.IndexOf("/") + 2);
                        fpath = fpath.Substring(fpath.IndexOf("/") + 1);
                        MaterialsController.AddMaterialsAttachment(Int32.Parse(HttpContext.Current.Request.QueryString["MaterialId"]), fpath, GlobalAPI.CommunUtility.GetCurrentUserInfo().UserID);
                        h++;
                    }
                }
                else
                    MaterialsController.deleteObseleteMaterialsAttachments(Int32.Parse(HttpContext.Current.Request.QueryString["MaterialId"]), null);
            }
        }
    }
}
