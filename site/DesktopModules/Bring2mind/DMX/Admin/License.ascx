<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="License.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.License" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<h1><%=DotNetNuke.Services.Localization.Localization.GetString("ControlTitle", LocalResourceFile)%></h1>
<p class="Normal"><%=DotNetNuke.Services.Localization.Localization.GetString("ControlHelp", LocalResourceFile)%></p>

<div class="dmxLicense"
     data-moduleid="<%= ModuleContext.ModuleId %>"
     data-resources='<%=Newtonsoft.Json.JsonConvert.SerializeObject(DotNetNuke.Services.Localization.LocalizationProvider.Instance.GetCompiledResourceFile(PortalSettings, "/DesktopModules/Bring2mind/DMX/Admin/App_LocalResources/ClientResources.resx", Threading.Thread.CurrentThread.CurrentCulture.Name))%>'
     data-manuallink="<%= ResolveUrl("~/DesktopModules/Bring2mind/DMX/Admin/LicenseManualCall.aspx") & "?tabid=" & TabId %>"
     data-license='<%= Newtonsoft.Json.JsonConvert.SerializeObject(License) %>'>
</div>

<p style="width:100%;text-align:center">
 <asp:linkbutton id="cmdReturn" runat="server" CssClass="dnnPrimaryAction" borderstyle="none" text="Return" resourcekey="cmdReturn" />
</p>
