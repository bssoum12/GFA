$(document).ready(function(){$.support.opacity&&($("body").append('<ul id="tlyPageGuide" data-tourtitle="Help for this page"></ul>'),$(".dnnHelpText").each(function(){$("#tlyPageGuide").append('<li class="tlypageguide_left" data-tourtarget="#'+$(this).parent().parent().parent().children(":first-child").children(":first-child").attr("id")+'"><div>'+$(this).text()+"</div></li>")}),$(".dnnTooltip").remove(),$(".dnnFormHelp").remove(),$("#tlyPageGuide li").length>0&&tl.pg.init({pageguide_close:"pageguide_close_value",pageguide_toggle:"pageguide_toggle_value"}))});