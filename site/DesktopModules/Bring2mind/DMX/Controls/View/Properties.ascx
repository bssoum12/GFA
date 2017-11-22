<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Properties.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.View.Properties" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<div style="padding:20px;">

      <ComponentArt:TabStrip id="TabStrip1" AutoTheming="true"
        MultiPageId="MultiPage1"
        runat="server">
      </ComponentArt:TabStrip>
      <ComponentArt:MultiPage id="MultiPage1" CssClass="MultiPage" runat="server">
      </ComponentArt:MultiPage>

</div>