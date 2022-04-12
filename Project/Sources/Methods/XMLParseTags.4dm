//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XMLParseTags
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($pBeg; $pEnd; $lenEndTag; $pType)
C_TEXT:C284($1; $xmlTagName; xmlTagType; xmlTagValue; $workingText)
C_BOOLEAN:C305($endTag)
$endTag:=False:C215
$xmlTagName:=""
//xmlTagType:=""
xmlTagValue:=""

XMLArrayManagement(0)

C_LONGINT:C283($cntNonMatches)
$lastTagLabel:="q3lkjqweahakeuytiufhfhw3uh34th3498eawoihdskfhkh;"
$cntNonMatches:=0
$workingText:=$1
$pBeg:=Position:C15("<"; $workingText)
While ($pBeg>0)
	$cntNonMatches:=$cntNonMatches+1
	$myValue:=Substring:C12($workingText; 1; $pBeg-1)
	$workingText:=Substring:C12($workingText; $pBeg)
	$pEnd:=Position:C15(">"; $workingText)
	//If ($workingText2="/")
	//$xmlTagName:=Substring($workingText;3;$pEnd-3)
	//$endTag:=True
	//Else 
	$xmlTagName:=Substring:C12($workingText; 2; $pEnd-2)
	//End if 
	$workingText:=Substring:C12($workingText; $pEnd+1)
	//
	$pSpace:=Position:C15(" "; $xmlTagName)
	If ($pSpace<1)
		$myTagLabel:=$xmlTagName
		$myParameters:=""
		If ($xmlTagName#"")
			If ($xmlTagName[[Length:C16($xmlTagName)]]="/")
				$myTagLabel:=Substring:C12($xmlTagName; 1; Length:C16($xmlTagName)-1)
			End if 
		End if 
	Else 
		$myTagLabel:=Substring:C12($xmlTagName; 1; $pSpace-1)
		$myParameters:=Substring:C12($xmlTagName; $pSpace+1)
	End if 
	//
	C_TEXT:C284($lastTagLabel; $myTagLabel)
	
	$myValue:=Replace string:C233($myValue; "\t"; "")
	//
	Case of 
		: ($myTagLabel=("/"+$lastTagLabel))  //end tag
			aXMLMatch{1}:=1
			aXMLValue{1}:=$myValue
			aXMLSequence{1}:=$cntNonMatches
		: ($myTagLabel=("/@"))  //end tag
			$myTagLabel:=Substring:C12($myTagLabel; 2)
			$w:=Find in array:C230(aXMLTag; $myTagLabel)
			If ($w>0)
				aXMLMatch{$w}:=$w
				aXMLSequence{$w}:=10
			Else 
				XMLArrayManagement(-3; 1; 1)
				aXMLTag{1}:="/"+$myTagLabel
				aXMLValue{1}:=$myValue
				aXMLTagParams{1}:="No End Tag"
				aXMLSequence{1}:=-1
			End if 
		: (($xmlTagName[[Length:C16($xmlTagName)]]="/") | ($xmlTagName[[Length:C16($xmlTagName)]]="?"))  //self terminating      
			XMLArrayManagement(-3; 1; 1)
			aXMLTag{1}:=$myTagLabel
			aXMLValue{1}:=$myValue
			aXMLTagParams{1}:=$myParameters
			aXMLSequence{1}:=$cntNonMatches
			//    
		Else 
			XMLArrayManagement(-3; 1; 1)
			aXMLTag{1}:=$myTagLabel
			aXMLValue{1}:=$myValue
			aXMLTagParams{1}:=$myParameters
			aXMLSequence{1}:=0
	End case 
	$lastTagLabel:=$myTagLabel
	$pBeg:=Position:C15("<"; $workingText)
End while 