// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/10/07, 08:10:59
// ----------------------------------------------------
// Method: Object Method: bAcceptB
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k; $cntNotrackID)
$k:=Size of array:C274(aPKtrackID)
$cntNotrackID:=0
For ($i; 1; $k)
	If ((aPKtrackID{$i}="") | (aPKtrackID{$i}="not@"))
		$cntNotrackID:=$cntNotrackID+1
	End if 
End for 
If ($cntNotrackID>0)
	CONFIRM:C162("There are "+String:C10($cntNotrackID)+" LoadTags without tracking numbers."+"\r"+"Return to window.")
	$cntNotrackID:=OK
End if 
If ($cntNotrackID=0)
	ACCEPT:C269
End if 