<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MainOptions.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.MainOptions" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dmx" Namespace="Bring2mind.DNN.Modules.DMX.Security.Controls" Assembly="Bring2mind.DNN.Modules.DMX.Core" %>

  <asp:label runat="server" id="lblNotePortal" resourcekey="lblNotePortal" cssclass="NormalRed" />
  <table cellspacing="4" cellpadding="0" border="0">
   <tr>
    <td class="DMX_EditTitle SubHead">
 	   <dnn:label id="plVersions" runat="server" controlname="txtVersions" suffix=":" />
	   </td>
    <td class="NormalBold">
	    <asp:textbox id="txtVersions" runat="server" cssclass="NormalTextBox" maxlength="10" width="60" />&nbsp;
	    <asp:label runat="server" id="lblVersions" text="(-1 = keep all versions)" resourcekey="lblVersions" />
	    <asp:comparevalidator id="valcompVersions" runat="server" controltovalidate="txtVersions" display="Dynamic" errormessage="Not a valid (whole) number!" type="Integer" operator="DataTypeCheck" resourcekey="valWholeNumber" />
	    <asp:requiredfieldvalidator id="valreqVersions" runat="server" controltovalidate="txtVersions" display="Dynamic" errormessage="Required!" resourcekey="valRequired" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
     <dnn:label id="plLockDuration" runat="server" controlname="ddLockDuration" suffix=":" />
    </td>
    <td>
   	 <asp:dropdownlist id="ddLockDuration" runat="server" cssclass="NormalTextBox" width="300px">
      <asp:ListItem Value="00:20:00" Text="20 Minutes" resourcekey="lock20mins" />
      <asp:ListItem Value="01:00:00" Text="1 Hour" resourcekey="lock1hour" />
      <asp:ListItem Value="04:00:00" Text="4 Hours" resourcekey="lock4hours" />
      <asp:ListItem Value="12:00:00" Text="12 Hours" resourcekey="lock12hours" />
      <asp:ListItem Value="1.00:00:00" Text="24 Hours" resourcekey="lock24hours" />
      <asp:ListItem Value="2.00:00:00" Text="2 Days" resourcekey="lock2days" />
      <asp:ListItem Value="7.00:00:00" Text="1 Week" resourcekey="lock1week" />
      <asp:ListItem Value="31.00:00:00" Text="1 Month" resourcekey="lock1month" />
	    </asp:dropdownlist>
    </td>
   </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
     <dnn:label id="plPermissionsOnlyByAdmin" runat="server" controlname="chkPermissionsOnlyByAdmin" suffix=":" />
    </td>
    <td>
     <asp:checkbox runat="server" id="chkPermissionsOnlyByAdmin" />
    </td>
   </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
     <dnn:label id="plHidePermissionsWhenNoPermissions" runat="server" controlname="chkHidePermissionsWhenNoPermissions" suffix=":" />
    </td>
    <td>
     <asp:checkbox runat="server" id="chkHidePermissionsWhenNoPermissions" />
    </td>
   </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
     <dnn:label id="plMoveKeepOldPermissions" runat="server" controlname="chkMoveKeepOldPermissions" suffix=":" />
    </td>
    <td>
     <asp:checkbox runat="server" id="chkMoveKeepOldPermissions" />
    </td>
   </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plAuditEmail" runat="server" controlname="txtAuditEmail" suffix=":" />
	   </td>
    <td>
     <asp:TextBox runat="server" ID="txtAuditEmail" Width="200" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plNotificationsFromAddress" runat="server" controlname="txtNotificationsFromAddress" suffix=":" />
	   </td>
    <td>
     <asp:TextBox runat="server" ID="txtNotificationsFromAddress" Width="200" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plDefaultPortalAlias" runat="server" controlname="ddDefaultPortalAlias" suffix=":" />
	   </td>
    <td>
	    <asp:dropdownlist runat="server" id="ddDefaultPortalAlias" DataTextField="HTTPAlias" DataValueField="HTTPAlias" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plDefaultDMX" runat="server" controlname="ddDefaultDMX" suffix=":" />
	   </td>
    <td>
	    <asp:dropdownlist runat="server" id="ddDefaultDMX" DataTextField="Description" DataValueField="ModuleId" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plRemarksAsHtml" runat="server" controlname="chkRemarksAsHtml" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkRemarksAsHtml" runat="server" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plShowEarlyFinish" runat="server" controlname="chkShowEarlyFinish" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkShowEarlyFinish" runat="server" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plIncludeAllUsersByDefault" runat="server" controlname="chkIncludeAllUsersByDefault" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkIncludeAllUsersByDefault" runat="server" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plQuickSearchTitleOnly" runat="server" controlname="chkQuickSearchTitleOnly" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkQuickSearchTitleOnly" runat="server" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plAllowEmailMe" runat="server" controlname="chkAllowEmailMe" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkAllowEmailMe" runat="server" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plUseGraveYard" runat="server" controlname="chkUseGraveYard" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkUseGraveYard" runat="server" />
	   </td>
	  </tr>
   <tr runat="server" id="trAllowAdminSyncFolder">
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plAllowAdminSyncFolder" runat="server" controlname="chkAllowAdminSyncFolder" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkAllowAdminSyncFolder" runat="server" />
	   </td>
	  </tr>
   <tr>
    <td class="DMX_EditTitle SubHead">
	    <dnn:label id="plUsePageGuide" runat="server" controlname="chkUsePageGuide" suffix=":" />
	   </td>
    <td>
	    <asp:checkbox id="chkUsePageGuide" runat="server" />
	   </td>
	  </tr>
  </table>

<p>&nbsp;</p>
<dnn:sectionhead id="dshPermissions" runat="server" cssclass="Head" text="Permissions" section="pnlPermissions"	resourcekey="dshPermissions" includerule="True" />
<div id="pnlPermissions" runat="server">
 <dmx:ApplicationPermissionsGrid id="ctlPermissions" runat="server" />
</div>

<p>&nbsp;</p>
<dnn:sectionhead id="dshPermissionPermissions" runat="server" cssclass="Head" text="Permissions" section="pnlPermissionPermissions"	resourcekey="dshPermissionPermissions" includerule="True" />
<div id="pnlPermissionPermissions" runat="server">
 <dmx:PermissionPermissionsGrid id="ctlPermissionPermissions" runat="server" />
</div>

<p>&nbsp;</p>
<dnn:sectionhead id="dshWebDAV" runat="server" cssclass="Head" text="WebDAV" section="tblWebDAV"
	resourcekey="dshWebDAV" includerule="True" />
<table id="tblWebDAV" cellspacing="0" cellpadding="2" summary="Configuration Design Table"	border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plEnableWebDAV" runat="server" controlname="chkEnableWebDAV" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkEnableWebDAV" runat="server" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plWebDavHardDelete" runat="server" controlname="chkWebDavHardDelete" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkWebDavHardDelete" runat="server" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plWebDAVCookieTimeout" runat="server" controlname="txtWebDAVCookieTimeout" suffix=":" />
  </td>
  <td>
   <asp:textbox runat="server" ID="txtWebDAVCookieTimeout" Width="100" />&nbsp;<%=LocalizeString("Hours")%>
  </td>
 </tr>
</table>

<p>&nbsp;</p>
<dnn:sectionhead id="dshConfiguration" runat="server" cssclass="Head" text="Configuration" section="tblConfiguration"
	resourcekey="dshConfiguration" includerule="True" />
<table id="tblConfiguration" cellspacing="0" cellpadding="2" summary="Configuration Design Table"	border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDebug" runat="server" controlname="chkDebug" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkDebug" runat="server" />
  </td>
 </tr>
</table>

<p>&nbsp;</p>
<dnn:sectionhead id="dshThumbnails" runat="server" cssclass="Head" text="Thumbnails" section="tblThumbnails"
	resourcekey="dshThumbnails" includerule="True" />
<table id="tblThumbnails" cellspacing="0" cellpadding="2" summary="Configuration Design Table"	border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plEnableThumbnails" runat="server" controlname="chkThumbnails" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkThumbnails" runat="server" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plEnableCustomThumbnails" runat="server" controlname="chkCustomThumbnails" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkCustomThumbnails" runat="server" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSecureThumbnails" runat="server" controlname="chkSecureThumbnails" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkSecureThumbnails" runat="server" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plThumbnailSize" runat="server" controlname="txtThumbnailWidth" suffix=":" />
  </td>
  <td>
   <asp:Label runat="server" ID="lblWidth" resourcekey="lblWidth" />&nbsp;
   <asp:TextBox runat="server" ID="txtThumbnailWidth" Width="70" />
   <asp:comparevalidator id="valThumbnailWidth" runat="server" controltovalidate="txtThumbnailWidth" display="Dynamic" errormessage="Not a valid (whole) number!" type="Integer" operator="DataTypeCheck" resourcekey="valWholeNumber" />&nbsp;x&nbsp;
   <asp:Label runat="server" ID="lblHeight" resourcekey="lblHeight" />&nbsp;
   <asp:TextBox runat="server" ID="txtThumbnailHeight" Width="70" />
   <asp:comparevalidator id="valThumbnailHeight" runat="server" controltovalidate="txtThumbnailHeight" display="Dynamic" errormessage="Not a valid (whole) number!" type="Integer" operator="DataTypeCheck" resourcekey="valWholeNumber" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plThumbnailType" runat="server" controlname="ddThumbnailType" suffix=":" />
  </td>
  <td>
   <asp:DropDownList runat="server" ID="ddThumbnailType">
    <asp:ListItem Value="Shrink" Text="Shrink" resourcekey="TNShrink" />
    <asp:ListItem Value="Crop" Text="Crop" resourcekey="TNCrop" />
    <asp:ListItem Value="Fill" Text="Fill" resourcekey="TNFill" />
   </asp:DropDownList>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plThumbnailFormat" runat="server" controlname="ddThumbnailFormat" suffix=":" />
  </td>
  <td>
   <asp:DropDownList runat="server" ID="ddThumbnailFormat">
    <asp:ListItem Value="File.Jpg" Text="Jpeg" />
    <asp:ListItem Value="File.Png" Text="Png" />
    <asp:ListItem Value="File.Gif" Text="Gif" />
   </asp:DropDownList>
  </td>
 </tr>
</table>

<p>&nbsp;</p>
<dnn:sectionhead id="dshMailing" runat="server" cssclass="Head" text="Mailing" section="tblMailing"	resourcekey="dshMailing" includerule="True" />
<table id="tblMailing" cellspacing="0" cellpadding="2" summary="Configuration Design Table"	border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plEnableMailing" runat="server" controlname="chkEnableMailing" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkEnableMailing" runat="server"  />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plMethods" runat="server" controlname="chkMailMethodAttachment" suffix=":" />
  </td>
  <td>
   <asp:checkbox id="chkMailMethodAttachment" runat="server" resourcekey="chkMailMethodAttachment" />
   <asp:checkbox id="chkMailMethodLink" runat="server" resourcekey="chkMailMethodLink" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plMailUseAdminSender" runat="server" controlname="chkMailUseAdminSender" suffix=":" />
  </td>
  <td>
   <asp:checkbox runat="server" id="chkMailUseAdminSender" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUserCanChangeAvailability" runat="server" controlname="chkUserCanChangeAvailability" suffix=":" />
  </td>
  <td>
   <asp:checkbox runat="server" id="chkUserCanChangeAvailability" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDuration" runat="server" controlname="txtDuration" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtDuration" runat="server" width="60" maxlength="10" cssclass="NormalTextBox" />&nbsp;
   <asp:comparevalidator ID="valDuration" runat="server" resourcekey="valWholeNumber.Errormessage" operator="DataTypeCheck" type="Integer" controltovalidate="txtDuration" display="Dynamic" />&nbsp;
   <asp:requiredfieldvalidator ID="reqDuration" runat="server" resourcekey="valRequired.Errormessage" controltovalidate="txtDuration" display="Dynamic" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDurationMeasure" runat="server" controlname="ddDurationMeasure" suffix=":" />
  </td>
  <td>
   <asp:dropdownlist runat="server" id="ddDurationMeasure">
     <asp:ListItem Value="d" Text="Days" resourcekey="optDays" />
     <asp:ListItem Value="w" Text="Weeks" resourcekey="optWeeks" />   
     <asp:ListItem Value="m" Text="Months" resourcekey="optMonths" />
     <asp:ListItem Value="y" Text="Years" resourcekey="optYears" />
   </asp:dropdownlist>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDownloads" runat="server" controlname="txtDownloads" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtDownloads" runat="server" width="60" maxlength="10" cssclass="NormalTextBox" />&nbsp;
   <asp:comparevalidator ID="valDownloads" runat="server" resourcekey="valWholeNumber.Errormessage" operator="DataTypeCheck" type="Integer" controltovalidate="txtDownloads" display="Dynamic" />&nbsp;
   <asp:requiredfieldvalidator ID="reqDownloads" runat="server" resourcekey="valRequired.Errormessage" controltovalidate="txtDownloads" display="Dynamic" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plShowMailRecipients" runat="server" controlname="chkShowUsers" suffix=":" />
  </td>
  <td>
   <asp:checkbox runat="server" id="chkShowUsers" resourcekey="chkShowUsers" /><br />
   <asp:checkbox runat="server" id="chkShowRoles" resourcekey="chkShowRoles" /><br />
   <asp:checkbox runat="server" id="chkShowFree" resourcekey="chkShowFree" /><br />
  </td>
 </tr>
</table>

<p>&nbsp;</p>
<hr />

<p>
 <asp:ValidationSummary runat="server" ID="valSummary" DisplayMode="BulletList" ShowSummary="true" />
</p>

<p>
 <asp:linkbutton id="cmdUpdate" runat="server" CssClass="dnnPrimaryAction" borderstyle="none" text="Update" resourcekey="cmdUpdate" />&nbsp; 
 <asp:hyperlink id="cmdCancel" runat="server" CssClass="dnnSecondaryAction" borderstyle="none" text="Cancel" resourcekey="cmdCancel" />
</p>
