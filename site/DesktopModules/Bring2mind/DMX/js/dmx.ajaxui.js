!function(e){function o(n){if(t[n])return t[n].exports;var i=t[n]={i:n,l:!1,exports:{}};return e[n].call(i.exports,i,i.exports,o),i.l=!0,i.exports}var t={};o.m=e,o.c=t,o.i=function(e){return e},o.d=function(e,t,n){o.o(e,t)||Object.defineProperty(e,t,{configurable:!1,enumerable:!0,get:n})},o.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return o.d(t,"a",t),t},o.o=function(e,o){return Object.prototype.hasOwnProperty.call(e,o)},o.p="/js/",o(o.s=8)}([function(e,o){e.exports=jQuery},,,function(e,o){window.endsWith=function(e,o){return!(o.length>e.length)&&e.indexOf(o)==e.length-o.length}},function(e,o){function t(e,o){this.moduleId=o.moduleId,this.baseServicepath=e.dnnSF(this.moduleId).getServiceRoot("Bring2mind/DMX"),this.ajaxCall=function(t,n,i,r,a,s,d,l){void 0==l&&(l=!0),e.ajax({type:t,async:l,url:this.baseServicepath+"/"+n+"/"+i,headers:{ModuleId:this.moduleId,TabId:o.tabId,RequestVerificationToken:e('[name="__RequestVerificationToken"]').val(),EntryId:r},data:a}).done(function(e){void 0!=s&&s(e)}).fail(function(e,o){void 0!=d&&d(e.responseText)})},this.getPermissions=function(e,o,t,n){this.ajaxCall("GET","Entries","Permissions",e,null,o,t,n)},this.getResources=function(e){this.ajaxCall("GET","Resources","Get",null,null,e)}}e.exports=t},,,,function(e,o,t){(function(e){var o=t(4);t(3);e(document).ready(function(){DMX.loadData()}),window.DMX={service:{},permissions:{},activeUploads:0,uploaded:[],replaced:[],blocked:[],loadData:function(){if("undefined"!=typeof dmxData){this.service=new o(e,dmxData);var t=this;if(void 0==dmxData)return;dmxData.dnnVer>=8&&this.service.getResources(function(e){t.resources=JSON.parse(e)})}},getPermissions:function(e){if(void 0!=this.permissions[e])return this.permissions[e];var o=this;this.service.getPermissions(e,function(t){return o.permissions[e]=t,t},void 0,!1)},hookDragAndDrop:function(o){if(void 0!=dmxData){-1==o&&(o=dmxData.selectedId);var t=this,n=this.getPermissions(o);new ss.SimpleUpload({dropzone:dmxData.gridId,url:t.service.baseServicepath+"/Entries/Upload",name:"uploadfile",responseType:"json",multipart:!0,multiple:!0,maxUploads:1,queue:!0,maxSize:dmxData.maxLength/1024,customHeaders:{ModuleId:dmxData.moduleId,TabId:dmxData.tabId,RequestVerificationToken:e('[name="__RequestVerificationToken"]').val(),EntryId:-1,CollectionId:o},onChange:function(e,o,n,i,r){t.activeUploads=t.activeUploads+1},onSubmit:function(e){return n.Permissions.CanAdd?(t.showProgress(0,e),!0):(alert(t.resources.NoAddPermission),t.activeUploads=t.activeUploads-1,!1)},onProgress:function(e){t.showProgress(e)},onComplete:function(o,n){if(t.activeUploads=t.activeUploads-1,t.uploaded=t.uploaded.concat(n.Uploaded),t.replaced=t.replaced.concat(n.Replaced),t.blocked=t.blocked.concat(n.Blocked),0==t.activeUploads){var i="",r=!1;t.uploaded.length>0&&(i=i+t.resources.Uploaded+": "+t.uploaded.join(", ")+"\r\n"),t.replaced.length>0&&(i=i+t.resources.Replaced+": "+t.replaced.join(", ")+"\r\n",r=!0),t.blocked.length>0&&(i=i+t.resources.Blocked+": "+t.blocked.join(", ")+"\r\n",r=!0),r&&alert(i),t.uploaded=[],t.replaced=[],t.blocked=[]}0==this.getQueueSize()&&(TreeView1.get_selectedNode().Select(),e("#dmxProgressModal").modal("hide"))},onAbort:function(e,o,n){t.activeUploads=t.activeUploads-1},onSizeError:function(e,o){alert(t.resources.FileTooBig)},onError:function(o,n,i,r,a,s,d){t.activeUploads=t.activeUploads-1,alert(a),e("#dmxProgressModal").modal("hide")}})}},showProgress:function(o,t){void 0!=t&&(e("#dmxProgressFilename").text(t),e("#dmxProgressModal").modal("show")),e("#dmxProgressBar").attr("aria-valuenow",o),e("#dmxProgressBar").width(o+"%"),e("#dmxProgressBar").text(o+"%")}}}).call(o,t(0))}]);