<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Upload.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Upload.AspnetUploadProvider.Upload" %>

<script language="javascript">
function ChangeTab(newTabValue) {
 //alert('hoi');
 var who = document.getElementsByName("<%= ctlUpload.ClientID %>")[0];
 var who2 = who.cloneNode(false);
 who2.onchange = who.onchange;
 who.parentNode.replaceChild(who2, who);
}
</script>

<asp:FileUpload runat="server" ID="ctlUpload" />


