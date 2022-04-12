//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 08:51:46
// ----------------------------------------------------
// Method: Method: NTKString__InitHTMLEntities
// Description
// 
//
// Parameters
// ----------------------------------------------------
// (PM) STR_InitHTMLEntities
// Initializes an array with the HTML entities for Latin1

C_BOOLEAN:C305(<>HTML_Entities_Initialized)

If (<>HTML_Entities_Initialized=False:C215)
	
	<>HTML_Entities_Initialized:=True:C214
	
	// Fill an array with the characters that need substitution
	// The index matches the codepoint within ISO Latin 1 encoding
	ARRAY TEXT:C222(<>HTML_Entities; 255)
	
	<>HTML_Entities{34}:="&quot;"
	<>HTML_Entities{38}:="&amp;"
	<>HTML_Entities{39}:="&apos;"
	<>HTML_Entities{60}:="&lt;"
	<>HTML_Entities{62}:="&gt;"
	<>HTML_Entities{160}:="&nbsp;"
	<>HTML_Entities{161}:="&iexcl;"
	<>HTML_Entities{162}:="&cent;"
	<>HTML_Entities{163}:="&pound;"
	<>HTML_Entities{164}:="&curren;"
	<>HTML_Entities{165}:="&yen;"
	<>HTML_Entities{166}:="&brvbar;"
	<>HTML_Entities{167}:="&sect;"
	<>HTML_Entities{168}:="&uml;"
	<>HTML_Entities{169}:="&copy;"
	<>HTML_Entities{170}:="&ordf;"
	<>HTML_Entities{171}:="&laquo;"
	<>HTML_Entities{172}:="&not;"
	<>HTML_Entities{173}:="&shy;"
	<>HTML_Entities{174}:="&reg;"
	<>HTML_Entities{175}:="&macr;"
	<>HTML_Entities{176}:="&deg;"
	<>HTML_Entities{177}:="&plusmn;"
	<>HTML_Entities{178}:="&sup2;"
	<>HTML_Entities{179}:="&sup3;"
	<>HTML_Entities{180}:="&acute;"
	<>HTML_Entities{181}:="&micro;"
	<>HTML_Entities{182}:="&para;"
	<>HTML_Entities{183}:="&middot;"
	<>HTML_Entities{184}:="&cedil;"
	<>HTML_Entities{185}:="&sup1;"
	<>HTML_Entities{186}:="&ordm;"
	<>HTML_Entities{187}:="&raquo;"
	<>HTML_Entities{188}:="&frac14;"
	<>HTML_Entities{189}:="&frac12;"
	<>HTML_Entities{190}:="&frac34;"
	<>HTML_Entities{191}:="&iquest;"
	<>HTML_Entities{192}:="&Agrave;"
	<>HTML_Entities{193}:="&Aacute;"
	<>HTML_Entities{194}:="&Acirc;"
	<>HTML_Entities{195}:="&Atilde;"
	<>HTML_Entities{196}:="&Auml;"
	<>HTML_Entities{197}:="&Aring;"
	<>HTML_Entities{198}:="&AElig;"
	<>HTML_Entities{199}:="&Ccedil;"
	<>HTML_Entities{200}:="&Egrave;"
	<>HTML_Entities{201}:="&Eacute;"
	<>HTML_Entities{202}:="&Ecirc;"
	<>HTML_Entities{203}:="&Euml;"
	<>HTML_Entities{204}:="&Igrave;"
	<>HTML_Entities{205}:="&Iacute;"
	<>HTML_Entities{206}:="&Icirc;"
	<>HTML_Entities{207}:="&Iuml;"
	<>HTML_Entities{208}:="&ETH;"
	<>HTML_Entities{209}:="&Ntilde;"
	<>HTML_Entities{210}:="&Ograve;"
	<>HTML_Entities{211}:="&Oacute;"
	<>HTML_Entities{212}:="&Ocirc;"
	<>HTML_Entities{213}:="&Otilde;"
	<>HTML_Entities{214}:="&Ouml;"
	<>HTML_Entities{215}:="&times;"
	<>HTML_Entities{216}:="&Oslash;"
	<>HTML_Entities{217}:="&Ugrave;"
	<>HTML_Entities{218}:="&Uacute;"
	<>HTML_Entities{219}:="&Ucirc;"
	<>HTML_Entities{220}:="&Uuml;"
	<>HTML_Entities{221}:="&Yacute;"
	<>HTML_Entities{222}:="&THORN;"
	<>HTML_Entities{223}:="&szlig;"
	<>HTML_Entities{224}:="&agrave;"
	<>HTML_Entities{225}:="&aacute;"
	<>HTML_Entities{226}:="&acirc;"
	<>HTML_Entities{227}:="&atilde;"
	<>HTML_Entities{228}:="&auml;"
	<>HTML_Entities{229}:="&aring;"
	<>HTML_Entities{230}:="&aelig;"
	<>HTML_Entities{231}:="&ccedil;"
	<>HTML_Entities{232}:="&egrave;"
	<>HTML_Entities{233}:="&eacute;"
	<>HTML_Entities{234}:="&ecirc;"
	<>HTML_Entities{235}:="&euml;"
	<>HTML_Entities{236}:="&igrave;"
	<>HTML_Entities{237}:="&iacute;"
	<>HTML_Entities{238}:="&icirc;"
	<>HTML_Entities{239}:="&iuml;"
	<>HTML_Entities{240}:="&eth;"
	<>HTML_Entities{241}:="&ntilde;"
	<>HTML_Entities{242}:="&ograve;"
	<>HTML_Entities{243}:="&oacute;"
	<>HTML_Entities{244}:="&ocirc;"
	<>HTML_Entities{245}:="&otilde;"
	<>HTML_Entities{246}:="&ouml;"
	<>HTML_Entities{247}:="&divide;"
	<>HTML_Entities{248}:="&oslash;"
	<>HTML_Entities{249}:="&ugrave;"
	<>HTML_Entities{250}:="&uacute;"
	<>HTML_Entities{251}:="&ucirc;"
	<>HTML_Entities{252}:="&uuml;"
	<>HTML_Entities{253}:="&yacute;"
	<>HTML_Entities{254}:="&thorn;"
	<>HTML_Entities{255}:="&yuml;"
	
	// In non Unicode mode we substitute the currency symbol with the Euro symbol
	// even though ISO Latin 1 does not contain the Euro character
	// If (Get database parameter(Unicode mode)=0)
	<>HTML_Entities{164}:="&eur;"
	// End if 
	
End if 
