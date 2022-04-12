//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-04-07T00:00:00, 20:04:20
// ----------------------------------------------------
// Method: Key_DeleteWord
// Description
// Modified: 04/07/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)  // pointer to the KeyText field
C_POINTER:C301($ptTable)
C_POINTER:C301($ptField)
C_LONGINT:C283($theTableNum)
C_TEXT:C284($2; $wordDelete)
ARRAY TEXT:C222(aiLoText1; 0)
$ptField:=$1
$theTableNum:=Table:C252($ptField)
$ptTable:=Table:C252($theTableNum)
$wordDelete:=$2

// TextToArray ([Item]KeyText;->aiLoText1;",")
TextToArray($1->; ->aiLoText1; ",")
$1->:=""
C_LONGINT:C283($incRay; $cntRay)
$cntRay:=Size of array:C274(aiLoText1)
For ($incRay; $cntRay; 1; -1)
	If (aiLoText1{$incRay}=$wordDelete)
		DELETE FROM ARRAY:C228(aiLoText1; $incRay; 1)
	Else 
		If ($1->="")
			$1->:=($1->)+aiLoText1{$incRay}
		Else 
			$1->:=($1->)+","+aiLoText1{$incRay}
		End if 
	End if 
End for 
SAVE RECORD:C53($ptTable->)  // ### jwm ### 20150119_1026