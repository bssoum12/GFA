<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Details.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Details" %>
<%@ Register TagPrefix="dmx" TagName="versionlist" Src="VersionList.ascx" %>
<%@ Register TagPrefix="dmx" TagName="log" Src="EntryLog.ascx" %>
<%@ Register TagPrefix="dmx" Namespace="Bring2mind.DNN.Modules.DMX.UI.WebControls" Assembly="Bring2mind.DNN.Modules.DMX.Core" %>

<div class="DetailsControl">
 <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("Path", LocalResourceFile)%></p>
 <div class="EntryDetails">
  <p style="font-size:12px;padding: 6px 4px 4px 4px;margin: 0px;"><%=Entry.FullPath(False, System.Threading.Thread.CurrentThread.CurrentCulture.Name)%></p>
 </div>
 <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("Details", LocalResourceFile)%></p>
 <div class="EntryDetails">
 <table>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Author", LocalResourceFile)%></td>
   <td><%=Entry.Author%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("LastModified", LocalResourceFile)%></td>
   <td><%=Entry.LastModified%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Version", LocalResourceFile)%></td>
   <td><%=Entry.Version%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("FileSize", LocalResourceFile)%></td>
   <td><%=Bring2mind.DNN.Modules.DMX.UI.Utilities.FormatSize(Entry.FileSize)%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Created", LocalResourceFile)%></td>
   <td><%=Entry.Created%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Keywords", LocalResourceFile)%></td>
   <td><%=Entry.Keywords%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Categories", LocalResourceFile)%></td>
   <td><%=Bring2mind.DNN.Modules.DMX.UI.Utilities.FormatCategories(Entry.Categories(System.Threading.Thread.CurrentThread.CurrentCulture.Name))%></td>
  </tr>
  <tr style='<%=IIf(Entry.EntryType.StartsWith("File"), "", "display:none")%>'>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("OriginalFileName", LocalResourceFile)%></td>
   <td><%=Entry.OriginalFileName%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Remarks", LocalResourceFile)%></td>
   <td><%=Entry.Remarks%></td>
  </tr>
  <asp:Repeater runat="server" ID="rpAttributes">
   <ItemTemplate>
    <tr>
     <td><%#DataBinder.Eval(Container, "DataItem.Attribute.AttributeName")%></td>
     <td><%#DataBinder.Eval(Container, "DataItem.Value")%></td>
    </tr>
   </ItemTemplate>
  </asp:Repeater>
 </table>
 </div>
 <dmx:DMXPanel runat="server" id="pnlSyncFolder" ViewPermission="Admin">
 <div style='display:<%=IIf(Entry.EntryType="Collection.SyncFolder", "block", "none")%>'>
 <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("SyncFolder", Bring2mind.DNN.Modules.DMX.Common.Globals.glbDMXSharedResourceFile)%></p>
 <div class="EntryDetails">
 <table>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("SourceFolder", LocalResourceFile)%></td>
   <td><%=Entry.OriginalFileName%></td>
  </tr>
  <tr>
   <td><%=DotNetNuke.Services.Localization.Localization.GetString("Resolution", LocalResourceFile)%></td>
   <td><%=Bring2mind.DNN.Modules.DMX.Services.SyncFolders.SyncFolders.GetSyncResolution(Entry)%></td>
  </tr>
 </table> 
 </div>
 </div>
 </dmx:DMXPanel>
 <div>
 <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("Status", LocalResourceFile)%></p>
 <div class="EntryDetails">&nbsp;
  <span style='display:<%=IIf(Entry.LockedUntil>Now, "block", "none")%>'><%=DotNetNuke.Services.Localization.Localization.GetString("Locked", LocalResourceFile)%></span>
  <span style='display:<%=IIf(Entry.Deleted, "block", "none")%>'><%=DotNetNuke.Services.Localization.Localization.GetString("Deleted", LocalResourceFile)%></span>
  <span style='display:<%=IIf(Entry.IsApproved, "none", "block")%>'><%=DotNetNuke.Services.Localization.Localization.GetString("NotApproved", LocalResourceFile)%></span>
 </div>
 </div>
 <dmx:DMXPanel runat="server" id="pnlPermissions" ViewPermission="Edit">
 <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("Permissions", LocalResourceFile)%></p>
 <div class="EntryDetails">
  <table>
   <%=Bring2mind.DNN.Modules.DMX.UI.Utilities.FormatPermissions(Entry.Permissions)%>
  </table>
 </div>
 </dmx:DMXPanel>
 <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("Versions", LocalResourceFile)%></p>
 <div class="EntryDetails">
  <dmx:versionlist runat="server" id="ctlVersions" />
 </div>
 <dmx:dmxpanel runat="server" id="pnlLog" ViewPermission="Admin">
  <p class="DetailsHeading"><%=DotNetNuke.Services.Localization.Localization.GetString("Log", LocalResourceFile)%></p>
  <div class="EntryDetails">
   <dmx:log runat="server" id="ctlLog" />
  </div>
 </dmx:dmxpanel>
</div>
