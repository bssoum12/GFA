<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddCaseDetails.ascx.cs" Inherits="VD.Modules.Materials.AddCaseDetails" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxuc" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="eifHtmlEditor" TagName="eifHtmlEditor" Src="~/controls/xHTMLEditorML.ascx" %>
<%@ Register TagPrefix="eifTextBox" TagName="eifTextBox" Src="~/controls/xTextBoxML.ascx" %>

<style type="text/css">
    .eifTitle
    {
        font-family: 'Segoe UI';
        color: #FF8800;
        font-size: 30px;
        height: 50px;
        font-weight: bold;
    }

    .label_td
    {
        background-color: #D3E9F0;
        border: 1px solid #4986A2;
        padding-left: 2px;
    }

    .label_wf_tdold
    {
        background-color: #CAD9E8;
        border: 1px solid #8ba0bc;
        padding-left: 2px;
    }

    .label_wf_td
    {
        background-color: #D3E9F0;
        border: 1px solid #4986A2;
        padding-left: 2px;
    }

    .groupBox
    {
        /*margin: 5px 0px;*/
        border: solid 1px #7EACB1;
        width: 580px;
        background-color: #F3F4F5;
    }

        .groupBox legend
        {
            margin-left: 20px;
            border-color: #7EACB1;
        }

        .groupBox .fileContainer
        {
            /*height: 150px;*/
            /*padding: 5px 10px;*/
            overflow: auto;
        }

    a
    {
        text-decoration: none;
    }
</style>

<script type="text/javascript" language="javascript">
    var m_EnterComment = '<%= DotNetNuke.Services.Localization.Localization.GetString("mEnterComment", ressFilePath) %>';
    var m_SelectDecision = '<%= DotNetNuke.Services.Localization.Localization.GetString("mSelectDecision", ressFilePath) %>';
    var t_Comments = '<%= DotNetNuke.Services.Localization.Localization.GetString("tComments", ressFilePath) %>';
    var m_ConfirmDelete = '<%= DotNetNuke.Services.Localization.Localization.GetString("mConfirmDelete", ressFilePath) %>';

    function ParentCallback(e) {
        var parentWin = window.parent;
        if(parentWin.ReloadParentData)
            parentWin.ReloadParentData(e);
        if (parentWin.popupWind)
            parentWin.popupWind.Hide();
        if (parentWin.dnnModal)
            parentWin.dnnModal.load();
    }

    function FileUploaded(s, e) {
        if (e.isValid) {
            if (e.callbackData != "")
                AddFileToContainer(e.callbackData);
        }
    }

    function AddFileToContainer(callbackData) {
        var data = callbackData.split('|');
        var file = data[0];
        var url = data[1];
        var link = document.createElement('A');
        link.setAttribute( "target", "_blank");
        link.setAttribute( "href", url);
        link.innerHTML = file;
        link.setAttribute( "onclick", "return DXDemo.ShowScreenshotWindow(event, this);");
        var img = document.createElement('img');
        img.setAttribute( "src", "../../images/delete.gif");
        img.setAttribute( "width", "12px");
        img.setAttribute( "height", "12px");
        img.setAttribute( "style", "padding-left:5px;");
        img.setAttribute( "onclick", "deleteElement(this.parentNode,'" + file + "');");
        var fileContainer = document.getElementById("fileContainer");
        var div = document.createElement('DIV');
        div.appendChild(link);
        div.appendChild(img);
        fileContainer.appendChild(div);
    }

    function deleteElement(p, file) {
        if (confirm(m_ConfirmDelete)) {
            cbEditMaterials.PerformCallback("deleteFile_" + file);
            fileContainer.removeChild(p);
        }
    }

    function SaveMaterialDetails() {
        var filesData = "";
        var fileContainer = document.getElementById("fileContainer");
        var h = 0;
        while (h < fileContainer.childNodes.length) {
            if (filesData != "")
                filesData = filesData + "@@" + fileContainer.childNodes[h].childNodes[0];
            else
                filesData = fileContainer.childNodes[h].childNodes[0];
            h++;
        }
        if (filesData != "")
            cbEditMaterials.PerformCallback(filesData);
    }

</script>

<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="accModule" runat="server" />
<table width="100%" id="TableAjout">
    <tr>
        <td align="center">
            <div style="text-align: left; font-family: Tahoma; font-size: 12px;">
                <table>
                    <tr>
                        <td valign="top" class="label_wf_td">
                            <asp:Label ID="Label2" runat="server" Text="Commentaire :" Style="margin-left: 0px">
                                        <%= DotNetNuke.Services.Localization.Localization.GetString("hNormTitle", ressFilePath)%>
                            </asp:Label>
                        </td>
                        <td align="left">                               
                            <dxe:ASPxLabel ID="lblStandard" runat="server" Theme="Glass"></dxe:ASPxLabel>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td valign="top" class="label_wf_td">
                            <asp:Label ID="Label1" runat="server" Text="Commentaire :" Style="margin-left: 0px">
                            </asp:Label>
                        </td>
                        <td align="left">                               
                            <eifTextBox:eifTextBox ID="txtTitle" runat="server" Width="600" ImageSrc="~/images/expand.gif" Theme="Glass"/>                     
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>                      
                        <td valign="top" class="label_wf_td">
                            <asp:Label ID="lblComment" runat="server" Text="Commentaire :" Style="margin-left: 0px">
                                        <%= DotNetNuke.Services.Localization.Localization.GetString("hDesignation", ressFilePath)%>
                            </asp:Label>
                        </td>
                        <td align="left">
                            <eifHtmlEditor:eifHtmlEditor runat="server" ID="htmlAddComment" Theme="Glass" ImageSrc="~/images/expand.gif" Height="350" Width="600" />
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="label_wf_td" valign="top">
                            <asp:Label ID="lblFile" runat="server" Width="170px" Text="Fichier">
                                    <%= DotNetNuke.Services.Localization.Localization.GetString("mnDocument", ressFilePath)%>
                            </asp:Label>
                        </td>
                        <td>
                            <dxuc:ASPxUploadControl ID="uplFile" runat="server" ClientInstanceName="uploader"
                                Theme="Glass" ShowProgressPanel="False" UploadMode="Standard" Width="600px" OnFileUploadComplete="uplFile_FileUploadComplete">
                                <ValidationSettings MaxFileSize="1024000000"
                                    MaxFileSizeErrorText="Vous avez dépassé la taille maximal de 1Géga Octets!">
                                </ValidationSettings>
                                <ClientSideEvents FileUploadComplete="function(s, e) {FileUploaded(s, e);}"
                                    TextChanged="function(s, e) {uploader.UploadFile();}" />
                                <UploadButton Text="Joindre Fichier">
                                </UploadButton>
                                <CancelButton Text="Annuler">
                                </CancelButton>
                                <AdvancedModeSettings EnableMultiSelect="False"/>
                                <ProgressBarStyle Height="22px">
                                </ProgressBarStyle>
                            </dxuc:ASPxUploadControl>
                            <fieldset class="groupBox">
                                <legend><%= DotNetNuke.Services.Localization.Localization.GetString("lbUploadedFiles", ressFilePath)%></legend>
                                <div id="fileContainer" class="fileContainer"></div>
                            </fieldset>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td align="center">
            <asp:Label ID="lblError" runat="server" ForeColor="red" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="center">
            <table>
                <tr>
                    <td style="width:100%;">&nbsp;</td>
                    <td>
                        <dxe:ASPxButton ID="cmdValider" runat="server" Theme="Glass" OnClick="cmdValider_Click">
                            <ClientSideEvents Click="function(s, e) {SaveMaterialDetails();}" />
                        </dxe:ASPxButton>
                    </td>
                    <td>
                        <dxe:ASPxButton ID="btnCancel" runat="server" Theme="Glass" OnClick="btnCancel_Click">
                            <ClientSideEvents Click="function(s,e){
                                if (window.parent.popupWind) {
                                    window.parent.popupWind.Hide();
                                }
                                if (window.parent.dnnModal)
                                    window.parent.dnnModal.load();
                                }" />
                        </dxe:ASPxButton>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<dxpc:ASPxPopupControl ID="popupValidation" runat="server"
    Theme="Glass"
    ClientInstanceName="popupValidation" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="250px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
            <table>
                <tr>
                    <td>
                        <%= DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath)%>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <dxe:ASPxButton ID="cmdValiderPopup0" runat="server" AutoPostBack="False"
                            CausesValidation="False"
                            Theme="Glass" Text="ok" Width="100px">
                            <ClientSideEvents Click="function(s, e) {
	                        popupValidation.Hide();
                            ParentCallback('case');
}" />
                        </dxe:ASPxButton>
                    </td>
                </tr>
            </table>
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <HeaderTemplate><%= DotNetNuke.Services.Localization.Localization.GetString("lbComment", ressFilePath)%></HeaderTemplate>
</dxpc:ASPxPopupControl>
<dx:ASPxCallback ID="cbEditMaterials" ClientInstanceName="cbEditMaterials" runat="server" OnCallback="cbEditMaterials_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) {
        if(e.parameter=='0')
        {    
            if(e.result != '')
            {
                var attachList = e.result.toString().split('@@');             
                var k=0;
                while(k<attachList.length)
                {
                    if (attachList[k] != '')
                        AddFileToContainer(attachList[k]);
                    k = k+1;
                }
            }
        }
    }" />
</dx:ASPxCallback>
<script>
    window.document.onload = new function () { cbEditMaterials.PerformCallback("0"); }
</script>