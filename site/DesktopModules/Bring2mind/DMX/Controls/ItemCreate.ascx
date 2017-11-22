<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ItemCreate.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.ItemCreate" %>
<%@ Register TagPrefix="dmx" TagName="URL" Src="Url.ascx" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<script language="javascript">
function TabSelect(sender, eventArgs)
{
 ChangeTab(eventArgs.get_tab().get_value())
}
</script>

<ComponentArt:TabStrip id="tsUpload" 
  AutoTheming="true"
  DefaultGroupTabSpacing="1"
  ImagesBaseUrl="images/"
  MultiPageId="mpUpload"
  runat="server">
 <ClientEvents>
  <TabSelect EventHandler="TabSelect" />
 </ClientEvents>
 <Tabs>
  <ComponentArt:TabStripTab runat="server" ID="File" Value="File" PageViewId="pgFile" />
  <ComponentArt:TabStripTab runat="server" ID="Collection" Value="Collection" PageViewId="pgCollection" />
  <ComponentArt:TabStripTab runat="server" ID="Hyperlink" Value="Hyperlink" PageViewId="pgHyperlink" />
 </Tabs>
</ComponentArt:TabStrip>

<p>&nbsp;</p>

<ComponentArt:MultiPage id="mpUpload" CssClass="MultiPage" runat="server">
 <ComponentArt:PageView ID="pgFile" CssClass="PageContent" runat="server">
 <p>
  <div runat="server" ID="divUpload" />
 </p>
 <p>
  <asp:Label runat="server" ID="lblFileUploaded" />
  <asp:LinkButton runat="server" ID="cmdRemoveUploadedFile" resourcekey="cmdRemoveUploadedFile" Visible="false" />
 </p>
 </ComponentArt:PageView>
 <ComponentArt:PageView ID="pgCollection" CssClass="PageContent" runat="server">
 </ComponentArt:PageView>
 <ComponentArt:PageView ID="pgHyperlink" CssClass="PageContent" runat="server">
  <dmx:url id="ctlURL" runat="server" width="300" />   
 </ComponentArt:PageView>
</ComponentArt:MultiPage>
