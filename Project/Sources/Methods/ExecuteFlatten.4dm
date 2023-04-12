//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-21T00:00:00, 10:44:04
// ----------------------------------------------------
// Method: ExecuteFlatten
// Description
// Modified: 04/21/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $0)

C_TEXT:C284($workingText)
doAlert:=False:C215

//vResponse:=""
C_TEXT:C284($vTextFlattened; $vTextOutPut)
C_LONGINT:C283(viRecursive; $p; $myRecursive)
viRecursive:=viRecursive+1  // track how deep we are going
If (viRecursive=1)
	If (<>viDebugMode>=5)
		ConsoleLog("// ExecuteFlatten: Begin = "+String:C10(viRecursive))
	End if 
Else 
	If (<>viDebugMode>=5)
		ConsoleLog("// ExecuteFlatten: Recursive = "+String:C10(viRecursive)+"\r"+$1)
	End if 
End if 


If (Position:C15("Execute_TallyMaster"; $1)>0)  // ### jwm ### 20170508_1720 flatten script
	$vTextOutPut:=""  // empty
	$workingText:=Tx_ConvertScripts($1)
	ARRAY TEXT:C222($aWorkingText; 0)
	$workingText:=Replace string:C233($workingText; Storage:C1525.char.crlf; "\r")
	$workingText:=Replace string:C233($workingText; "\n"; "\r")
	TextToArray($workingText; ->aText1; "\r")
	COPY ARRAY:C226(aText1; $aWorkingText)
	ARRAY TEXT:C222(aText1; 0)
	$sizeOfArray:=Size of array:C274($aWorkingText)
	C_TEXT:C284($regEx_CleanBeginWhite)
	$regEx_CleanBeginWhite:="(?im)^\\s*"
	C_LONGINT:C283($foundRecursive)
	$foundRecursive:=0
	$myRecursive:=viRecursive
	For ($incArray; 1; $sizeOfArray)
		//$1 "(?im)^\s*"  beginning of a line any white space character
		//$2 what we are replacing with
		$aWorkingText{$incArray}:=Preg Replace("(?im)^\\s*"; ""; $aWorkingText{$incArray})
		Case of 
			: ($aWorkingText{$incArray}="Execute_TallyMaster@")  // ($aWorkingText{$incArray}="Execute_TallyMaster@")
				Txt_CommandParser($aWorkingText{$incArray}; ->aText11)
				$myName:=aText11{4}
				$myPurpose:=aText11{5}
				
				
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$myName; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$myPurpose; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
				If (Records in selection:C76([TallyMaster:60])=1)
					If (<>viDebugMode>=4)
						ConsoleLog("// ExecuteFlatten: "+String:C10(viRecursive)+": Execute_TallyMaster Name: "+$myName+": Purpose: "+$myPurpose+"\r")
					End if 
					$vTextFlattened:=ExecuteFlatten([TallyMaster:60]script:9)  // when directly added to the following line, it trucated vScriptRecursive
					$vTextOutPut:=$vTextOutPut+"\r"+$vTextFlattened
				Else 
					C_TEXT:C284($errMessage)
					$errMessage:="  //  Records in Selection([TallyMaster]) "+String:C10(Records in selection:C76([TallyMaster:60]))
					$vTextOutPut:=$vTextOutPut+"\r"+$errMessage
					$vTextOutPut:=$vTextOutPut+"\r"+$aWorkingText{$incArray}  // if unresolved return as received
					If (<>viDebugMode>=4)
						ConsoleLog("// ExecuteFlatten: "+$errMessage+"\r")
					End if 
				End if 
				// $frText:=$frText+ExecuteFlatten ($aWorkingText{$incArray}
				If (viRecursive<=0)
					ALERT:C41("viRecursive is "+String:C10(viRecursive)+". See Console")
					ConsoleLog("// ExecuteFlatten: viRecursive is "+String:C10(viRecursive)+"\r"+$vTextOutPut+"\r"+"\r"+"\r")
				End if 
				If ($myRecursive#viRecursive)
					ConsoleLog("// ExecuteFlatten: viRecursive changed elsewhere "+String:C10(viRecursive)+" : "+String:C10($myRecursive)+"\r")
				End if 
			: ($aWorkingText{$incArray}="Execute_Text@")  // ($aWorkingText{$incArray}="Execute_Text@")
				$vTextOutPut:=$vTextOutPut+"\r"+"  //  "+$aWorkingText{$incArray}
				$vTextOutPut:=$vTextOutPut+"\r"+"  // watch for crashing if called recursively"
				$vTextOutPut:=$vTextOutPut+"\r"+$aWorkingText{$incArray}  // if unresolved return as received
				TRACE:C157
				
			Else 
				$vTextOutPut:=$vTextOutPut+"\r"+$aWorkingText{$incArray}
		End case 
	End for 
	
Else 
	//$vTextOutPut:=$1  // ### jwm ### 20170508_1720 do not flatten
	$vTextOutPut:=Tx_ConvertScripts($1)  // ### jwm ### 20170922_1357 convert but do not flatten
End if 


If (viRecursive=1)
	
	Case of 
		: (<>VIDEBUGMODE>=3)
			ConsoleLog("\r"+"// ExecuteFlatten: Final:"+"\r"+$vTextOutPut)
		: (<>VIDEBUGMODE>=2)
			ConsoleLog($vTextOutPut)
	End case 
	
End if 

$0:=$vTextOutPut  // always output the text
$vTextOutPut:=""  // clear values
viRecursive:=viRecursive-1

ARRAY TEXT:C222(aText11; 0)  //cleanup



If (False:C215)
	
	
	// ----------------------------------------------------
	// User name (OS): Bill James
	// Date and time: 2017-04-21T00:00:00, 10:44:04
	// ----------------------------------------------------
	// Method: ExecuteFlatten
	// Description
	// Modified: 04/21/17
	// 
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	C_TEXT:C284($1; $0)
	
	C_TEXT:C284($workingText)
	doAlert:=False:C215
	//vResponse:=""
	C_TEXT:C284($vTextFlattened; $vTextOutPut)
	C_LONGINT:C283(viRecursive; $p; $myRecursive)
	viRecursive:=viRecursive+1  // track how deep we are going
	If (viRecursive=1)
		If (<>viDebugMode>=3)
			ConsoleLog("// ExecuteFlatten: Begin = "+String:C10(viRecursive))
		End if 
	Else 
		If (<>viDebugMode>=3)
			ConsoleLog("// ExecuteFlatten: Recursive = "+String:C10(viRecursive)+"\r"+$1)
		End if 
	End if 
	$vTextOutPut:=""  // empty
	$workingText:=Tx_ConvertScripts($1)
	ARRAY TEXT:C222($aWorkingText; 0)
	$workingText:=Replace string:C233($workingText; Storage:C1525.char.crlf; "\r")
	$workingText:=Replace string:C233($workingText; "\n"; "\r")
	TextToArray($workingText; ->aText1; "\r")
	COPY ARRAY:C226(aText1; $aWorkingText)
	ARRAY TEXT:C222(aText1; 0)
	$sizeOfArray:=Size of array:C274($aWorkingText)
	C_TEXT:C284($regEx_CleanBeginWhite)
	$regEx_CleanBeginWhite:="(?im)^\\s*"
	C_LONGINT:C283($foundRecursive)
	$foundRecursive:=0
	$myRecursive:=viRecursive
	For ($incArray; 1; $sizeOfArray)
		//$1 "(?im)^\s*"  beginning of a line any white space character
		//$2 what we are replacing with
		$aWorkingText{$incArray}:=Preg Replace("(?im)^\\s*"; ""; $aWorkingText{$incArray})
		C_TEXT:C284($myName; $myPurpose)
		C_LONGINT:C283($pCut)
		
		// Txt_CommandParser ($aWorkingText{$incArray};->aText11)
		
		Case of 
			: (aText11{2}="Execute_TallyMaster@")  // ($aWorkingText{$incArray}="Execute_TallyMaster@")
				$pCut:=Position:C15(Char:C90(34); $aWorkingText{$incArray})
				
				$pCut:=Position:C15(Char:C90(59); $aWorkingText{$incArray})
				$myName:=Substring:C12($aWorkingText{$incArray}; $pCut+1)
				pCut:=Position:C15(Char:C90(34); $myName)
				$myPurpose:=Substring:C12($myName; pCut+3)
				// trim
				$myName:=Substring:C12($myName; 1; pCut-1)
				pCut:=Position:C15(Char:C90(34); $myPurpose)
				$myPurpose:=Substring:C12($myPurpose; 1; pCut-1)
				
				$vTextOutPut:=$vTextOutPut+"\r"+"  //  "+$aWorkingText{$incArray}
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$myName; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$myPurpose; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
				If (Records in selection:C76([TallyMaster:60])=1)
					If (<>viDebugMode>=3)
						ConsoleLog("// ExecuteFlatten: "+String:C10(viRecursive)+": Execute_TallyMaster Name: "+$myName+": Purpose: "+$myPurpose+"\r")
					End if 
					$vTextFlattened:=ExecuteFlatten([TallyMaster:60]script:9)  // when directly added to the following line, it trucated vScriptRecursive
					$vTextOutPut:=$vTextOutPut+"\r"+$vTextFlattened
				Else 
					C_TEXT:C284($errMessage)
					$errMessage:="  //  Records in Selection([TallyMaster]) "+String:C10(Records in selection:C76([TallyMaster:60]))
					$vTextOutPut:=$vTextOutPut+"\r"+$errMessage
					$vTextOutPut:=$vTextOutPut+"\r"+$aWorkingText{$incArray}  // if unresolved return as received
					If (<>viDebugMode>=3)
						ConsoleLog("// ExecuteFlatten: "+$errMessage+"\r")
					End if 
				End if 
				// $frText:=$frText+ExecuteFlatten ($aWorkingText{$incArray}
				If (viRecursive<=0)
					ALERT:C41("viRecursive is "+String:C10(viRecursive)+". See Console")
					ConsoleLog("// ExecuteFlatten: viRecursive is "+String:C10(viRecursive)+"\r"+$vTextOutPut+"\r"+"\r"+"\r")
				End if 
				If ($myRecursive#viRecursive)
					ConsoleLog("// ExecuteFlatten: viRecursive changed elsewhere "+String:C10(viRecursive)+" : "+String:C10($myRecursive)+"\r")
				End if 
			: (aText11{2}="Execute_Text@")  // ($aWorkingText{$incArray}="Execute_Text@")
				$vTextOutPut:=$vTextOutPut+"\r"+"  //  "+$aWorkingText{$incArray}
				$vTextOutPut:=$vTextOutPut+"\r"+"  // watch for crashing if called recursively"
				$vTextOutPut:=$vTextOutPut+"\r"+$aWorkingText{$incArray}  // if unresolved return as received
				TRACE:C157
				If (False:C215)
					//$pCut:=Position(";";$aWorkingText{$incArray};1)
					$myName:=Substring:C12($aWorkingText{$incArray}; 16)
					$pCut:=Position:C15(")"; $myName; 1)
					$myName:=Substring:C12($myName; 1; $pCut-1)
					If ($myName#"")
						If ($myName[[1]]=Char:C90(34))
							$vTextOutPut:=$vTextOutPut+"\r"+ExecuteFlatten($myName)
						Else 
							//  $vTextOutPut:=$vTextOutPut+"\r"+"ExecuteFlatten("+$myName+")"  //  Execute_Text can only be used at
							
							// $vTextOutPut:=$vTextOutPut+"\r"+"Execute_text(0;ExecuteFlatten("+$myName+"))"
						End if 
						
					End if 
				End if 
			Else 
				$vTextOutPut:=$vTextOutPut+"\r"+$aWorkingText{$incArray}
		End case 
	End for 
	
	If (viRecursive=1)
		If (<>VIDEBUGMODE>=2)
			ConsoleLog("\r"+"// ExecuteFlatten: Final:"+"\r"+$vTextOutPut)
		End if 
	End if 
	$0:=$vTextOutPut  // always output the text
	$vTextOutPut:=""  // clear values
	viRecursive:=viRecursive-1
	
	
	
End if 