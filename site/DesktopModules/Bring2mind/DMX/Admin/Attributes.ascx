<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Attributes.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.Attributes" %>
<%@ Register TagPrefix="dmx" Assembly="Bring2mind.DNN.Modules.DMX.Core" Namespace="Bring2mind.DNN.Modules.DMX.UI.WebControls" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<style>
td.DMX_EditTitle
{
 white-space: nowrap;
 padding-right: 20px;
}
</style>

<h1><asp:Label runat="server" ID="lblScope" /></h1>

<asp:Panel runat="server" ID="pnlList">
<table cellspacing="0" cellpadding="5" border="0" runat="server" id="tblCollection">
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plInherit" runat="server" controlname="chkInherit" suffix=":" /></td>
  <td>
   <asp:CheckBox runat="server" ID="chkInherit" AutoPostBack="True" />
  </td>
 </tr>
</table>
 <asp:DataList runat="server" ID="dlAttributes" DataKeyField="AttributeId">
 <HeaderTemplate>
<table cellpadding="4" cellspacing="1">
 <tr>
  <th />
  <th><asp:Label runat="server" ID="lblName" resourcekey="lblName" /></th>
  <th><asp:Label runat="server" ID="lblKey" resourcekey="lblKey" /></th>
  <th><asp:Label runat="server" ID="lblValueType" resourcekey="lblValueType" /></th>
  <th><asp:Label runat="server" ID="lblRequired" resourcekey="lblRequired" /></th>
  <th style='display:<%=IIF(CollectionId=-1, "none", "block")%>'><asp:Label runat="server" ID="lblInherited" resourcekey="lblInherited" /></th>
 </tr>
 </HeaderTemplate>
 <ItemTemplate>
  <tr>
   <td width="75">
    <asp:imagebutton id="cmdEditAttribute" runat="server" causesvalidation="false" commandname="Edit"	imageurl="~/images/edit.gif" alternatetext="Edit" resourcekey="cmdEdit" />
    <asp:imagebutton id="cmdUp" runat="server" causesvalidation="false" commandname="Up"	imageurl="~/images/up.gif" alternatetext="Up" resourcekey="cmdUp" />
    <asp:imagebutton id="cmdDown" runat="server" causesvalidation="false" commandname="Down"	imageurl="~/images/dn.gif" alternatetext="Down" resourcekey="cmdDown" />
   </td>
   <td><%#DataBinder.Eval(Container.DataItem, "AttributeName")%></td>
   <td><%#IIf(Bring2mind.DNN.Modules.DMX.Common.GetAString(DataBinder.Eval(Container.DataItem, "Key")) = "", "att" & DataBinder.Eval(Container.DataItem, "AttributeId"), DataBinder.Eval(Container.DataItem, "Key"))%></td>
   <td><%#DataBinder.Eval(Container.DataItem, "ValueType")%></td>
   <td><img src="<%#ResolveUrl("~/images/" & CStr(IIF(CType(DataBinder.Eval(Container.DataItem, "Required"), Boolean), "checked.gif", "unchecked.gif")))%>" alt="req" border="0"/></td>
   <td style='display:<%=IIF(CollectionId=-1, "none", "block")%>'><img src="<%#ResolveUrl("~/images/" & CStr(IIF(CType(DataBinder.Eval(Container.DataItem, "CollectionId"), Integer)=CollectionId, "unchecked.gif", "checked.gif")))%>" alt="req" border="0"/></td>
  </tr>  
 </ItemTemplate>
 <FooterTemplate>
</table>
 </FooterTemplate>
 </asp:DataList>
 <p style="margin: 20px 0px 0px 0px;">
  <asp:LinkButton runat="server" ID="cmdReturn" resourcekey="cmdReturn" CssClass="dnnPrimaryAction" CausesValidation="false" />
  <asp:LinkButton runat="server" ID="cmdAdd" resourcekey="cmdAdd" CssClass="dnnSecondaryAction" CausesValidation="false" />
 </p>
</asp:Panel>
<asp:Panel runat="server" ID="pnlEdit">
<asp:HiddenField runat="server" ID="hidAttributeId" />
<table cellspacing="0" cellpadding="5" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plName" runat="server" controlname="txtName" suffix=":" /></td>
  <td>
   <dmx:ShortTextEdit runat="server" id="steAttName" width="200px" RebindOnPostback="False" ManualUpdate="True" StartMaximized="False" Required="true" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plType" runat="server" controlname="ddTypes" suffix=":" /></td>
  <td>
   <asp:dropdownlist runat="server" id="ddTypes" width="500" AutoPostBack="true">
     <asp:ListItem Value="String" Text="String" resourcekey="optString" />
     <asp:ListItem Value="Boolean" Text="Boolean" resourcekey="optBoolean" />
     <asp:ListItem Value="Integer" Text="Integer" resourcekey="optInteger" />
     <asp:ListItem Value="Double" Text="Floating point" resourcekey="optDouble" />
     <asp:ListItem Value="Date" Text="Date" resourcekey="optDate" />
     <asp:ListItem Value="Select" Text="Selection" resourcekey="optSelect" />
     <asp:ListItem Value="Custom" Text="Custom" resourcekey="optCustom" />
   </asp:dropdownlist>
  </td>
 </tr>
 <tr runat="server" id="trControlToLoad">
  <td class="DMX_EditTitle SubHead"><dnn:label id="plControlToLoad" runat="server" controlname="txtControlToLoad" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtControlToLoad" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plValues" runat="server" controlname="txtValues" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtValues" width="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plRequired" runat="server" controlname="chkRequired" suffix=":" /></td>
  <td>
   <asp:checkbox runat="server" id="chkRequired" resourcekey="chkRequired" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plAppliesTo" runat="server" controlname="txtEntryTypes" suffix=":" /></td>
  <td>
   <asp:textbox runat="server" id="txtEntryTypes" width="500" textmode="MultiLine" height="50"/>
  </td>
 </tr>
</table>

<p style="margin: 20px 0px 0px 0px;">
 <asp:LinkButton runat="server" ID="cmdUpdate" resourcekey="cmdUpdate" CssClass="dnnPrimaryAction" />
 <asp:LinkButton runat="server" ID="cmdCancel" resourcekey="cmdCancel" CssClass="dnnSecondaryAction" CausesValidation="false" />
 <asp:LinkButton runat="server" ID="cmdDelete" resourcekey="cmdDelete" CssClass="dnnSecondaryAction" CausesValidation="false" />
</p>

</asp:Panel>




