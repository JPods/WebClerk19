//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/01/20, 12:49:42
// ----------------------------------------------------
// Method: SE_ArrayFromWebPage
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $vtPage)
C_TEXT:C284($vtWorkingText)
C_TEXT:C284($2; $tableName)
ARRAY LONGINT:C221(aFieldLns; 0)
C_LONGINT:C283($viTableNum)
C_TEXT:C284($vtError)
$vtError:=""
If (Count parameters:C259=0)
	$vtPage:=vTextSummary
	$tableName:=Table name:C256(curTableNum)
	$viTableNum:=curTableNum
Else 
	$vtPage:=$1
	$tableName:=$2
	C_POINTER:C301($ptTable)
	$ptTable:=STR_GetTablePointer($tableName)
	If (Is nil pointer:C315($ptTable))
		$vtError:="Bad TableName: "+$tableName
		ConsoleMessage($vtError)
	Else 
		C_LONGINT:C283($viTableNum)
		$viTableNum:=Table:C252($ptTable)
		StructureFields(curTableNum)
	End if 
End if 

If ($vtError="")
	$textWorking:=$vtPage
	C_LONGINT:C283($p)
	C_BOOLEAN:C305($endLoop)
	C_TEXT:C284($textLoop)
	
	//TRACE
	$endLoop:=False:C215
	ARRAY TEXT:C222($aStack; 0)
	ARRAY LONGINT:C221($aTableTagNum; 0)
	ARRAY TEXT:C222($aFieldValue; 0)
	ARRAY TEXT:C222($aFormatValue; 0)
	
	C_REAL:C285(pvQtyLikely; pvQtyAvailable)
	$headend:=0
	$footstart:=0
	$builtText:=""
	
	
	// parse an array of table, field, and format tags
	Repeat 
		$p:=Position:C15(<>jitTag; $textWorking)
		$textLoop:=""
		
		If ($p<1)
			$endLoop:=True:C214
		Else 
			$textLoop:=$textLoop+Substring:C12($textWorking; 1; $p-1)
			$textWorking:=Substring:C12($textWorking; $p+<>lenJitTag)  //clip _jit_
			// $p:=Position(<>midTag;$textWorking)  //find midstr
			// $name:=Substring($textWorking;1;$p-1)  //clip to the ending
			// $textWorking:=Substring($textWorking;$p+1)  // clip the name
			$pend:=Position:C15(<>endTag; $textWorking)  //find the position of the field end char <>endTag   
			If ($pend<0)  // could not find an end tag put the text back together and drop out
				// $textOut:=$textOut+$textWorking // this is done at the end
				$endLoop:=True:C214  // drop out
				If (<>viDebugMode>410)
					ConsoleMessage("No 'jj' end to tag: "+$textWorking)
				End if 
			Else 
				// there is an end tag
				$actionText:=Substring:C12($textWorking; 1; $pend-1)  //clip to the end Tag 
				$textWorking:=Substring:C12($textWorking; $pend+2)  // clip the working text check for extra j
				
				TagToComponents($actionText)
				
				Case of 
					: ((vWebTagTable="end") | (vWebTagTable="_end"))
						$endLoop:=True:C214
						$p:=Position:C15(<>endTag; $textWorking)
						// $textWorking:=Substring($textWorking;$p+<>lenEndTag)
						$textLoop:=$textLoop
						$textLoop:=$textLoop+Substring:C12($textWorking; $p+<>lenEndTag)
						
						APPEND TO ARRAY:C911($aStack; $textLoop)
						
						$textLoop:=""
						$textWorking:=""  // added 151222 
					Else 
						$size:=Size of array:C274($aStack)+1
						ARRAY TEXT:C222($aStack; $size)
						$aStack{$size}:=$textLoop
						//
						$textLoop:=""
						APPEND TO ARRAY:C911($aTableTagNum; vWebTagTableNum)
						// If (viWebTagFieldNum>0)  // found a valid field, not a script, variable, object
						APPEND TO ARRAY:C911($aFieldValue; vWebTagField)
						// Else 
						// APPEND TO ARRAY($aFieldValue;vWebTagField)
						// End if 
						APPEND TO ARRAY:C911($aFormatValue; vWebTagFormat)
				End case 
			End if 
		End if 
	Until ($endLoop)
	//
	
	C_LONGINT:C283($i; $k)
	C_OBJECT:C1216($objSummary)
	C_OBJECT:C1216($objDiff)
	C_LONGINT:C283($viFieldNum)
	C_TEXT:C284($vtOutputObjects; $vtOutputVariables; $vtOutputScrips; $vtOutputOther)
	
	$k:=Size of array:C274($aTableTagNum)
	For ($i; 1; $k)
		//$objSummary:=OB SET(String($aTableTagNum{$i});$aFieldValue{$i})
		Case of 
			: ($aTableTagNum{$i}=-3)
				$vtOutputObjects:=$vtOutputObjects+"\r"+"jitObjects: "+$aFieldValue{$i}
			: ($aTableTagNum{$i}=0)
				$vtOutputVariables:=$vtOutputVariables+"\r"+"Variable: "+$aFieldValue{$i}
			: ($aTableTagNum{$i}=-6)
				$vtOutputScrips:=$vtOutputScrips+"\r"+"Script: "+$aFieldValue{$i}
			: ($aTableTagNum{$i}=$viTableNum)
				$viFieldNum:=Num:C11($aFieldValue{$i})
				
				$w:=Find in array:C230(theFldNum; $viFieldNum)
				If ($w>0)
					APPEND TO ARRAY:C911(aFieldLns; $w)
				End if 
			Else 
				$vtOutputOther:=$vtOutputOther+"\r"+String:C10($aTableTagNum{$i})+": "+$aFieldValue{$i}
		End case 
	End for 
	$0:=$vtOutputVariables+"\r"+"\r"+$vtOutputObjects+"\r"+"\r"+$vtOutputScrips+"\r"+"\r"+"Others: "+"\r"+$vtOutputOther+"\r"+"\r"
	//  --  CHOPPED  AL_UpdateArrays(eExportFlds; -2)
End if 
//arrays identify the things on the page

