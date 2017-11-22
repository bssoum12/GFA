<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TokenInputCtrl.ascx.vb" Inherits="VD.Modules.VBFramework.TokenInputCtrl" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
    
<script language="javascript" type="text/javascript">
    var mnoResultsText = '<%=DotNetNuke.Services.Localization.Localization.GetString("mnoResults", ressFilePath)%>';
    var msearchingText = '<%=DotNetNuke.Services.Localization.Localization.GetString("msearching", ressFilePath)%>';
    $(document).ready(function () {
        var serviceurlbase = '';

        if (txtParamUrlService.GetText() == '')
            serviceurlbase = '/DesktopModules/VBFramework/TokenInputService.ashx/?datafrom=all';
        else
            serviceurlbase = '/DesktopModules/VBFramework/TokenInputService.ashx/?datafrom=' + txtParamUrlService.GetText();
        $('#token-input').tokenInput(serviceurlbase, {
            // We can set the tokenLimit here
            theme: "facebook",
            minChars: 1,
            preventDuplicates: true,
            hintText: '',
            noResultsText: mnoResultsText,
            searchingText: msearchingText,
            onAdd: function (item) {
                if (item != null) {
                    if (item.id.startsWith("token-")) {
                        lbtokeninputvalue.AddItem(item.id.substring(6));
                    } else {
                        lbtokeninputvalue.AddItem(item.id);
                        lbtokeninputNewValue.AddItem(item.id);
                    }
                }
            },
            onDelete: function (item) {
                if (item != null) {
                    var str = item.id.replace("token-", "")
                    var selecItem = lbtokeninputvalue.FindItemByValue(str);
                    lbtokeninputvalue.RemoveItem(selecItem.index);
                    lbtokeninputNewValue.RemoveItem(selecItem.index);
                }
            },

            onError: function (xhr, status) {
                displayMessage(status);
            }
        });
    });
    function displayMessage(message) {
        var messageNode = $("<div/>")
                .addClass('dnnFormMessage dnnFormWarning')
                .text(message);

        messageNode.fadeOut(3000, 'easeInExpo', function () {
            messageNode.remove();
        });
    };

    function ShowPopupAddContact() {
        alert('1345');
    }
</script>
<localizeModule:localizeModule ID="localModule" runat="server"/>

<div style=" display:none;  ">
<dx:ASPxTextBox ID="txtParamUrlService" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtParamUrlService" ></dx:ASPxTextBox>
<dx:ASPxListBox ID="lbtokeninputNewValue" runat="server"  ClientIDMode="AutoID" ClientInstanceName="lbtokeninputNewValue"  ValueType="System.String">
</dx:ASPxListBox>
<dx:ASPxListBox ID="lbtokeninputvalue" runat="server"  ClientIDMode="AutoID" ClientInstanceName="lbtokeninputvalue"  ValueType="System.String">
</dx:ASPxListBox>
</div>



<dx:ASPxPopupControl ID="popupNewContact" runat="server" Theme="Glass" HeaderText="Nouveau Contact"
    ClientInstanceName="popupNewContact" PopupHorizontalAlign="WindowCenter"  ClientIDMode="AutoID" 
    PopupVerticalAlign="WindowCenter" Modal="True" Width="300px" >
     <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <asp:PlaceHolder ID="NewContact" runat="server"></asp:PlaceHolder>
        </dx:PopupControlContentControl>
</ContentCollection>
</dx:ASPxPopupControl>
