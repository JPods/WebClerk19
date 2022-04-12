//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTML_TagCheckPage 
	//Date: 07/01/02
	//Who: Bill
	//Description: Find the tags and check them on a document
End if 


C_TEXT:C284($1)
vText11:=$1
//
ARRAY TEXT:C222(aTagName; 4)
ARRAY TEXT:C222(aTagValue; 4)
ARRAY TEXT:C222(aTagComment; 4)
ARRAY LONGINT:C221(aTagCode; 4)
//
aTagValue{1}:=WC_MetaTagRead(vText11; "jitReason"; 0)
aTagName{1}:="jitReason"
aTagCode{1}:=Num:C11(aTagValue{1}#"")
aTagValue{2}:=WC_MetaTagRead(vText11; "jitSecure"; 0)
aTagName{2}:="jitSecure"
aTagCode{2}:=Num:C11(aTagValue{2}#"")
aTagValue{3}:=WC_MetaTagRead(vText11; "jitFrom"; 0)
aTagName{3}:="jitFrom"
aTagCode{3}:=Num:C11(aTagValue{3}#"")
aTagValue{4}:=WC_MetaTagRead(vText11; "jitTo"; 0)
aTagName{4}:="jitTo"
aTagCode{4}:=Num:C11(aTagValue{4}#"")
$foundTag:=0
//TRACE
Repeat 
	//      
	$foundTag:=HTML_TagClip(->vText11)
	If ($foundTag#0)
		$w:=Size of array:C274(aTagName)+1
		INSERT IN ARRAY:C227(aTagName; $w; 1)
		INSERT IN ARRAY:C227(aTagValue; $w; 1)
		INSERT IN ARRAY:C227(aTagComment; $w; 1)
		INSERT IN ARRAY:C227(aTagCode; $w; 1)
		//begin tag + tabletag + midTag + fieldTag + midTag * format + formatTag + endTag
		aTagName{$w}:=aWebTags{1}+aWebTags{2}+<>midTag+aWebTags{3}+(<>formatTag*(Num:C11(aWebTags{4}#"")))+aWebTags{4}+<>endTag
		aTagValue{$w}:=HTML_TagFieldName(aWebTags{2}; aWebTags{3})
	End if 
Until ($foundTag=0)