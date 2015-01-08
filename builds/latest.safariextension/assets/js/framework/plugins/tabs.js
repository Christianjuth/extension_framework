/*!
The MIT License (MIT)

Copyright (c) 2014 Christian Juth

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

https://github.com/Christianjuth/
 */
(function(){var a,b,c,d;d={_info:{authors:["Christian Juth"],name:"Tabs",version:"0.1.0",min:"0.1.0",compatibility:{chrome:"full",safari:"full"}},create:function(a,b){return"chrome"===ext.browser&&b?chrome.tabs.create({url:a,active:!0}):"safari"===ext.browser&&b?safari.application.activeBrowserWindow.openTab().url=a:window.location.href=a},dump:function(a){return"chrome"===ext.browser?chrome.tabs.query({},a):"safari"===ext.browser&&setTimeout(function(a){var b,c,d,e,f;for(b=[],f=safari.application.browserWindows,d=0,e=f.length;e>d;d++)c=f[d],b=b.concat(c.tabs);return a(b)},0,a),!0},indexOf:function(a,b){var c,d,e,f,g,h,i,j,k,l;if(e=[],c=[],"chrome"===ext.browser)chrome.tabs.query({},function(d){var e,f,g,h;for(g=0,h=d.length;h>g;g++)e=d[g],f=e.url.replace(/\/$/,""),ext.match.url(f,a)!==!1&&c.push(e);return b(c)});else if("safari"===ext.browser){for(l=safari.application.browserWindows,h=0,j=l.length;j>h;h++)g=l[h],e=e.concat(g.tabs);for(i=0,k=e.length;k>i;i++)d=e[i],null!=d.url&&(f=d.url.replace(/\/$/,""),ext.match.url(f,a)!==!1&&c.push(d));b(c)}return a}},c=d._info.name,a=c.toLowerCase().replace(/\ /g,"_"),b={error:function(a){return console.error("Ext plugin ("+c+") says: "+a)},warn:function(a){return console.warn("Ext plugin ("+c+") says: "+a)},info:function(a){return console.warn("Ext plugin ("+c+") says: "+a)}},"function"==typeof window.define&&window.define.amd&&window.define(["ext"],function(){return null==d._info.min||d._info.min<=window.ext.version?window.ext[a]=d:console.error("Ext plugin ("+c+") requires ExtJS v"+d._info.min+"+")})}).call(this);