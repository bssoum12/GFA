<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="xHTMLEditorML.ascx.vb" Inherits="VD.Modules.VBFramework.xHTMLEditorML" %>
<script>
    function SwitchButtonClick(s) {
        if (s.src.indexOf('collapse') != -1) { s.src = '../../images/expand.gif'; }
        else { s.src = '../../images/collapse.gif'; };
        var navName = navigator.appName;
        var obj;
        //s.parentNode.parentNode.parentNode.parentNode.style.display = 'none';
        if (navName != 'Microsoft Internet Explorer')
            obj = s.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling;
        else
            obj = s.parentNode.parentNode.parentNode.parentNode.nextSibling;
        if (obj.style.display == '') { obj.style.display = 'none'; } else { obj.style.display = ''; };
    }
</script>