//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)  //File
C_LONGINT:C283($4)  //Sort by Field;0/1, accending/decending
C_BOOLEAN:C305($doThis)
$doThis:=jSortedConfirm
If ($doThis)
	MESSAGES OFF:C175
	AcceptPrint
	$2->:=Selected record number:C246($1->)
	CREATE SET:C116($1->; "Current")
	PUSH RECORD:C176($1->)
	ONE RECORD SELECT:C189($1->)
	PRINT SELECTION:C60($1->)
	POP RECORD:C177($1->)
	USE SET:C118("Current")
	If (Count parameters:C259=4)
		If ($4=0)
			ORDER BY:C49($1->; $3->; >)
		Else 
			ORDER BY:C49($1->; $3->; <)
		End if 
	End if 
	CLEAR SET:C117("Current")
	If (booSorted)
		booSorted:=False:C215
		myCycle:=0
		jCancelButton
	Else 
		GOTO SELECTED RECORD:C245($1->; $2->)
	End if 
	MESSAGES ON:C181
End if 