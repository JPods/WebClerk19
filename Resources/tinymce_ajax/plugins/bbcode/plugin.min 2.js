!function(){var a={},b=function(b){for(var c=a[b],e=c.deps,f=c.defn,g=e.length,h=new Array(g),i=0;i<g;++i)h[i]=d(e[i]);var j=f.apply(null,h);if(void 0===j)throw"module ["+b+"] returned undefined";c.instance=j},c=function(b,c,d){if("string"!=typeof b)throw"module id must be a string";if(void 0===c)throw"no dependencies for "+b;if(void 0===d)throw"no definition function for "+b;a[b]={deps:c,defn:d,instance:void 0}},d=function(c){var d=a[c];if(void 0===d)throw"module ["+c+"] was undefined";return void 0===d.instance&&b(c),d.instance},e=function(a,b){for(var c=a.length,e=new Array(c),f=0;f<c;++f)e.push(d(a[f]));b.apply(null,b)},f={};f.bolt={module:{api:{define:c,require:e,demand:d}}};var g=c,h=function(a,b){g(a,[],function(){return b})};h("3",tinymce.util.Tools.resolve),g("1",["3"],function(a){return a("tinymce.PluginManager")}),g("2",["3"],function(a){return a("tinymce.util.Tools")}),g("0",["1","2"],function(a,b){return a.add("bbcode",function(){return{init:function(a){var b=this,c=a.getParam("bbcode_dialect","punbb").toLowerCase();a.on("beforeSetContent",function(a){a.content=b["_"+c+"_bbcode2html"](a.content)}),a.on("postProcess",function(a){a.set&&(a.content=b["_"+c+"_bbcode2html"](a.content)),a.get&&(a.content=b["_"+c+"_html2bbcode"](a.content))})},getInfo:function(){return{longname:"BBCode Plugin",author:"Ephox Corp",authorurl:"http://www.tinymce.com",infourl:"http://www.tinymce.com/wiki.php/Plugin:bbcode"}},_punbb_html2bbcode:function(a){function c(b,c){a=a.replace(b,c)}return a=b.trim(a),c(/<a.*?href=\"(.*?)\".*?>(.*?)<\/a>/gi,"[url=$1]$2[/url]"),c(/<font.*?color=\"(.*?)\".*?class=\"codeStyle\".*?>(.*?)<\/font>/gi,"[code][color=$1]$2[/color][/code]"),c(/<font.*?color=\"(.*?)\".*?class=\"quoteStyle\".*?>(.*?)<\/font>/gi,"[quote][color=$1]$2[/color][/quote]"),c(/<font.*?class=\"codeStyle\".*?color=\"(.*?)\".*?>(.*?)<\/font>/gi,"[code][color=$1]$2[/color][/code]"),c(/<font.*?class=\"quoteStyle\".*?color=\"(.*?)\".*?>(.*?)<\/font>/gi,"[quote][color=$1]$2[/color][/quote]"),c(/<span style=\"color: ?(.*?);\">(.*?)<\/span>/gi,"[color=$1]$2[/color]"),c(/<font.*?color=\"(.*?)\".*?>(.*?)<\/font>/gi,"[color=$1]$2[/color]"),c(/<span style=\"font-size:(.*?);\">(.*?)<\/span>/gi,"[size=$1]$2[/size]"),c(/<font>(.*?)<\/font>/gi,"$1"),c(/<img.*?src=\"(.*?)\".*?\/>/gi,"[img]$1[/img]"),c(/<span class=\"codeStyle\">(.*?)<\/span>/gi,"[code]$1[/code]"),c(/<span class=\"quoteStyle\">(.*?)<\/span>/gi,"[quote]$1[/quote]"),c(/<strong class=\"codeStyle\">(.*?)<\/strong>/gi,"[code][b]$1[/b][/code]"),c(/<strong class=\"quoteStyle\">(.*?)<\/strong>/gi,"[quote][b]$1[/b][/quote]"),c(/<em class=\"codeStyle\">(.*?)<\/em>/gi,"[code][i]$1[/i][/code]"),c(/<em class=\"quoteStyle\">(.*?)<\/em>/gi,"[quote][i]$1[/i][/quote]"),c(/<u class=\"codeStyle\">(.*?)<\/u>/gi,"[code][u]$1[/u][/code]"),c(/<u class=\"quoteStyle\">(.*?)<\/u>/gi,"[quote][u]$1[/u][/quote]"),c(/<\/(strong|b)>/gi,"[/b]"),c(/<(strong|b)>/gi,"[b]"),c(/<\/(em|i)>/gi,"[/i]"),c(/<(em|i)>/gi,"[i]"),c(/<\/u>/gi,"[/u]"),c(/<span style=\"text-decoration: ?underline;\">(.*?)<\/span>/gi,"[u]$1[/u]"),c(/<u>/gi,"[u]"),c(/<blockquote[^>]*>/gi,"[quote]"),c(/<\/blockquote>/gi,"[/quote]"),c(/<br \/>/gi,"\n"),c(/<br\/>/gi,"\n"),c(/<br>/gi,"\n"),c(/<p>/gi,""),c(/<\/p>/gi,"\n"),c(/&nbsp;|\u00a0/gi," "),c(/&quot;/gi,'"'),c(/&lt;/gi,"<"),c(/&gt;/gi,">"),c(/&amp;/gi,"&"),a},_punbb_bbcode2html:function(a){function c(b,c){a=a.replace(b,c)}return a=b.trim(a),c(/\n/gi,"<br />"),c(/\[b\]/gi,"<strong>"),c(/\[\/b\]/gi,"</strong>"),c(/\[i\]/gi,"<em>"),c(/\[\/i\]/gi,"</em>"),c(/\[u\]/gi,"<u>"),c(/\[\/u\]/gi,"</u>"),c(/\[url=([^\]]+)\](.*?)\[\/url\]/gi,'<a href="$1">$2</a>'),c(/\[url\](.*?)\[\/url\]/gi,'<a href="$1">$1</a>'),c(/\[img\](.*?)\[\/img\]/gi,'<img src="$1" />'),c(/\[color=(.*?)\](.*?)\[\/color\]/gi,'<font color="$1">$2</font>'),c(/\[code\](.*?)\[\/code\]/gi,'<span class="codeStyle">$1</span>&nbsp;'),c(/\[quote.*?\](.*?)\[\/quote\]/gi,'<span class="quoteStyle">$1</span>&nbsp;'),a}}}),function(){}}),d("0")()}();