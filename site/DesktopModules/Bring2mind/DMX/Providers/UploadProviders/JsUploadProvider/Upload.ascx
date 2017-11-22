<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Upload.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Upload.JsUploadProvider.Upload" %>

<div class="jsUploadProvider"
 data-id="<%=Guid.NewGuid().ToString%>" 
 data-entryid="<%=Query.EntryId%>"
 data-collectionid="<%=Query.CollectionId%>"
 data-moduleid="<%=ModuleId %>"
 data-tabid="<%=TabId %>"
 data-allowmultiple="<%=AllowMultiple.ToString().ToLower() %>"
 data-resources='<%=SerializedResources()%>'>
</div>
