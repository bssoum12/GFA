<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CategoriesAdd.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.CategoriesAdd" %>

<asp:Label runat="server" ID="lblNewCategoriesHelp" resourcekey="lblNewCategoriesHelp" />
<asp:TextBox runat="server" ID="txtNewCategories" TextMode="MultiLine" Width="380" Rows="30" /><br />

<p style="width:100%;text-align:center;margin-top:30px;">
<asp:LinkButton runat="server" ID="cmdAdd" resourcekey="cmdAdd" CssClass="dnnPrimaryAction" />
<asp:LinkButton runat="server" ID="cmdCancel" resourcekey="cmdCancel" CssClass="dnnSecondaryAction" />
</p>