//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-31T00:00:00, 02:25:02
// ----------------------------------------------------
// Method: WC_JsonMime
// Description
// Modified: 08/31/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($moreData)
ARRAY TEXT:C222($aMoreData; 0)
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aMoreExt; 0)
ARRAY TEXT:C222(aMoreContent; 0)
C_LONGINT:C283($i; $k; $w)

C_TEXT:C284($varName; 0)
C_TEXT:C284($varValue; 0)
If ((Size of array:C274(<>aExtensionValue)=0) & ([WebClerk:78]Mime:2=""))
	[WebClerk:78]Mime:2:=WC_MimeBuild
End if 
ARRAY OBJECT:C1221($objArray; 0)
JSON PARSE ARRAY:C1219([WebClerk:78]Mime:2; $objArray)
$cnt:=Size of array:C274($objArray)
For ($inc; 1; $cnt)
	$varName:=OB Get:C1224($objArray{$inc}; "suffix")
	If (Length:C16($varName)>0)
		If ($varName[[1]]=".")
			$varName:=Substring:C12($varName; 2)
		End if 
	End if 
	$varValue:=OB Get:C1224($objArray{$inc}; "mime")
	// ### bj ### 20190113_1330
	// I do not think this is needed
	// jsonTextToValue (->$varName;->$varValue)
	$w:=Find in array:C230(<>aExtensionValue; $varName)
	If ($w>0)
		<>aContentType{$w}:=$varValue
	Else 
		APPEND TO ARRAY:C911(<>aExtensionValue; $varName)
		APPEND TO ARRAY:C911(<>aContentType; $varValue)
	End if 
End for 


QUERY:C277([WebClerkDevice:150]; [WebClerkDevice:150]Purpose:2="Mime"; *)
QUERY:C277([WebClerkDevice:150];  & [WebClerkDevice:150]Active:7=True:C214)
If (Records in selection:C76([WebClerkDevice:150])=0)
	CREATE RECORD:C68([WebClerkDevice:150])
	[WebClerkDevice:150]Purpose:2:="Mime"
	[WebClerkDevice:150]Name:4:="txt"
	[WebClerkDevice:150]Value:5:="text/plain"
Else 
	$k:=Records in selection:C76([WebClerkDevice:150])
	FIRST RECORD:C50([WebClerkDevice:150])
	For ($i; 1; $k)
		If (([WebClerkDevice:150]Name:4#"") & ([WebClerkDevice:150]Value:5#""))
			$w:=Find in array:C230(<>aExtensionValue; [WebClerkDevice:150]Name:4)
			If ($w>0)
				<>aContentType{$w}:=[WebClerkDevice:150]Value:5
			Else 
				APPEND TO ARRAY:C911(<>aExtensionValue; [WebClerkDevice:150]Name:4)
				APPEND TO ARRAY:C911(<>aContentType; [WebClerkDevice:150]Value:5)
			End if 
		End if 
	End for 
End if 




