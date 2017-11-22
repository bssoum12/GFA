<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShowAttachedFile.ascx.cs" Inherits="VD.Modules.Materials.ShowAttachedFile" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />

<style>
    .btnRedLink
    {
        text-decoration: none;
        color: Red;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }

    .btnGlassLink
    {
        text-decoration: none;
        color: #266D8D;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }

    .header
    {
        height: 20px;
        background-color: #7EACB1;
    }

    .headerText
    {
        color: white;
        font-family: Tahoma;
        font-weight: bold;
        text-align: left;
    }

    .MemoText
    {
        color: black;
        font: message-box;
        font-family: Tahoma;
    }

    .PageBorder
    {
        border: 1px solid #7EACB1;
    }
</style>

<script type="text/javascript"  >

    function AddFileToContainer(callbackData) {
        var data = callbackData.split('|');
        var file = data[0];
        var url = data[1];
        var link = document.createElement('A');
        link.setAttribute( "target", "_blank");
        link.setAttribute( "href", url);
        link.innerHTML = file;
        link.setAttribute( "onclick", "return DXDemo.ShowScreenshotWindow(event, this);");
        var fileContainer = document.getElementById("fileContainer");
        var div = document.createElement('DIV');
        div.appendChild(link);
        fileContainer.appendChild(div);
    }

</script>

<table class="header" style="width:100%;">
    <tr class="headerText" >
        <td>
            <dx:ASPxLabel ID="lblTitle" runat="server" Text="Title" Theme="Glass" Font-Size="14" ></dx:ASPxLabel>
        </td>
    </tr>
</table>
<table style="width:100%;">
    <tr>
        <td>
            <fieldset class="groupBox" style="border: 1px solid #4C90C0;">
            <div id="fileContainer" class="fileContainer"></div>
        </fieldset>
        </td>
    </tr>
</table>



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