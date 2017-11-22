<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddNewSpec.ascx.cs" Inherits="VD.Modules.Materials.AddNewSpec" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="txtEIFCtrl" TagName="txtEIFCtrl" Src="~/controls/xTextBoxML.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />

<div>
    <table>
        <tr>
            <td colspan="2">
                <dx:ASPxLabel ID="lblAddNewSpecUI" runat="server" Theme="Glass">
                </dx:ASPxLabel>
            </td>
        </tr>
        <tr>
            <td style="vertical-align:top;">
                <dx:ASPxLabel ID="lblNewSpecLib" runat="server" Theme="Glass">
                </dx:ASPxLabel>
            </td>
            <td>
               <txtEIFCtrl:txtEIFCtrl ID="txtEIFCtrl" runat="server" ImageSrc="~/images/expand.gif" Theme="Glass">
               </txtEIFCtrl:txtEIFCtrl>
            </td>
        </tr>
        <tr align="right">
            <td colspan="2">
                <table>
                    <tr>
                        <td>
                            <dx:ASPxButton ID="btnApply" runat="server" Theme="Glass" OnClick="btnApply_Click" >
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnClose" runat="server"  Theme="Glass">
                                <ClientSideEvents Click="function(s,e){
                                    if(window.parent.popupWind){
                                        window.parent.popupWind.Hide();
                                        if(window.parent.RefreshTreeSpec)
                                            window.parent.RefreshTreeSpec();
                                    }
                                    
                                    if(window.parent.window['tlsSpec'])
                                    {
                                        window.parent.window['tlsSpec'].PerformCallback();
                                    }
                                    if(window.parent.dnnModal)
                                        window.parent.dnnModal.load();
                                    }" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
