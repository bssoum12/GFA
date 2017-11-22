<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddUnitFamiliesCtrl.ascx.cs" Inherits="VD.Modules.Materials.AddUnitFamiliesCtrl" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server"/>
<accessModule:accessModule ID="AccModule" runat="server"/>
<style  >
    .label_td {
background-color: #D3E9F0;
border: 1px solid #4986A2;
padding-left: 2px;
}

</style>
<table style="width:100%;">
                            <tr>
                                <td style="vertical-align:top;" class="label_td">
                                    <asp:Label ID="lblDesignation" runat="server" Width="100px" Text="Description"></asp:Label>
                                </td>
                                <td>
                                    <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="400" ImageSrc="~/images/expand.gif" Theme="Glass" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top:5px;"  align="right">
                                    <dxe:ASPxButton ID="btnSave" runat="server" Text="Enregistrer" Theme="Glass" AutoPostBack="false" Width="150px"
                                        OnClick="btnSave_Click">
                                    </dxe:ASPxButton>                                    
                                </td>                                
                            </tr>
                                                        
                        </table>

<dxpc:ASPxPopupControl ID="popupValidation" runat="server"
    Theme="Glass"
    HeaderText="Ajouter Système de mesure"
    ClientInstanceName="popupValidation" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="300px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <table width="100%">
                <tr>
                    <td align="center">                        
                        <%=  DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath)  %>  </td>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="button" style="width: 100px" value="Ok" onclick="popupValidation.Hide(); if (window.parent['popupCtrl']) window.parent['popupCtrl'].Hide(); " />
                    </td>
                </tr>
            </table>
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <HeaderTemplate><%= DotNetNuke.Services.Localization.Localization.GetString("popAddUnitFamiles", ressFilePath)%></HeaderTemplate>
</dxpc:ASPxPopupControl>