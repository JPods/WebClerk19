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

C_TEXT:C284($varName)
C_TEXT:C284($varValue)
If ((Size of array:C274(<>aExtensionValue)=0) & ([WebClerk:78]mime:2=""))
	[WebClerk:78]mime:2:=WC_MimeBuild
End if 
ARRAY OBJECT:C1221($objArray; 0)
JSON PARSE ARRAY:C1219([WebClerk:78]mime:2; $objArray)
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


//QUERY([zzzWebClerkDevice]; [zzzWebClerkDevice]purpose="Mime"; *)
//QUERY([zzzWebClerkDevice];  & [zzzWebClerkDevice]active=True)
//If (Records in selection([zzzWebClerkDevice])=0)
//CREATE RECORD([zzzWebClerkDevice])
//[zzzWebClerkDevice]purpose:="Mime"
//[zzzWebClerkDevice]name:="txt"
//[zzzWebClerkDevice]value:="text/plain"
//Else 
//$k:=Records in selection([zzzWebClerkDevice])
//FIRST RECORD([zzzWebClerkDevice])
//For ($i; 1; $k)
//If (([zzzWebClerkDevice]name#"") & ([zzzWebClerkDevice]value#""))
//$w:=Find in array(<>aExtensionValue; [zzzWebClerkDevice]name)
//If ($w>0)
//<>aContentType{$w}:=[zzzWebClerkDevice]value
//Else 
//APPEND TO ARRAY(<>aExtensionValue; [zzzWebClerkDevice]name)
//APPEND TO ARRAY(<>aContentType; [zzzWebClerkDevice]value)
//End if 
//End if 
//End for 
//End if 




