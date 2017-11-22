//Hide or display pane 
function HideDisplayPane(imageObj, headerId, grdObj) {
    var headerObj = window.document.getElementById(headerId);
    if (grdObj.GetVisible() == true) {
        grdObj.SetVisible(false);
        imageObj.src = imageObj.src.replace('up', 'down');
        headerObj.style.borderBottom = '1px solid #A5C3EF';
    }
    else {
        grdObj.SetVisible(true);
        imageObj.src = imageObj.src.replace('down', 'up');
        headerObj.style.borderBottom = '0px solid Transparent';
    }
}

function HideDisplayPaneDiv(imageObj, headerId, contentId) {
    var headerObj = window.document.getElementById(headerId);
    var contentObj = window.document.getElementById(contentId);
    if (contentObj.style.display == '') {
        imageObj.src = imageObj.src.replace('up', 'down');
        contentObj.style.display = 'none';
        headerObj.style.borderBottom = '1px solid #A5C3EF';
    }
    else {
        imageObj.src = imageObj.src.replace('down', 'up');
        contentObj.style.display = '';
        headerObj.style.borderBottom = '0px solid Transparent';
    };
}

function DisplayPaneDiv(imageObj, headerId, contentId) {
    var headerObj = window.document.getElementById(headerId);
    var contentObj = window.document.getElementById(contentId);
    if (contentObj.style.display == 'none') {
        imageObj.src = imageObj.src.replace('down', 'up');
        contentObj.style.display = '';
        headerObj.style.borderBottom = '0px solid Transparent';
    };
}

function SetPaneDivVisibility(imageObj, headerId, contentId, visible) {
    var headerObj = window.document.getElementById(headerId);
    var contentObj = window.document.getElementById(contentId);
    if (!visible) {
        imageObj.src = imageObj.src.replace('up', 'down');
        contentObj.style.display = 'none';
        headerObj.style.borderBottom = '1px solid #A5C3EF';
    }
    else {
        imageObj.src = imageObj.src.replace('down', 'up');
        contentObj.style.display = '';
        headerObj.style.borderBottom = '0px solid Transparent';
    };
}

function SetEmptyDataMessageVisibility(visible) {
    if (visible) {
        window.document.getElementById("divNoSelectedData").style.display = '';
        window.document.getElementById("divSelectedData").style.display = 'none';
    }
    else {
        window.document.getElementById("divNoSelectedData").style.display = 'none';
        window.document.getElementById("divSelectedData").style.display = '';
    }
}

function getQueryString(name, url) {
    name = name.toString().toUpperCase();
    url = url.toString().toUpperCase();
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(url);
    if (results == null)
        return "";
    else
        return results[1];
}

function addMonths(dateObj, num) {
    var currentMonth = dateObj.getMonth() + dateObj.getFullYear() * 12;
    dateObj.setMonth(dateObj.getMonth() + num);
    var diff = dateObj.getMonth() + dateObj.getFullYear() * 12 - currentMonth;

    // If don't get the right number, set date to 
    // last day of previous month
    if (diff != num) {
        dateObj.setDate(0);
    }
    return dateObj;
}

function addDays(dateObj, num) {
    return new Date(dateObj.getTime() + num * 24 * 60 * 60 * 1000);
}