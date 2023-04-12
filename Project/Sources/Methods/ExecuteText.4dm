//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-14T00:00:00, 18:51:15
// ----------------------------------------------------
// Method: ExecuteText
// Description
// Modified: 09/14/16
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283(viRecursive)
C_LONGINT:C283($err; $1; $doDebug; $p; $myOK)
C_TEXT:C284($2; $frText; $3; $name; $output)
C_TEXT:C284(vtB4A9D2AE25C44FC282C582D9D940D)
$frText:=$2
$myOK:=0
$frText:=""
$name:=""
If (Count parameters:C259>0)
	$myOK:=$1
End if 
If (Count parameters:C259>1)
	$frText:=$2
End if 
If (Count parameters:C259>2)
	$name:=$3
Else 
	$name:=Substring:C12($frText; 1; 20)
End if 
If ($myOK>0)
	CONFIRM:C162("Execute the Script: "+$name)
Else 
	OK:=1
End if 

If (<>viDebugMode>410)
	ConsoleLog($frText)
End if 

If (OK=1)
	$frText:=ExecuteFlatten($frText)
	//If (viRecursive=1)
	
	If ($frText#"")  // run if not empty
		$frText:="<!--#4DCODE\r"+$frText+"\r-->"  // wrap script with 4D tags
		PROCESS 4D TAGS:C816($frText; $output)  // Process Script
		
		
		//$viVersion:=Num(Substring(Application version;1;2))
		//<>4dScriptDo:=False  // convert in version 16
		//C_TEXT($inputText_t;$output)
		//$inputText_t:="<!--#4DCODE\r"+"Alert(\"Hello World\")"+"\r-->"
		//If (<>4dScriptDo)
		//If ($viVersion>=16)
		//$frText:="<!--#4DCODE\r"+$frText+"\r-->"
		//PROCESS 4D TAGS($frText;$output)
		//Else 
		//$err:=FRRunTextRaw ($frText;0)
		//End if 
		//End if 
		
	End if 
End if 
viRecursive:=0

If (Records in selection:C76([TallyMaster:60])>0)
	UNLOAD RECORD:C212([TallyMaster:60])
End if 
CLEAR VARIABLE:C89($frText)
// end if
