<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FileTypes.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.FileTypes" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

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

<p style="TEXT-ALIGN:right">
 <asp:hyperlink id="cmdBackTop" runat="server" CssClass="dnnPrimaryAction" borderstyle="None" resourcekey="cmdBack"/>
</p>

<asp:panel runat="server" id="pnlList">

 <asp:datagrid id="dgExtensions" runat="server" autogeneratecolumns="false" borderwidth="0" cellpadding="4" cellspacing="0" cssclass="LocalGrid_Container" headerstyle-cssclass="LocalGrid_Header" alternatingitemstyle-cssclass="LocalGrid_AlternatingItem" itemstyle-cssclass="LocalGrid_Item">
  <itemstyle verticalalign="Top"/>
  <columns>
   <asp:boundcolumn datafield="Addon" headertext="Addon" readonly="true" />
   <asp:templatecolumn headertext="BaseType">
    <itemtemplate>
     <%# IIF(Instr(DataBinder.Eval(Container, "DataItem.ExtensionKey"), ".") = 0, DataBinder.Eval(Container, "DataItem.ExtensionKey"), Left(DataBinder.Eval(Container, "DataItem.ExtensionKey"), Instr(DataBinder.Eval(Container, "DataItem.ExtensionKey"), "."))).TrimEnd("."c) %>
    </itemtemplate>
   </asp:templatecolumn>
   <asp:templatecolumn headertext="SpecificType">
    <itemtemplate>
      <%# IIF(Instr(DataBinder.Eval(Container, "DataItem.ExtensionKey"), ".") = 0, "", Mid(DataBinder.Eval(Container, "DataItem.ExtensionKey"), Instr(DataBinder.Eval(Container, "DataItem.ExtensionKey"), ".")+1)) %>
    </itemtemplate>
   </asp:templatecolumn>
   <asp:boundcolumn datafield="ControlToLoad" headertext="Control" />
   <asp:boundcolumn datafield="Custom" headertext="Extension" />
   <asp:boundcolumn datafield="MimeType" headertext="MimeType" />
   <asp:templatecolumn headertext="DefaultAction">
    <itemtemplate>
     <%# IIF(Bring2mind.DNN.Modules.DMX.Common.GetABoolean(DataBinder.Eval(Container, "DataItem.ViewByDefault")), "View", "Download") %>
    </itemtemplate>
   </asp:templatecolumn>
   <asp:templatecolumn>
    <itemtemplate>
     <asp:linkbutton id="cmdEdit" runat="server" text="Edit" CssClass="dnnSecondaryAction" commandname="edit" visible='<%# IIF(DataBinder.Eval(Container, "DataItem.Addon")="Core" AND (Instr(DataBinder.Eval(Container, "DataItem.ExtensionKey"), ".") > 0), "True", "False") %>' commandargument='<%# DataBinder.Eval(Container, "DataItem.Addon") & ":" & DataBinder.Eval(Container, "DataItem.ExtensionKey") %>'/> 
    </ItemTemplate>
   </asp:templatecolumn>
  </Columns>
 </asp:datagrid>

 <p align="right">
  <asp:linkbutton id="cmdAdd" runat="server" CssClass="dnnSecondaryAction" text="Add" resourcekey="cmdAdd" />&nbsp;
  <asp:hyperlink id="cmdBackBottom" runat="server" CssClass="dnnPrimaryAction" borderstyle="None" resourcekey="cmdBack" />
 </p>

</asp:panel>

<asp:panel runat="server" id="pnlEdit" style="padding: 5px;" visible="false">
<table cellspacing="0" cellpadding="5" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plResourceFile" controlname="txtResourceFile" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtResourceFile" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plBaseType" controlname="ddTypes" suffix=":" /></td>
  <td>
   <asp:dropdownlist runat="server" id="ddTypes" width="150" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plSpecificType" controlname="txtType" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtType" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plExtension" controlname="txtExtensions" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtExtensions" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plMimeType" controlname="txtMimeType" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtMimeType" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plDefaultAction" controlname="optView" suffix=":" /></td>
  <td>
   <asp:radiobutton runat="server" id="optView" groupname="optgrpAction" text="View"/>&nbsp;
   <asp:radiobutton runat="server" id="optDownload" groupname="optgrpAction" text="Download"/>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plIcon16" controlname="txtIcon16" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtIcon16" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plIcon32" controlname="txtIcon32" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtIcon32" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label runat="server" id="plControl" controlname="ddControls" suffix=":" /></td>
  <td>
   <asp:dropdownlist runat="server" id="ddControls" width="500"/>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plDownloadUrl" runat="server" controlname="txtDownloadUrl" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtDownloadUrl" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plReparse" runat="server" controlname="cmdReparse" suffix=":" /></td>
  <td>
   <asp:linkbutton id="cmdReparse" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdReparse" />
  </td>
 </tr>
</table>
<p>
 <asp:linkbutton id="cmdUpdate" runat="server" CssClass="dnnPrimaryAction" resourcekey="cmdUpdate" />&nbsp;
 <asp:linkbutton id="cmdDelete" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdDelete" />&nbsp;
 <asp:linkbutton id="cmdCancel" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdCancel" />
</p>
</asp:panel>
<input id="hidId" type="hidden" name="hidId" runat="server">
