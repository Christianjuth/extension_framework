/*!
     Copyright 2015 by Christian Juth
This plugin is protected by the MIT licence
 */
(function(){var a,b,c,d;d={_info:{authors:["Christian Juth"],name:"Notification",version:"0.1.0",min:"0.7.0",compatibility:{chrome:"full",safari:"full"}},_aliases:["noti"],basic:function(a,b){return"chrome"===ext.browser?chrome.notifications.create("",{iconUrl:chrome.extension.getURL("icon-128.png"),type:"basic",title:a,message:b},function(){}):"safari"===ext.browser?new Notification(a,{body:b}):void 0},delay:function(a,c,d){return 5e4<parseInt(d)?b.error("timeout too long"):setTimeout(function(){return"chrome"===ext.browser?chrome.notifications.create("",{iconUrl:chrome.extension.getURL("icon-128.png"),type:"basic",title:a,message:c},function(){}):"safari"===ext.browser?new Notification(a,{body:c}):void 0},d)}},c=d._info.name,a=ext.parse.id(c),b={error:function(a){return console.error("Ext plugin ("+c+") says: "+a)},warn:function(a){return console.warn("Ext plugin ("+c+") says: "+a)},info:function(a){return console.warn("Ext plugin ("+c+") says: "+a)}},"function"==typeof window.define&&window.define.amd&&window.define(["ext"],function(){return null==d._info.min||d._info.min<=window.ext.version?window.ext[a]=d:console.error("Ext plugin ("+c+") requires ExtJS v"+d._info.min+"+")})}).call(this);