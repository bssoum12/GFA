<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddonSettings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.AddonSettings" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<ComponentArt:TabStrip id="tsSettings" 
  CssClass="TopGroup1"
  DefaultItemLookId="DefaultTabLook"
  DefaultSelectedItemLookId="SelectedTabLook"
  DefaultDisabledItemLookId="DisabledTabLook"
  DefaultGroupTabSpacing="1"
  ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/CA/tabstrip/"
  MultiPageId="SettingsPages"
  runat="server">
<ItemLooks>
  <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="DefaultTab1" HoverCssClass="DefaultTabHover1" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="5" LabelPaddingBottom="4" LeftIconUrl="tab_left_icon.gif" RightIconUrl="tab_right_icon.gif" HoverLeftIconUrl="hover_tab_left_icon.gif" HoverRightIconUrl="hover_tab_right_icon.gif" LeftIconWidth="3" LeftIconHeight="21" RightIconWidth="3" RightIconHeight="21" />
  <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="SelectedTab1" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="4" LabelPaddingBottom="4" LeftIconUrl="selected_tab_left_icon.gif" RightIconUrl="selected_tab_right_icon.gif" LeftIconWidth="3" LeftIconHeight="21" RightIconWidth="3" RightIconHeight="21" />
</ItemLooks>
</ComponentArt:TabStrip>
<ComponentArt:MultiPage id="SettingsPages" CssClass="MultiPage" runat="server">
</ComponentArt:MultiPage>

<p><asp:Label runat="server" ID="lblNoAddons" /></p>

<p>
 <asp:linkbutton class="dnnPrimaryAction" id="cmdUpdateOptions" runat="server" causesvalidation="False" borderstyle="none" text="Update" resourcekey="cmdUpdate" />&nbsp; 
 <asp:linkbutton id="cmdCancelOptions" runat="server" CssClass="dnnSecondaryAction" causesvalidation="False" borderstyle="none" text="Cancel" resourcekey="cmdCancel" />
</p>
