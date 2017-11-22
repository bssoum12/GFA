using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.VisualBasic;

namespace VD.Modules.Framework
{
    
    public sealed class TranslateUtility
    {

        private TranslateUtility()
        {
        }

        public static void localizeGrid(DevExpress.Web.ASPxGridView gvwCtrl, string ressFilePath)
        {
            gvwCtrl.SettingsText.CommandCancel = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdCancel", ressFilePath);
            gvwCtrl.SettingsText.CommandClearFilter = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdClearFilter", ressFilePath);
            gvwCtrl.SettingsText.CommandDelete = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdDelete", ressFilePath);
            gvwCtrl.SettingsText.CommandEdit = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdEdit", ressFilePath);
            gvwCtrl.SettingsText.CommandNew = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdNew", ressFilePath);
            gvwCtrl.SettingsText.CommandSelect = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdSelect", ressFilePath);
            gvwCtrl.SettingsText.CommandUpdate = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdUpdate", ressFilePath);
            gvwCtrl.SettingsText.ConfirmDelete = DotNetNuke.Services.Localization.Localization.GetString("gvwConfirmDelete", ressFilePath);
            gvwCtrl.SettingsText.EmptyDataRow = DotNetNuke.Services.Localization.Localization.GetString("gvwEmptyDataRow", ressFilePath);
            gvwCtrl.SettingsText.GroupContinuedOnNextPage = DotNetNuke.Services.Localization.Localization.GetString("gvwGroupContinuedOnNextPage", ressFilePath);
            gvwCtrl.SettingsPager.Summary.AllPagesText = DotNetNuke.Services.Localization.Localization.GetString("gvwPagerSummaryAllText", ressFilePath);
            gvwCtrl.SettingsPager.Summary.Text = DotNetNuke.Services.Localization.Localization.GetString("gvwPagerSummaryText", ressFilePath);
            gvwCtrl.SettingsText.GroupPanel = DotNetNuke.Services.Localization.Localization.GetString("gvwGroupPanel", ressFilePath);
            try
            {
                gvwCtrl.SettingsPager.PageSizeItemSettings.Caption = DotNetNuke.Services.Localization.Localization.GetString("gvwAllItemText", ressFilePath);
                gvwCtrl.SettingsText.CustomizationWindowCaption = DotNetNuke.Services.Localization.Localization.GetString("gvwCustomizationWindowCaption", ressFilePath);
                gvwCtrl.SettingsText.CommandClearFilter = DotNetNuke.Services.Localization.Localization.GetString("gvwCmdClearFilter", ressFilePath);
            }
            catch (Exception )
            {
            }

        }
 
 
    }
}