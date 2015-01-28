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
 */
(function(){var a,b,c,d,e;d={_:{authors:["Christian Juth"],name:"Utilities",version:"0.1.0",min:"0.1.0",compatibility:{chrome:"full",safari:"partial"}},run:function(){var b;return"chrome"===a?(b=chrome.extension.getBackgroundPage(),b.test=function(){return alert(window.message)},b.test(),delete b.test):void 0},reload:function(){return"chrome"===a?chrome.runtime.reload():"safari"===a?(safari.extension.globalPage.contentWindow.reload=function(){return window.console.clear(),location.reload()},safari.extension.globalPage.contentWindow.reload()):void 0},update:function(){return"chrome"===a?chrome.runtime.requestUpdateCheck():void 0}},a="",c=d._.name,b=c.toLowerCase().replace(/\ /g,"_"),e={error:function(a){return function(){return a="Ext plugin ("+c+") says: "+a,ext._.log.error(a)}()},warm:function(a){return function(){return a="Ext plugin ("+c+") says: "+a,ext._.log.warn(a)}()},info:function(a){return function(){return a="Ext plugin ("+c+") says: "+a,ext._.log.info(a)}()}},"function"==typeof window.define&&window.define.amd&&window.define(["ext"],function(e){var f;return a=e._.browser,null==d._.min||d._.min<=window.ext.version?e._.load(b,d):(f=d._.min,console.error("Ext plugin ("+c+") requires ExtJS v"+f+"+"))})}).call(this);