//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/14/11, 22:24:43
// ----------------------------------------------------
// Method: // zzzqqq jCapitalize1st
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer


C_TEXT:C284($vStr255)
C_LONGINT:C283($curAscii; $lastAscii)
C_POINTER:C301($1; $ptField)  //or variable
$ptField:=$1
KeyModifierCurrent
Case of 
	: ($ptField->="")
		// Modified by: William James (2013-09-03T00:00:00)
		
		
	: ((CmdKey=1) | ($ptField->="") | (Field name:C257($ptField)="@email@"))
		
	: ((Character code:C91($ptField->)<33) & (allowAlerts_boo))
		ALERT:C41("Beginning with invalid character.")
	Else 
		C_LONGINT:C283($len; $inc)
		$len:=Length:C16($ptField->)
		$inc:=1
		$lastChar:=1
		$curAscii:=Character code:C91($ptField->[[1]])
		$lastAscii:=0
		If (($curAscii>96) & ($curAscii<123))  //>"'" and < "{", between a and z
			$vStr255:=Char:C90($curAscii-32)
		Else 
			$vStr255:=$ptField->[[1]]
		End if 
		While ($inc<$len)
			$inc:=$inc+1
			$curAscii:=Character code:C91($ptField->[[$inc]])
			If (($curAscii>96) & ($curAscii<123) & ((($lastAscii>=32) & ($lastAscii<=38)) | (($lastAscii>=40) & ($lastAscii<=47)) | (($lastAscii>=58) & ($lastAscii<=63))))
				$vStr255:=$vStr255+Char:C90($curAscii-32)
			Else 
				$vStr255:=$vStr255+$ptField->[[$inc]]
			End if 
			$lastAscii:=$curAscii
		End while 
		$ptField->:=$vStr255
		If (ShftKey=1)
			$ptField->:=Parse_UnWanted($vStr255)
		End if 
End case 