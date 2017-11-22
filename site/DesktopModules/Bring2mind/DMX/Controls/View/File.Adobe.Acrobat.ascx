<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="File.Adobe.Acrobat.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.View.File_Adobe_Acrobat" %>
<div id="PDFViewerDIV">It appears you don't have Adobe Reader or PDF support in this web browser. <a href="<%=DownloadUrl(EntryId)%>">Click here to download the PDF</a></div>
<script type="text/javascript">

 PDFObject.embed("<%=DownloadUrl(EntryId)%>&method=&local=true", $("#PDFViewerDIV"), {
  pdfOpenParams: {
   navpanes: 0,
   toolbar: 1,
   statusbar: 0,
   view: "FitV"
  }
 });

 adjustPDFBox();
 $("#dlgViewContent").resize(function () { adjustPDFBox() });

 function adjustPDFBox() {
  $("#PDFViewerDIV").width($("#dlgViewContent").width()).height($("#dlgViewContent").height())
  $("#dlgViewContent").css("overflow", "hidden");
 }

</script>