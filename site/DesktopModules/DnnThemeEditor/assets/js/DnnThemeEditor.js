function reloadStylesheets(tabId) {
    if (navigator.userAgent.indexOf("Firefox") > 0) {
        location.reload(true);
    } else {
        var queryString = '?t=' + tabId + '&reload=' + new Date().getTime();
        var cssUrl = '/DesktopModules/DnnThemeEditor/theme.ashx' + queryString;
        $('#themeeditor_css').attr('href', cssUrl);
        //$('#themeeditor_css').attr('href', '/DesktopModules/DnnThemeEditor/theme.ashx');
    }
} // reloadStylesheets 

function SetupDoc() {
    $(document).ready(function () {
        $('.alert-autocloseable-success').hide();
        $(".basic").spectrum({
            preferredFormat: "rgb",
            showInput: true,
            showAlpha: true,
            showButtons: false,
            chooseText: "Alright",
            cancelText: "No way"
        });
        $(".basic").show();
    }); // doc ready 
} // Setup document function

$('#dte-tab').click(function () {
    $('.toolbar-container').toggle("slide", { direction: "right" }, 400);
}); // open toolbar button

$('.dte-close').click(function () {
    $('.toolbar-container').toggle("slide", { direction: "right" }, 400);
}); // close toolbar button

$(".dte-resize").click(function () {
    if ($(".toolbar-container").hasClass("extend")) {
        $(".toolbar-container").removeClass("extend", { direction: "right" }, 400);
        $("#dte-toolbar").removeClass("extend", { direction: "right" }, 400);

        $(".dte-resize").removeClass("rotateIcon", { direction: "right" }, 400);
    } else {
        $(".toolbar-container").addClass("extend", { direction: "right" }, 400);
        $("#dte-toolbar").addClass("extend", { direction: "right" }, 400);

        $(".dte-resize").addClass("rotateIcon", { direction: "right" }, 400);
        
    }

    
}); // extend toolbar medium

function showSaveAlert() {
    $.confirm({
        title: 'Saved!',
        content: 'The current style has been saved successfully!',
        autoClose: 'Ok|1000',
        buttons: {
            Ok: function () {}
        }
    });
} // showSaveAlert