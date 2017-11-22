<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Extensions.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.Extensions" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="DualList" Src="../Controls/RoleListControl.ascx" %>

<style type="text/css">
<!--
.LocalGrid_Container
{
 font-weight:  normal;
 font-size: 8pt;
 font-family: Verdana, Arial, Helvetica;
 border-collapse: collapse;
 margin-bottom: 30px;
}
.LocalGrid_Container td
{
 padding: 2px 4px 2px 2px;
 height: 28px;
 color: #093890;
 white-space: nowrap;
 overflow: hidden;
}


.LocalGrid_Item
{
	background-color: #ffffff;
}
.LocalGrid_Container a, .LocalGrid_Container a:link, .LocalGrid_Container a:visited
{
 color: #093890;
 text-decoration: none;
}
.LocalGrid_Container a:hover, .LocalGrid_Container a:active
{
 color: #5295FF;
 text-decoration: underline;
}
.LocalGrid_AlternatingItem
{
	background-color: #efefef;
}
.LocalGrid_HighlightedItem
{
	background-color: #FAFF9B;
}
.LocalGrid_MouseOverRow
{
	background-color: #ddd;
}


.LocalGrid_Header
{
	background-color:#CFE0FC;
	color: #093890;
}
.LocalGrid_Header a:link, .LocalGrid_Header a:visited
{
	color: #093890;
	text-decoration: none;
}
.LocalGrid_Header a:hover, .LocalGrid_Header a:active
{
	color: #fff;
	text-decoration: none;
}
.LocalGrid_Header td
{
 padding: 4px 4px 4px 2px;
 font-weight: bold;
}
-->
</style>

<p style="text-align:right">
 <asp:hyperlink id="cmdBackTop" runat="server" CssClass="dnnPrimaryAction" borderstyle="None" resourcekey="cmdReturn" Text="Return" />
</p>

<asp:panel runat="server" id="pnlList">
 <asp:datagrid id="dgExtensions" runat="server" autogeneratecolumns="false" borderwidth="0" cellpadding="4" cellspacing="0" cssclass="LocalGrid_Container" headerstyle-cssclass="LocalGrid_Header" alternatingitemstyle-cssclass="LocalGrid_AlternatingItem" itemstyle-cssclass="LocalGrid_Item">
  <itemstyle verticalalign="Top"/>
  <columns>
   <asp:boundcolumn datafield="Addon" headertext="Addon" />
   <asp:boundcolumn datafield="ExtensionKey" headertext="Key" />
   <asp:boundcolumn datafield="EntryTypes" headertext="Applies To" />
   <asp:boundcolumn datafield="ControlToLoad" headertext="Control" />
   <asp:boundcolumn datafield="Custom" headertext="Custom" />
   <asp:boundcolumn datafield="AccessRights" headertext="Permissions" />
   <asp:templatecolumn>
    <itemtemplate>
     <asp:linkbutton id="cmdEdit" runat="server" text="Edit" CssClass="dnnSecondaryAction" commandname="edit" visible='<%# IIF(DataBinder.Eval(Container, "DataItem.Addon")="Core", "True", "False") %>' commandargument='<%# DataBinder.Eval(Container, "DataItem.Addon") & ":" & DataBinder.Eval(Container, "DataItem.ExtensionKey") %>'/> 
    </ItemTemplate>
   </asp:templatecolumn>
  </Columns>
 </asp:datagrid>

 <p align="right">
  <asp:linkbutton id="cmdAdd" runat="server" CssClass="dnnSecondaryAction" text="Add" resourcekey="cmdAdd" />&nbsp;
  <asp:hyperlink id="cmdBackBottom" runat="server" CssClass="dnnPrimaryAction" borderstyle="None" resourcekey="cmdReturn" Text="Return" />
</p>

</asp:panel>

<asp:panel runat="server" id="pnlEdit" style="padding: 5px;" visible="false">
<table cellspacing="0" cellpadding="5" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plResourceFile" runat="server" controlname="txtResourceFile" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtResourceFile" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plKey" runat="server" controlname="txtExtensionKey" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtExtensionKey" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plAppliesTo" runat="server" controlname="txtEntryTypes" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtEntryTypes" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plControl" runat="server" controlname="ddControls" suffix=":" /></td>
  <td>
   <asp:dropdownlist runat="server" id="ddControls" width="500"/>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plCustom" runat="server" controlname="txtCustom" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtCustom" width="500" />
  </td>
 </tr>
 <tr style="display: none;">
  <td class="DMX_EditTitle SubHead"><dnn:label id="plDownloadUrl" runat="server" controlname="txtDownloadUrl" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtDownloadUrl" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plRolesExecute" runat="server" controlname="ctlAuthRoles" suffix=":" /></td>
  <td>
   <portal:duallist id="ctlAuthRoles" runat="server" listboxwidth="130" listboxheight="130"></portal:duallist>
  </td>
 </tr>
</table>
<p>
<asp:linkbutton id="cmdUpdate" runat="server" CssClass="dnnPrimaryAction" text="Update1" resourcekey="cmdUpdate" />&nbsp;
<asp:linkbutton id="cmdDelete" runat="server" CssClass="dnnSecondaryAction" text="Delete1" resourcekey="cmdDelete" />&nbsp;
<asp:linkbutton id="cmdCancel" runat="server" CssClass="dnnSecondaryAction" text="Cancel1" resourcekey="cmdCancel" />
</p>
</asp:panel>
<input id="hidId" type="hidden" name="hidId" runat="server">
