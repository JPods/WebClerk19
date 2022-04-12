//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Srch_RelatedNotNull  
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 


C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($theType)
$theType:=Type:C295($3->)
REDUCE SELECTION:C351($1->; 0)
Case of 
	: (($theType=0) | ($theType=2) | ($theType=24))
		If ($3->#"")
			QUERY:C277($1->; $2->=$3->)
		End if 
	: ($theType=4)
		If ($3->#!00-00-00!)
			QUERY:C277($1->; $2->=$3->)
		End if 
	: (($theType=1) | ($theType=8))
		If ($3->#0)
			QUERY:C277($1->; $2->=$3->)
		End if 
	: ($theType=9)
		// DT_ParseImport (Field($theFile;$theField);$theValue)
		If ($3->#0)
			QUERY:C277($1->; $2->=$3->)
		End if 
	: ($theType=6)
		If ($3->=True:C214)
			QUERY:C277($1->; $2->=$3->)
		End if 
	: ($theType=11)
		If ($3->=?00:00:00?)
			QUERY:C277($1->; $2->=$3->)
		End if 
	Else 
		BEEP:C151
End case 