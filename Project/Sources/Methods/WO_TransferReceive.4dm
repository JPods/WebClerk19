//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/30/12, 12:28:41
// ----------------------------------------------------
// Method: WO_TransferReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141124_1421 use existing value unless empty or overridden

C_LONGINT:C283($1; $workOrderNum)
C_TEXT:C284($2; $siteIDTo; $3; $actionBy; $4; $receivingSite)
$actionBy:=Current user:C182
If (Count parameters:C259>0)
	$workOrderNum:=$1
	If (Count parameters:C259>1)
		$siteIDTo:=$2
		If (Count parameters:C259>2)
			$actionBy:=$3
			If (Count parameters:C259>3)
				$receivingSite:=$4
			End if 
		End if 
	End if 
End if 

If (False:C215)
	READ ONLY:C145([WorkOrder:66])
	READ WRITE:C146([WorkOrder:66])
End if 

QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNum:29=$1)

If (NotLocked(->[WorkOrder:66]))
	If ([WorkOrder:66]action:33="PendingTransfer")
		// If ($siteIDTo#"")
		// [WorkOrder]siteIDTo:=$siteIDTo
		// End if 
		
		If ($actionBy#"")
			[WorkOrder:66]actionBy:8:=$actionBy
		End if 
		
		[WorkOrder:66]action:33:="CompletedTransfer"
		// ### jwm ### 20141124_1421 use existing value unless empty or overridden
		If (([WorkOrder:66]siteIDFrom:62="") | (Macintosh option down:C545) | (Windows Alt down:C563))
			[WorkOrder:66]siteIDFrom:62:=iLo80String1
		End if 
		// ### jwm ### 20141124_1421 use existing value unless empty or overridden
		If (([WorkOrder:66]siteIDTo:61="") | (Macintosh option down:C545) | (Windows Alt down:C563))
			[WorkOrder:66]siteIDTo:61:=iLo80String2
		End if 
		
		[WorkOrder:66]dtComplete:6:=DateTime_DTTo
		[WorkOrder:66]actionByInitiated:9:=Current user:C182
		[WorkOrder:66]actionBy:8:=iLo80String4
		[WorkOrder:66]dateComplete:64:=Current date:C33
		[WorkOrder:66]qty:14:=[WorkOrder:66]qty:14
		SAVE RECORD:C53([WorkOrder:66])
		WOTransfer_dInventory("Receive")
		TallyInventory  // ### jwm ### 20180928_1132
		
	Else 
		If (allowAlerts_boo)
			ALERT:C41("ERROR: WorkOrder # "+String:C10($workOrderNum)+"\r\r"+"Status Must Be PendingTransfer To Receive")
		End if 
	End if 
End if 