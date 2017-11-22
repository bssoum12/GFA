<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Upload.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Upload.RadUploadProvider.Upload" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn" %>

<script language="javascript">
 function ChangeTab(newTabValue) {
  var upload = GetRadUpload('<%= ctlUpload.ClientID %>');
  var fileInputs = upload.GetFileInputs();
  for (var i = 0; i < fileInputs.length; i++) {
   upload.ClearFileInputAt(i);
  }
 }
</script>

<dnn:DnnProgressManager ID="ctlProgressManager" runat="server" />
<dnn:DnnAsyncUpload ID="ctlUpload" runat="server"
  InitialFileInputsCount="1"
  MultipleFileSelection="Automatic"
  ControlObjectsVisibility="Default" 
  />
<dnn:DnnProgressArea ID="ctlProgress" runat="server" DisplayCancelButton="True" Visible="true" RefreshPeriod="10" />

