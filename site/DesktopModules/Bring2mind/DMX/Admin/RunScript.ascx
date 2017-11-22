<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RunScript.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.RunScript" %>

<p class="SubHead"><%=DotNetNuke.Services.Localization.Localization.GetString("ControlTitle", LocalResourceFile)%></p>

<asp:Repeater runat="server" ID="rpScripts">
 <HeaderTemplate>
  <table border="0" cellpadding="20" cellspacing="0" rules="none" class="table table-responsive">
 </HeaderTemplate>
 <ItemTemplate>
   <tr>
    <td valign="top" class="Normal"><%#CType(DataBinder.Eval(Container, "DataItem"), Bring2mind.DNN.Modules.DMX.Controls.Admin.RunScript.Script).Title%></td>
    <td valign="top" class="Normal"><%#CType(DataBinder.Eval(Container, "DataItem"), Bring2mind.DNN.Modules.DMX.Controls.Admin.RunScript.Script).Description%></td>
    <td valign="top" class="Normal"><a href="<%=ResolveUrl("~/DesktopModules/Bring2mind/DMX/Admin/RunScriptExecute.aspx")%>?PortalId=<%=PortalId%>&TabId=<%=TabId%>&ModuleId=<%=ModuleId%>&Script=<%#CType(DataBinder.Eval(Container, "DataItem"), Bring2mind.DNN.Modules.DMX.Controls.Admin.RunScript.Script).Key%>" class="btn btn-default"><%=DotNetNuke.Services.Localization.Localization.GetString("cmdRun", LocalResourceFile)%></a></td>
   </tr>
 </ItemTemplate>
 <FooterTemplate>
  </table>
 </FooterTemplate>
</asp:Repeater>

<br />
<asp:linkbutton id="cmdCancel" CssClass="dnnPrimaryAction" runat="server" resourcekey="cmdCancel" causesvalidation="False" borderstyle="None" />
