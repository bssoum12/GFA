<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SubscriptionMgr.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.SubscriptionMgr" %>
<h1><%=DotNetNuke.Services.Localization.Localization.GetString("SubscriptionMgr", LocalResourceFile)%></h1>
<p><%=DotNetNuke.Services.Localization.Localization.GetString("Intro", LocalResourceFile)%></p>
<p><table>
 <tr>
  <td><%=DotNetNuke.Services.Localization.Localization.GetString("DocTitle", LocalResourceFile)%></td>
  <td><%=Query.RequestedEntry.Title%></td>
 </tr>
 <tr>
  <td><%=DotNetNuke.Services.Localization.Localization.GetString("DocEntryId", LocalResourceFile)%></td>
  <td><%=Query.RequestedEntry.EntryId%></td>
 </tr>
 <tr>
  <td><%=DotNetNuke.Services.Localization.Localization.GetString("DocLastModified", LocalResourceFile)%></td>
  <td><%=Query.RequestedEntry.LastModified.ToLongDateString()%></td>
 </tr>
 <tr>
  <td><%=DotNetNuke.Services.Localization.Localization.GetString("DocPath", LocalResourceFile)%></td>
  <td><%=Query.RequestedEntry.FullPath(False, "")%></td>
 </tr>
</table></p>

<table class="dmx_sm_table">
 <tr>
  <th><asp:Label runat="server" ID="lblCategory" resourcekey="lblCategory" /></th>
  <th><asp:Label runat="server" ID="lblEvents" resourcekey="lblEvents" /></th>
  <th><asp:Label runat="server" ID="lblNotify" resourcekey="lblNotify" /></th>
 </tr>
 <tr>
  <td><asp:Label runat="server" ID="lblOwner" resourcekey="lblOwner" /></td>
  <td><asp:PlaceHolder runat="server" ID="plhOwner" /></td>
  <td>
   <asp:DataGrid runat="server" ID="dgOwner" AutoGenerateColumns="false" CssClass="dmx_smu_table" HeaderStyle-CssClass="dmx_smuh_table">
    <Columns>
     <asp:BoundColumn DataField="username" HeaderText="username" />
     <asp:BoundColumn DataField="email" HeaderText="email" />
     <asp:BoundColumn DataField="displayname" HeaderText="displayname" />
    </Columns>
   </asp:DataGrid>
   <asp:Label runat="server" ID="lblNoOwner" resourcekey="na" />
  </td>
 </tr>
 <tr>
  <td><asp:Label runat="server" ID="lblApprovers" resourcekey="lblApprovers" /></td>
  <td><asp:PlaceHolder runat="server" ID="plhApprovers" /></td>
  <td>
   <asp:DataGrid runat="server" ID="dgApprovers" AutoGenerateColumns="false" CssClass="dmx_smu_table" HeaderStyle-CssClass="dmx_smuh_table">
    <Columns>
     <asp:BoundColumn DataField="username" HeaderText="username" />
     <asp:BoundColumn DataField="email" HeaderText="email" />
     <asp:BoundColumn DataField="displayname" HeaderText="displayname" />
    </Columns>
   </asp:DataGrid>
   <asp:Label runat="server" ID="lblNoApprovers" resourcekey="na" />
  </td>
 </tr>
 <tr>
  <td><asp:Label runat="server" ID="lblEditors" resourcekey="lblEditors" /></td>
  <td><asp:PlaceHolder runat="server" ID="plhEditors" /></td>
  <td>
   <asp:DataGrid runat="server" ID="dgEditors" AutoGenerateColumns="false" CssClass="dmx_smu_table" HeaderStyle-CssClass="dmx_smuh_table">
    <Columns>
     <asp:BoundColumn DataField="username" HeaderText="username" />
     <asp:BoundColumn DataField="email" HeaderText="email" />
     <asp:BoundColumn DataField="displayname" HeaderText="displayname" />
    </Columns>
   </asp:DataGrid>
   <asp:Label runat="server" ID="lblNoEditors" resourcekey="na" />
  </td>
 </tr>
 <tr>
  <td><asp:Label runat="server" ID="lblSubscribers" resourcekey="lblSubscribers" /></td>
  <td><asp:PlaceHolder runat="server" ID="plhSubscribers" /></td>
  <td>
   <asp:DataGrid runat="server" ID="dgSubscribers" DataKeyField="Key" AutoGenerateColumns="false" CssClass="dmx_smu_table" HeaderStyle-CssClass="dmx_smuh_table">
    <Columns>
     <asp:BoundColumn DataField="username" HeaderText="username" />
     <asp:BoundColumn DataField="email" HeaderText="email" />
     <asp:BoundColumn DataField="displayname" HeaderText="displayname" />
     <asp:BoundColumn DataField="isinherited" HeaderText="isinherited" />
     <asp:ButtonColumn CommandName="Delete" Text="Delete" />
    </Columns>
   </asp:DataGrid>
   <asp:Label runat="server" ID="lblNoSubscribers" resourcekey="na" />
  </td>
 </tr>
 <tr>
  <td><asp:Label runat="server" ID="lblAddSubscriber" resourcekey="lblAddSubscriber" /></td>
  <td colspan="2">
   <asp:TextBox runat="server" ID="txtAddSubscriber" Width="300" />&nbsp;
   <asp:Button runat="server" ID="cmdAddSubscriber" resourcekey="cmdAddSubscriber" Text="Add" /><br />
   <%=DotNetNuke.Services.Localization.Localization.GetString("AddHelp", LocalResourceFile)%>
  </td>
 </tr>
</table>

<p style="width:100%;text-align:center;margin-top:20px">
 <asp:hyperlink runat="server" ID="cmdReturn" resourcekey="cmdReturn" CssClass="dnnPrimaryAction" />
</p>
