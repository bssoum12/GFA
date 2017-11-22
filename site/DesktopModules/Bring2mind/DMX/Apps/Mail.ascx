<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Mail.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Apps.Mail" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<asp:Label runat="server" ID="lblReport" />

<dnn:sectionhead id="dshSendWhat" runat="server" cssclass="Head" text="Permissions" section="tblSendWhat"	resourcekey="dshSendWhat" includerule="True" />
<table id="tblSendWhat" cellspacing="0" cellpadding="2" border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDocumentList" runat="server" controlname="lblDocumentList" suffix=":" />
  </td>
  <td>
   <asp:Label runat="server" ID="lblDocumentList" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSendMethod" runat="server" controlname="ddSendMethod" suffix=":" />
  </td>
  <td>
   <asp:DropDownList runat="server" ID="ddSendMethod" AutoPostBack="true">
    <asp:ListItem resourcekey="optAttachment" Value="ATTACHMENT" />
    <asp:ListItem resourcekey="optLink" Value="LINK" />
   </asp:DropDownList>
  </td>
 </tr>
</table>

<dnn:sectionhead id="dshSendTo" runat="server" cssclass="Head" text="Permissions" section="tblSendTo"	resourcekey="dshSendTo" includerule="True" />
<table id="tblSendTo" cellspacing="0" cellpadding="2" border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSendTo" runat="server" controlname="ToTabs" suffix=":" />
  </td>
  <td>
   <ComponentArt:TabStrip id="ToTabs" 
    ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/16/"
    CssClass="DMX_TopGroup"
    AutoTheming="true"
    DefaultGroupTabSpacing="1"
    MultiPageId="ToPages"
    runat="server">
    <Tabs>
     <componentart:TabStripTab id="ToTabFree" runat="server" Text="F" />
     <componentart:TabStripTab id="ToTabUsers" runat="server" Text="U" />
     <componentart:TabStripTab id="ToTabRoles" runat="server" Text="R" />
   </Tabs>
   </ComponentArt:TabStrip>
   <ComponentArt:MultiPage id="ToPages" runat="server" CssClass="DMX_MultiPage">
    <ComponentArt:PageView CssClass="DMX_PageContent" runat="server" id="TabPageFree">
     <asp:textbox id="txtTo" runat="server" 
      width="300" 
      cssclass="NormalTextBox" 
      TextMode="MultiLine"
      height="150" />
    </ComponentArt:PageView>
    <ComponentArt:PageView CssClass="DMX_PageContent" runat="server" id="TabPageUsers">
     <div>
      <p><asp:Label runat="server" ID="lblUsername" resourcekey="lblUsername" CssClass="SubHead" />&nbsp;
      <asp:TextBox runat="server" ID="txtUsername" Width="200" />&nbsp;
      <asp:Button runat="server" ID="cmdAddUser" resourcekey="cmdAddUser" CausesValidation="false" /></p>
      <p><asp:ListBox runat="server" ID="lbUsers" Width="300" Height="200" /></p>
      <p><asp:Button runat="server" ID="cmdRemoveUser" resourcekey="cmdRemoveUser" CausesValidation="false" /></p>
     </div>
    </ComponentArt:PageView>
    <ComponentArt:PageView CssClass="DMX_PageContent" runat="server" id="TabPageRoles">
    	<asp:checkboxlist id="chkRoles" runat="server" 
    	 cssclass="Normal" 
    	 repeatcolumns="2" 
    	 datavaluefield="RoleId"
						datatextfield="RoleName" 
						width="325" />
    </ComponentArt:PageView>
   </ComponentArt:MultiPage>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plCCMe" runat="server" controlname="chkCCMe" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkCCMe" />
  </td>
 </tr>
</table>

<dnn:sectionhead id="dshOptions" runat="server" cssclass="Head" text="Permissions" section="tblOptions"	resourcekey="dshOptions" includerule="True" />
<table id="tblOptions" cellspacing="0" cellpadding="2" border="0" runat="server">
 <tr runat="server" id="trAvailability">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plAvailability" runat="server" controlname="datePicker" suffix=":" />
  </td>
  <td>
   <ComponentArt:Calendar id="datePicker" runat="server"
     ControlType="Picker" EnableViewState="true"
     ClientSideOnSelectionChanged="onPickerChange" 
     PickerFormat="Short" />&nbsp;&nbsp;
   <asp:image runat="server" id="imgCal" 
     ImageUrl = "~/DesktopModules/Bring2mind/DMX/images/16/calendar.gif" />
   <ComponentArt:Calendar id="datePopup" runat="server"
     AutoTheming="true"
     ControlType="Calendar"
     ClientSideOnSelectionChanged="onCalendarChange" 
     PopUp="Custom" EnableViewState="true"
     DayNameFormat="FirstTwoLetters"
     SelectMonthText="&curren;" 
     SelectWeekText="&raquo;" 
     SwapDuration="300"
     SwapSlide="Linear"
     width="190px"
     height="160px"
    />
  </td>
 </tr>
 <tr runat="server" id="trDownloads">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDownloads" runat="server" controlname="txtDownloads" suffix=":" />
  </td>
  <td>
    <asp:textbox id="txtDownloads" runat="server" width="60" maxlength="10" cssclass="NormalTextBox" />&nbsp;
    <asp:comparevalidator ID="valDownloads" runat="server" resourcekey="WholeNumber.Error" operator="DataTypeCheck" type="Integer" controltovalidate="txtDownloads" display="Dynamic" />&nbsp;
  </td>
 </tr>
</table>

<dnn:sectionhead id="dshEmail" runat="server" cssclass="Head" text="Permissions" section="tblEmail"	resourcekey="dshEmail" includerule="True" />
<table id="tblEmail" cellspacing="0" cellpadding="2" border="0" runat="server">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSubject" runat="server" controlname="txtSubject" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtSubject" runat="server" width="300" cssclass="NormalTextBox" />&nbsp;
   <asp:requiredfieldvalidator ID="reqSubject" runat="server" resourcekey="Required.Error" controltovalidate="txtSubject" display="Dynamic" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plBody" runat="server" controlname="txtBody" suffix=":" />
  </td>
 </tr>
 <tr>
  <td colspan="2">
   <dnn:texteditor id="txtBody" runat="server" height="400" width="660" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plReplaceTokens" runat="server" controlname="chkReplaceTokens" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkReplaceTokens" />
  </td>
 </tr>
</table>

<p style="margin-top:30px;width:100%;text-align:center;">
<asp:linkbutton id="cmdCancel" resourcekey="cmdCancel" text="Cancel" causesvalidation="False" runat="server" CssClass="dnnSecondaryAction" borderstyle="none" />&nbsp;
<asp:linkbutton id="cmdSend" resourcekey="cmdSend" text="Send" runat="server" class="dnnPrimaryAction" borderstyle="none" causesvalidation="True" />
</p>
