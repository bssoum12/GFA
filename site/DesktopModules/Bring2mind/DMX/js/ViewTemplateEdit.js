function changeTemplate(e){var t=document.getElementById(ddTemplateId);checkSave(),ContentCallBack.Callback(t.options[t.selectedIndex].value,e),template=e}function checkSave(){""!=templateContent&&(confirm(confirmSave)?saveTemplate():(templateContent="",document.getElementById("cmdSave").disabled=!0))}function templateChanged(e){templateContent=e,document.getElementById("cmdSave").disabled=!1}function saveTemplate(){var e=document.getElementById(ddTemplateId);SaveCallBack.Callback(e.options[e.selectedIndex].value,template,templateContent),templateContent="",document.getElementById("cmdSave").disabled=!0}var templateContent="",template="PageTemplate [Template]";