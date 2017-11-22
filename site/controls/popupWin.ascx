<%@ Control Language="VB" AutoEventWireup="false" CodeBehind="popupWin.ascx.vb" Inherits="VD.Modules.VBFramework.popupWin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxe" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxwgv" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxcp" %>
 <%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxpc" %>
 <%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxp" %>
<dxpc:ASPxPopupControl ID="popupWind" runat="server" 
     Theme="Glass" 
     HeaderText="Document" 
    ClientInstanceName="popupWind" PopupHorizontalAlign="WindowCenter" 
    PopupVerticalAlign="WindowCenter" Height="650px" Width="730px" CloseAction="CloseButton" 
    Modal="True" EnableClientSideAPI="True" AllowDragging="True" 
    EnableHierarchyRecreation="True">    
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl1" BackColor="#EDF3F4" runat="server">                
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <ClientSideEvents CloseUp="function(s,e){
              try
              {
                if(window.frames[0].PopupClosed)
                    window.frames[0].PopupClosed();
              }
              catch(err)
              {}        
            }" Closing="function(s, e) {
            popupWind.SetContentUrl('');
    }" />
    <closebuttonimage height="17px" width="17px" />
    <HeaderStyle Font-Bold="True">
    <paddings paddingleft="10px" paddingright="6px" paddingtop="1px" />
    </HeaderStyle>
</dxpc:ASPxPopupControl>
