//%attributes = {"publishedWeb":true}
//If (False)
////Method: XMLParseTags
////Date: 03/11/03
////Who: Bill
////Description: 
//End if 
//C_LONGINT($pBeg;$pEnd;$lenEndTag;$pType)
//C_TEXT($1;$xmlTagName;xmlTagType;xmlTagValue;$workingText)
//C_BOOLEAN($endTag)
//$endTag:=False
//$xmlTagName:=""
////xmlTagType:=""
//xmlTagValue:=""
//
//XMLArrayManagement (0)
//
//C_TEXT($1;$2;$3;$startTag;$endTag)
//If (count paramters=0)
//$startTag:="<"
//$endTag:=">"
//$balTags:=True
//
//End if 
//
//C_Longint($cntNonMatches)
//$lastTagLabel:="q3lkjqweahakeuytiufhfhw3uh34th3498eawoihdskfhkh;"
//$cntNonMatches:=0
//$workingText:=$1
//$pBeg:=Position("<";$workingText)
//While ($pBeg>0)
//$cntNonMatches:=$cntNonMatches+1
//$myValue:=Substring($workingText;1;$pBeg-1)
//$workingText:=Substring($workingText;$pBeg)
//$pEnd:=Position(">";$workingText)
////  
//$xmlTagName:=Substring($workingText;2;$pEnd-2)
//$workingText:=Substring($workingText;$pEnd+1)
////
//$pSpace:=Position(" ";$xmlTagName)
//If ($pSpace<1)
//$myTagLabel:=$xmlTagName
//$myParameters:=""
//If ($xmlTagNameLength($xmlTagName)="/")
//$myTagLabel:=Substring($xmlTagName;1;Length($xmlTagName)-1)
//End if 
//Else 
//$myTagLabel:=Substring($xmlTagName;1;$pSpace-1)
//$myParameters:=Substring($xmlTagName;$pSpace+1)
//End if 
////
//C_TEXT($lastTagLabel;$myTagLabel)
//Case of 
//: ($myTagLabel=("/"+$lastTagLabel))//end tag
//aXMLMatch{1}:=1
//aXMLValue{1}:=$myValue
//aXMLSequence{1}:=$cntNonMatches
//: ($myTagLabel=("/@"))//end tag
//$myTagLabel:=Substring($myTagLabel;2)
//$w:=Find in array(aXMLTag;$myTagLabel)
//If ($w>0)
//aXMLMatch{$w}:=$w
//aXMLSequence{$w}:=10
//Else 
//XMLArrayManagement (-3;1;1)
//aXMLTag{1}:="/"+$myTagLabel
//aXMLValue{1}:=$myValue
//aXMLTagParams{1}:="No End Tag"
//aXMLSequence{1}:=-1
//End if 
//: (($xmlTagNameLength($xmlTagName)="/")|($xmlTagNameLength
//($xmlTagName)="?"))//self terminating      
//XMLArrayManagement (-3;1;1)
//aXMLTag{1}:=$myTagLabel
//aXMLValue{1}:=$myValue
//aXMLTagParams{1}:=$myParameters
//aXMLSequence{1}:=$cntNonMatches
////    
//Else 
//XMLArrayManagement (-3;1;1)
//aXMLTag{1}:=$myTagLabel
//aXMLValue{1}:=$myValue
//aXMLTagParams{1}:=$myParameters
//aXMLSequence{1}:=0
//End case 
//$lastTagLabel:=$myTagLabel
//$pBeg:=Position("<";$workingText)
//End while 