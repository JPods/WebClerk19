// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-26T00:00:00, 11:54:40
// ----------------------------------------------------
// Method: [SyncRecord].Output.Variable25
// Description
// Modified: 11/26/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([SyncRecord:109])
CONFIRM:C162("Force close "+String:C10($k)+" records.")
If (OK=1)
	CONFIRM:C162("You are sure you want to force close "+String:C10($k)+" records.")
	If (OK=1)
		CREATE SET:C116([SyncRecord:109]; "original")
		CREATE EMPTY SET:C140([SyncRecord:109]; "locked")
		CREATE EMPTY SET:C140([SyncRecord:109]; "forced")
		CREATE EMPTY SET:C140([SyncRecord:109]; "closed")
		FIRST RECORD:C50([SyncRecord:109])
		For ($i; 1; $k)
			Case of 
				: ([SyncRecord:109]dtComplete:8#0)
					ADD TO SET:C119([SyncRecord:109]; "closed")
				: (Locked:C147([SyncRecord:109]))
					ADD TO SET:C119([SyncRecord:109]; "locked")
				Else 
					[SyncRecord:109]actionReceive:47:="ForceClosed"
					[SyncRecord:109]dtComplete:8:=DateTime_DTTo
					[SyncRecord:109]dtAction:2:=DateTime_DTTo
					[SyncRecord:109]resolvedBy:33:=Current user:C182
					// zzzqqq jDateTimeStamp(->[SyncRecord:109]comment:25; "Forced Closed")
					SAVE RECORD:C53([SyncRecord:109])
					ADD TO SET:C119([SyncRecord:109]; "forced")
			End case 
			NEXT RECORD:C51([SyncRecord:109])
		End for 
		
		If (Records in set:C195("locked")>0)
			USE SET:C118("locked")
			CLEAR SET:C117("locked")
			ProcessTableOpen(Table:C252(->[SyncRecord:109]); ""; "Locked")
		End if 
		
		If (Records in set:C195("closed")>0)
			USE SET:C118("closed")
			CLEAR SET:C117("closed")
			ProcessTableOpen(Table:C252(->[SyncRecord:109]); ""; "Already Closed")
		End if 
		
		If (Records in set:C195("forced")>0)
			USE SET:C118("forced")
			CLEAR SET:C117("forced")
			ProcessTableOpen(Table:C252(->[SyncRecord:109]); ""; "Forced Closed")
		End if 
		
		USE SET:C118("original")
		CLEAR SET:C117("original")
	End if 
	
End if 
