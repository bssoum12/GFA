<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EntryLog.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.EntryLog" %>

<asp:Repeater runat="server" ID="rpLog">
 <HeaderTemplate>
  <table class="DetailsTable">
 </HeaderTemplate>
 <ItemTemplate>
  <tr>
   <td><%#DataBinder.Eval(Container, "DataItem.Datime")%></td>
   <td><%#DataBinder.Eval(Container, "DataItem.Action")%></td>
   <td><%#DataBinder.Eval(Container, "DataItem.DisplayName")%></td>
  </tr>
 </ItemTemplate>
 <FooterTemplate>
 </table>
 </FooterTemplate>
</asp:Repeater>
