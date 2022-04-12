//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-26T00:00:00, 00:12:13
// ----------------------------------------------------
// Method: Parse_Ltr24D
// Description
// Modified: 02/26/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



//Procedure: Parse_Ltr24D
C_LONGINT:C283($1; $2; $pStart; $pCheck; $pEnd; $w)  //filenumber
C_TEXT:C284($0; $buildText; $testText; $theText; $theField)
C_TEXT:C284($parseStart; $parseEnd; $3; $4)
TRACE:C157
Case of 
	: (Count parameters:C259=4)
		$parseStart:=$3
		$parseEnd:=$4
	: (Is macOS:C1572)
		$parseStart:=""
		$parseEnd:=""
	Else 
		$parseStart:="<"
		$parseEnd:=">"
End case 
ARRAY TEXT:C222($aVars; 0)
COPY ARRAY:C226(SRVarNames; $aVars)
SORT ARRAY:C229($aVars)
StructureFields($2)
//**WR UPDATE MODE ($1;0)
////**WR DO COMMAND ($1;208)//select all text
////**$theText:=  //**WR Get text ($1;1;2000000000)
//**WR EXECUTE COMMAND ($1;208)  //select all text
//**WR EXECUTE COMMAND ($1;206)  //select all text
$endLoop:=False:C215
$pStart:=Position:C15($parseStart; $theText)
Repeat 
	//**WR SET SELECTION ($1;32000;2000000000)  //select the end of the text in area
	If ($pStart=0)
		//**WR INSERT TEXT ($1;$theText)
		////// $buildText:=$buildText+$theText
		$endLoop:=True:C214
	Else 
		//**WR INSERT TEXT ($1;Substring($theText;1;$pStart-1))
		////// $buildText:=$buildText+Substring($theText;1;$pStart-1)
		$theText:=Substring:C12($theText; $pStart+1)
		$pEnd:=Position:C15($parseEnd; $theText)
		If ($pEnd=0)
			//**WR INSERT TEXT ($1;$theText)
			////// $buildText:=$buildText+$theText
			$endLoop:=True:C214
		Else 
			$testText:=Substring:C12($theText; 1; $pEnd-1)
			$theText:=Substring:C12($theText; $pEnd+1)
			$pCheck:=Position:C15("]"; $testText)
			If ($pCheck>0)
				$theField:=Substring:C12($testText; $pCheck+1)
			Else 
				$theField:=$testText
			End if 
			$w:=Find in array:C230(theFields; $theField)
			If ($w>0)
				//**WR INSERT FIELD ($1;$2;theFldNum{$w})
			Else 
				$w:=Find in array:C230($aVars; $testText)
				If ($w>0)
					//**WR INSERT EXPRESSION ($1;$aVars{$w})
				Else 
					//**WR INSERT TEXT ($1;$parseStart+$testText+$parseEnd)
					////// $buildText:=$buildText+$parseStart+$buildText+$parseEnd
				End if 
			End if 
		End if 
	End if 
	$pStart:=Position:C15($parseStart; $theText)
Until ($endLoop)
//**WR UPDATE MODE ($1;1)