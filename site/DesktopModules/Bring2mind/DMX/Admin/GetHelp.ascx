<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="GetHelp.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.GetHelp" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dmx" TagName="DatePicker" Src="~/DesktopModules/Bring2mind/DMX/Controls/SelectDate.ascx" %>
<h1><asp:Label runat="server" ID="lblStep1" resourcekey="lblStep1" /></h1>
<p>
 <dnn:label runat="server" id="plBody" controlname="txtBody" suffix=":" cssclass="SubHead" /><br />
 <dnn:DNNRichTextEditControl runat="server" id="txtBody" width="600" height="400" enableviewstate="true" />
</p>
<h1><asp:Label runat="server" ID="lblStep2" resourcekey="lblStep2" /></h1>
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plServerInfo" runat="server" controlname="chkServerInfo" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkServerInfo" Checked="true" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plHostInfo" runat="server" controlname="chkHostInfo" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkHostInfo" Checked="true" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plWebConfig" runat="server" controlname="chkWebConfig" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkWebConfig" Checked="true" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plGenUsageInfo" runat="server" controlname="chkGenUsageInfo" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkGenUsageInfo" Checked="true" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plFileSystem" runat="server" controlname="chkFileSystem" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkFileSystem" Checked="true" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead" valign="top">
   <dnn:label id="plEventLog" runat="server" controlname="chkEventLog" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkEventLog" Checked="true" AutoPostBack="true" />
   <asp:Panel runat="server" ID="pnlEventLog">
    <br />
    <table cellspacing="4" cellpadding="0" border="0">
     <tr>
      <td class="DMX_EditTitle SubHead">
       <dnn:label id="plEventsOnlyBring2mind" runat="server" controlname="chkEventsOnlyBring2mind" suffix=":" />
      </td>
      <td>
       <asp:CheckBox runat="server" ID="chkEventsOnlyBring2mind" Checked="true" />
      </td>
     </tr>
     <tr>
      <td class="DMX_EditTitle SubHead">
       <dnn:label id="plNrEvents" runat="server" controlname="txtNrEvents" suffix=":" />
      </td>
      <td>
       <asp:TextBox runat="server" ID="txtNrEvents" width="50" Text="20" />
      </td>
     </tr>
     <tr>
      <td class="DMX_EditTitle SubHead">
       <dnn:label id="plEventsStart" runat="server" controlname="dpEventsStart" suffix=":" />
      </td>
      <td>
       <dmx:DatePicker runat="server" id="dpEventsStart" ShowTime="True" />
      </td>
     </tr>
     <tr>
      <td class="DMX_EditTitle SubHead">
       <dnn:label id="plEventsEnd" runat="server" controlname="dpEventsEnd" suffix=":" />
      </td>
      <td>
       <dmx:DatePicker runat="server" id="dpEventsEnd" ShowTime="True" />
      </td>
     </tr>
    </table>
   </asp:Panel>
  </td>
 </tr>
</table>
<h1><asp:Label runat="server" ID="lblStep3" resourcekey="lblStep3" /></h1>
<p><asp:Label runat="server" ID="lblCreateHostAccount" resourcekey="lblCreateHostAccount" /></p>
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plCreateHost" runat="server" controlname="chkCreateHost" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkCreateHost" Checked="false" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plHostTimeout" runat="server" controlname="dpHostTimeout" suffix=":" />
  </td>
  <td>
   <dmx:DatePicker runat="server" id="dpHostTimeout" ShowTime="false" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUrl" runat="server" controlname="txtUrl" suffix=":" />
  </td>
  <td>
   <asp:TextBox runat="server" ID="txtUrl" Width="300" />
  </td>
 </tr>
</table>
<h1><asp:Label runat="server" ID="lblStep4" resourcekey="lblStep4" /></h1>
<p><asp:Label runat="server" ID="lblSend" resourcekey="lblSend" /></p>
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plViewInfo" runat="server" controlname="btnViewInfo" suffix=":" />
  </td>
  <td>
   <asp:Button runat="server" CssClass="dnnSecondaryAction" ID="cmdView" resourcekey="cmdView" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plReturnEmail" runat="server" controlname="txtReturnEmail" suffix=":" />
  </td>
  <td>
   <asp:TextBox runat="server" ID="txtEmail" Width="300" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSend" runat="server" controlname="btnSend" suffix=":" />
  </td>
  <td>
   <asp:Button runat="server" CssClass="dnnPrimaryAction" ID="cmdSend" resourcekey="cmdSend" />
  </td>
 </tr>
</table>
<p style="width:100%;text-align:center">
 <asp:linkbutton id="cmdReturn" runat="server" CssClass="dnnSecondaryAction" borderstyle="none" text="Return" resourcekey="cmdReturn" />
</p>
