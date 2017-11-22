<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CategoriesOld.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.CategoriesOld" %>
<%@ Import Namespace="Bring2mind.DNN.Modules.DMX.Common" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table>
<tr>
<td><dnn:label id="plUpdateNames" runat="server" controlname="txtVersions" suffix=":" /></td>
<td><asp:CheckBox ID="chkUpdateNames" runat="server" Checked="true" /></td>
</tr>
</table>

<asp:DataGrid runat="server" ID="dgCategories" AllowPaging="false" AutoGenerateColumns="false" ShowHeader="false" OnItemCommand="gridClicked">
 <Columns>
  <asp:TemplateColumn>
   <ItemTemplate>
    <asp:CheckBox runat="server" ID="chkChecked" />
   </ItemTemplate>
  </asp:TemplateColumn>
  <asp:TemplateColumn>
   <ItemTemplate>
    <%# "&nbsp;&gt;&nbsp;".Repeat(DataBinder.Eval(Container, "DataItem.Level")-1)%>
    <asp:TextBox runat="server" ID="txtName" Text='<%#DataBinder.Eval(Container, "DataItem.CategoryName")%>' Width="250" />
    <asp:HiddenField runat="server" ID="hidId" Value='<%#DataBinder.Eval(Container, "DataItem.CategoryId")%>' />
   </ItemTemplate>
  </asp:TemplateColumn>
  <asp:TemplateColumn>
   <ItemTemplate>
    <div style="display:<%# IIF(CInt(DataBinder.Eval(Container, "DataItem.ViewOrder"))>0, "inline", "none")%>">
     <asp:ImageButton runat="server" ID="cmdUp" AlternateText="" ImageUrl="~/images/up.gif" ResourceKey="up" CommandName="U" CommandArgument='<%#DataBinder.Eval(Container, "DataItem.CategoryId")%>' />
    </div>
   </ItemTemplate>
  </asp:TemplateColumn>
  <asp:TemplateColumn>
   <ItemTemplate>
     <asp:ImageButton runat="server" ID="cmdDown" AlternateText="" ImageUrl="~/images/dn.gif" ResourceKey="down" CommandName="D" CommandArgument='<%#DataBinder.Eval(Container, "DataItem.CategoryId")%>' />
   </ItemTemplate>
  </asp:TemplateColumn>
  <asp:TemplateColumn>
   <ItemTemplate>
    <div style="display:<%# IIF(CInt(DataBinder.Eval(Container, "DataItem.Level"))>1, "inline", "none")%>">
     <asp:ImageButton runat="server" ID="cmdLeft" AlternateText="" ImageUrl="~/images/lt.gif" ResourceKey="left" CommandName="L" CommandArgument='<%#DataBinder.Eval(Container, "DataItem.CategoryId")%>' />
    </div>
   </ItemTemplate>
  </asp:TemplateColumn>
  <asp:TemplateColumn>
   <ItemTemplate>
    <div style="display:<%# IIF(CInt(DataBinder.Eval(Container, "DataItem.ViewOrder"))>0, "inline", "none")%>">
     <asp:ImageButton runat="server" ID="cmdRight" AlternateText="" ImageUrl="~/images/rt.gif" ResourceKey="right" CommandName="R" CommandArgument='<%#DataBinder.Eval(Container, "DataItem.CategoryId")%>' />
    </div>
   </ItemTemplate>
  </asp:TemplateColumn>
 </Columns>
</asp:DataGrid>

<p style="width:100%;text-align:center;margin-top:30px;">
 <asp:linkbutton id="cmdReturn" runat="server" cssclass="dnnPrimaryAction" resourcekey="cmdReturn" CausesValidation="false" />
 <asp:linkbutton id="cmdDelete" runat="server" cssclass="dnnSecondaryAction" resourcekey="cmdDeleteSelected" CausesValidation="false" />
</p>


