<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VersionList.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.VersionList" %>

<asp:Repeater runat="server" ID="rpVersions">
 <HeaderTemplate>
  <table class="DetailsTable">
 </HeaderTemplate>
 <ItemTemplate>
  <tr class='<%#IIF(CInt(DataBinder.Eval(Container, "DataItem.EntryId"))=EntryId, "Selected", "Regular")%>'>
   <td><%#DataBinder.Eval(Container, "DataItem.Version")%></td>
   <td><%#Bring2mind.DNN.Modules.DMX.Common.Globals.GetADate(DataBinder.Eval(Container, "DataItem.LastModified")).ToShortDateString%></td>
   <td><%#DataBinder.Eval(Container, "DataItem.Title")%><br /><%#DataBinder.Eval(Container, "DataItem.Remarks")%>
   </td>
   <td>
    <a href='<%= Bring2mind.DNN.Modules.DMX.Common.Urls.DMXUrlWithSuffix %>EntryId=<%#DataBinder.Eval(Container, "DataItem.EntryId")%>'><p class="dmxicon-16-pin_blue-png" style="cursor:hand;text-decoration:none;">&nbsp;</p></a>
   </td>
   <td>
    <a href='<%= Bring2mind.DNN.Modules.DMX.Common.Urls.DMXUrlWithSuffix %>EntryId=<%#DataBinder.Eval(Container, "DataItem.EntryId")%>&Command=Core_Download&Method=attachment' style="display:<%#IIF(CStr(DataBinder.Eval(Container, "DataItem.EntryType")).StartsWith("File") or CStr(DataBinder.Eval(Container, "DataItem.EntryType")).StartsWith("Hyperlink"), "inline", "none")%>"><p class="dmxicon-16-disk_blue-png" style="cursor:hand;text-decoration:none;">&nbsp;</p></a>
   </td>
  </tr>
 </ItemTemplate>
 <FooterTemplate>
 </table>
 </FooterTemplate>
</asp:Repeater>
