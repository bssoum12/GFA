<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Notifications.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.Notifications" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table>
<asp:DataList runat="server" ID="dlLogtypes" RepeatDirection="Vertical">
 <HeaderTemplate>
 <tr>
  <td>
   <dnn:label id="plAction" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="plNotifyApprovers" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="plNotifyEditors" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="plNotifyOwner" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="pNotifySelf" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="pNotifySubscribers" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="plNotifyAudit" runat="server" CssClass="SubHead" />
  </td>
 </tr>
 <tr>
   <td>&nbsp;</td>
   <td colspan="4"><dnn:label id="plResourceFile" runat="server" CssClass="SubHead" /></td>
  <td>
   <dnn:label id="plAttachFile" runat="server" CssClass="SubHead" />
  </td>
  <td>
   <dnn:label id="plCustomSend" runat="server" CssClass="SubHead" />
  </td>
 </tr>
  <tr>
   <td colspan="7">&nbsp;</td>
  </tr>
 </HeaderTemplate>
 <ItemTemplate>
  <tr>
   <td><asp:Label runat="server" ID="lblKey" Text='<%#DataBinder.Eval(Container.DataItem, "LogTypeKey")%>' CssClass="NormalBold" /></td>
   <td><asp:TextBox runat="server" ID="txtNotifyApprovers" Width="140" Text='<%#DataBinder.Eval(Container.DataItem, "NotifyApprovers")%>' /></td>
   <td><asp:TextBox runat="server" ID="txtNotifyEditors" Width="140" Text='<%#DataBinder.Eval(Container.DataItem, "NotifyEditors")%>' /></td>
   <td><asp:TextBox runat="server" ID="txtNotifyOwner" Width="140" Text='<%#DataBinder.Eval(Container.DataItem, "NotifyOwner")%>' /></td>
   <td><asp:TextBox runat="server" ID="txtNotifySelf" Width="140" Text='<%#DataBinder.Eval(Container.DataItem, "NotifySelf")%>' /></td>
   <td><asp:TextBox runat="server" ID="txtNotifySubscribers" Width="140" Text='<%#DataBinder.Eval(Container.DataItem, "NotifySubscribers")%>' /></td>
   <td><asp:CheckBox runat="server" ID="chkNotifyAudit" Checked='<%#DataBinder.Eval(Container.DataItem, "NotifyAudit").ToString%>' /></td>
  </tr>
  <tr>
   <td>&nbsp;</td>
   <td colspan="4"><asp:TextBox runat="server" ID="txtResourceFile" Width="500" Text='<%#DataBinder.Eval(Container.DataItem, "ResourceFile")%>' /></td>
   <td><asp:CheckBox runat="server" ID="chkAttachFile" Checked='<%#DataBinder.Eval(Container.DataItem, "AttachFile").ToString%>' /></td>
   <td><asp:CheckBox runat="server" ID="chkCustomSend" Checked='<%#DataBinder.Eval(Container.DataItem, "CustomSend").ToString%>' /></td>
  </tr>
  <tr>
   <td>&nbsp;</td>
  </tr>
 </ItemTemplate>
</asp:DataList>
</table>
<p>
 <asp:linkbutton id="cmdUpdate" runat="server" borderstyle="None" CssClass="dnnPrimaryAction" resourcekey="cmdUpdate" Text="Update" />&nbsp; 
 <asp:linkbutton id="cmdCancel" runat="server" borderstyle="None" CssClass="dnnSecondaryAction" resourcekey="cmdCancel" Text="Cancel" /> 
</p>
