function repairClasses(){$("table.TreeNode").each(function(){$(this).children(":first").children(":first").children('td[valign="middle"]').addClass($(this).attr("class")).removeClass("TreeNode"),$(this).attr("class","TreeNode")})}$(document).ready(function(){repairClasses()});