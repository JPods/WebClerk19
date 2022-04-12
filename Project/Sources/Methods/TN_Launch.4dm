//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 01:31:01
// ----------------------------------------------------
// Method: TN_Launch
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)

//Procedure: TN_Launch
C_TEXT:C284($1)
//Procedure: TN_Launch(strToFind;field)
C_POINTER:C301($2; <>ptTN_OutSid)
If (Count parameters:C259=2)
	<>ptTN_OutSid:=$2
Else 
	<>ptTN_OutSid:=(->$1)
End if 
//QUERY([TechNote];<>ptTN_OutSid->=$1+"@")
//If (Records in selection([TechNote])>0)
<>vTN_OutSide:=$1
C_LONGINT:C283($found)
TN_Dialog
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("TechNotes")
C_TEXT:C284(<>vTN_OutSide)
Repeat 
	DELAY PROCESS:C323(Current process:C322; 120)
Until (<>prcControl=0)
POST OUTSIDE CALL:C329(<>aPrsNum{$found})
//End if 