//%attributes = {"publishedWeb":true}
//Method: Method: Tal_RunTextBlk2
C_TEXT:C284($1; $theRecName; $vtSearch; $thePurpose)
C_PICTURE:C286($vpSearch)
C_LONGINT:C283($doThis)
//
TRACE:C157
$doThis:=Count parameters:C259
viEndUserSecurityLevel:=1
Case of 
	: ($doThis=0)
		$theRecName:=""
		BEEP:C151
		BEEP:C151
	: ($doThis=1)
		$theRecName:=$1
		$thePurpose:="Execute_Tally"
		Execute_TallyMaster($theRecName; $thePurpose)
	Else 
		$theRecName:=$1
		$thePurpose:=$2
		Execute_TallyMaster($theRecName; $thePurpose)
End case 
viEndUserSecurityLevel:=0