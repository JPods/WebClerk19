//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/10/20, 00:33:13
// ----------------------------------------------------
// Method: CloneableCount
// Description
// 
//
// Parameters
// ----------------------------------------------------
READ ONLY:C145([Proposal:42])
QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed@")
C_LONGINT:C283($i; $k; $w)
$k:=Records in selection:C76([Proposal:42])
ORDER BY:C49([Proposal:42]; [Proposal:42]status:2)
ARRAY TEXT:C222($atCategory; 0)
ARRAY LONGINT:C221($aiCount; 0)
FIRST RECORD:C50([Proposal:42])
For ($i; 1; $k)
	$w:=Find in array:C230($atCategory; [Proposal:42]status:2)
	If ($w>0)
		$aiCount{$w}:=$aiCount{$w}+1
	Else 
		APPEND TO ARRAY:C911($atCategory; [Proposal:42]status:2)
		APPEND TO ARRAY:C911($aiCount; 1)
	End if 
	NEXT RECORD:C51([Proposal:42])
End for 
READ WRITE:C146([Proposal:42])
REDUCE SELECTION:C351([Proposal:42]; 0)
ConsoleLog("Cloneable Proposals: "+String:C10($k)+", categories: "+String:C10(Size of array:C274($atCategory)))

$k:=Size of array:C274($atCategory)
For ($i; 1; $k)
	ConsoleLog($atCategory{$i}+": "+String:C10($aiCount{$i}))
End for 






READ ONLY:C145([Proposal:42])
QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed@")
C_LONGINT:C283($i; $k; $w)
$k:=Records in selection:C76([Proposal:42])
ORDER BY:C49([Proposal:42]; [Proposal:42]profile2:52)
ARRAY TEXT:C222($atCategory; 0)
ARRAY LONGINT:C221($aiCount; 0)
FIRST RECORD:C50([Proposal:42])
For ($i; 1; $k)
	$w:=Find in array:C230($atCategory; [Proposal:42]profile2:52)
	If ($w>0)
		$aiCount{$w}:=$aiCount{$w}+1
	Else 
		APPEND TO ARRAY:C911($atCategory; [Proposal:42]profile2:52)
		APPEND TO ARRAY:C911($aiCount; 1)
	End if 
	NEXT RECORD:C51([Proposal:42])
End for 
READ WRITE:C146([Proposal:42])
REDUCE SELECTION:C351([Proposal:42]; 0)
ConsoleLog("Cloneable Proposals: "+String:C10($k)+", JobClass: "+String:C10(Size of array:C274($atCategory)))

$k:=Size of array:C274($atCategory)
For ($i; 1; $k)
	ConsoleLog($atCategory{$i}+": "+String:C10($aiCount{$i}))
End for 

If (False:C215)
	READ ONLY:C145([Proposal:42])
	QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed@")
	C_LONGINT:C283(vi1; vi2; vi8)
	vi2:=Records in selection:C76([Proposal:42])
	ORDER BY:C49([Proposal:42]; [Proposal:42]profile2:52)
	ARRAY TEXT:C222(atCategory; 0)
	ARRAY LONGINT:C221(aiCount; 0)
	FIRST RECORD:C50([Proposal:42])
	For (vi1; 1; vi2)
		vi8:=Find in array:C230(atCategory; [Proposal:42]profile2:52)
		If (vi8>0)
			aiCount{vi8}:=aiCount{vi8}+1
		Else 
			APPEND TO ARRAY:C911(atCategory; [Proposal:42]profile2:52)
			APPEND TO ARRAY:C911(aiCount; 1)
		End if 
		NEXT RECORD:C51([Proposal:42])
	End for 
	READ WRITE:C146([Proposal:42])
	REDUCE SELECTION:C351([Proposal:42]; 0)
	ConsoleLog("Cloneable Proposals: "+String:C10(vi2)+", JobClass: "+String:C10(Size of array:C274(atCategory)))
	
	
	vi2:=Size of array:C274(atCategory)
	For (vi1; 1; vi2)
		ConsoleLog(atCategory{vi1}+": "+String:C10(aiCount{vi1}))
	End for 
End if 