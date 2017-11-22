<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditEntryPB.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Edits.EditEntryPB" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dmx" TagName="ItemCreate" Src="~/DesktopModules/Bring2mind/DMX/Controls/ItemCreate.ascx" %>
<%@ Register TagPrefix="dmx" TagName="CoreMetaData" Src="~/DesktopModules/Bring2mind/DMX/Controls/EditCoreMetaData.ascx" %>
<%@ Register TagPrefix="dmx" Namespace="Bring2mind.DNN.Modules.DMX.UI.WebControls" Assembly="Bring2mind.DNN.Modules.DMX" %>
<%@ Register TagPrefix="dmx" Namespace="Bring2mind.DNN.Modules.DMX.Security.Controls" Assembly="Bring2mind.DNN.Modules.DMX.Core" %>

<p class="Normal DMX_EditEntry_Title">
 <asp:Label runat="server" ID="lblTitle" />
</p>

<div runat="server" ID="divUpload">
 <dmx:ItemCreate id="ctlUpload" runat="server" />
</div>

<p>&nbsp;</p>
<dnn:sectionhead id="dshCoreMetaData" runat="server" cssclass="Head" section="divCoreMetaData"
	resourcekey="dshCoreMetaData" includerule="True" />
<div runat="server" id="divCoreMetaData">
 <dmx:CoreMetaData runat="server" id="ctlCoreMetaData" EntryTypeChangeCausesPostback="True" />
</div>

<p>&nbsp;</p>
<dnn:sectionhead id="dshCustomAttributes" runat="server" cssclass="Head" section="divCustomAttributes"
	resourcekey="dshCustomAttributes" includerule="True" />
<div runat="server" id="divCustomAttributes">
 <dmx:CustomAttributes runat="server" id="ctlCustomAttributes" />
</div>

<p>&nbsp;</p>
<dnn:sectionhead id="dshPermissions" runat="server" cssclass="Head" section="divPermissions"
	resourcekey="dshPermissions" includerule="True" />
<div runat="server" id="divPermissions">
 <dmx:EntryPermissionsGrid runat="server" id="ctlPermissions" />
</div>

<p>&nbsp;</p>
<dnn:sectionhead id="dshCategories" runat="server" cssclass="Head" section="divCategories"
	resourcekey="dshCategories" includerule="True" />
<div runat="server" id="divCategories">
 <dmx:CategorySelect runat="server" id="ctlCategories" />
</div>

<p>
 <asp:Label runat="server" ID="lblErrorMsg" CssClass="NormalRed" />
</p>

<p class="CentralMessage">
 <asp:LinkButton runat="server" ID="cmdCancel" resourcekey="cmdCancel" CssClass="dnnSecondaryAction" CausesValidation="false" />
 <span style='display:<%=IIf(ShowNext, "inline", "none")%>'><asp:LinkButton runat="server" ID="cmdNext" resourcekey="cmdNext" CssClass="dnnPrimaryAction dmxEditNextButton" /></span>
 <asp:LinkButton runat="server" ID="cmdUpdate" resourcekey="cmdUpdate" CssClass="dnnPrimaryAction" />
</p>


