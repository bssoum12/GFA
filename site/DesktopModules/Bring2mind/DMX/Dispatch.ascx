<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Dispatch.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Dispatch" %>
<asp:PlaceHolder runat="server" ID="plhContent" />
<p class="RssButton">
 <asp:HyperLink runat="server" ID="hlRss">
  <asp:Image runat="server" ID="imgRss" ImageUrl="~/images/rss.gif" AlternateText="RSS" BorderWidth="0" />
 </asp:HyperLink>
</p>