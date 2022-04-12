//%attributes = {}

//WO_TransferDirect(vtItemNum;vrQty;vtsiteIDFrom;vtsiteIDTo;vtActivity;vbPrint;vdDateAction;viGroupID;vitaskID)

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/29/18, 20:52:47
// ----------------------------------------------------
// Method: WO_TransferDirect
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_REAL:C285($2; $vrQty)
C_LONGINT:C283($8; $viGroupID; $9; $vitaskID; $vi1)
C_DATE:C307($7; $vdDateAction)
C_TEXT:C284($1; $vtItemNum; $3; $vtsiteIDFrom; $4; $vtsiteIDTo; $5; $vtActivity)
C_BOOLEAN:C305($6; $vbPrint)

// initialize variables
$vtItemNum:=""
$vrQty:=0
$vtsiteIDFrom:=""
$vtsiteIDTo:=""
$vtActivity:=""
$viGroupID:=0
$vdDateAction:=Current date:C33
$vitaskID:=0
$vbPrint:=False:C215
$vi1:=0

// assign parameters to variables
For ($vi1; 1; Count parameters:C259)
	Case of 
		: ($vi1=1)
			$vtItemNum:=$1
		: ($vi1=2)
			$vrQty:=$2
		: ($vi1=3)
			$vtsiteIDFrom:=$3
		: ($vi1=4)
			$vtsiteIDTo:=$4
		: ($vi1=5)
			$vtActivity:=$5
		: ($vi1=6)
			$vbPrint:=$6
		: ($vi1=7)
			$vdDateAction:=$7
		: ($vi1=8)
			$viGroupID:=$8
		: ($vi1=8)
			$vitaskID:=$9
	End case 
End for 

CREATE RECORD:C68([WorkOrder:66])
[WorkOrder:66]woNum:29:=CounterNew(->[WorkOrder:66])
[WorkOrder:66]itemNum:12:=$vtItemNum

If ([Item:4]itemNum:1#$vtItemNum)
	READ ONLY:C145([Item:4])
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)
	[WorkOrder:66]itemDescript:34:=[Item:4]description:7
	REDUCE SELECTION:C351([Item:4]; 0)
	READ WRITE:C146([Item:4])
Else 
	[WorkOrder:66]itemDescript:34:=[Item:4]description:7
End if 

[WorkOrder:66]qtyOrdered:13:=$vrQty
[WorkOrder:66]qtyActual:14:=$vrQty
[WorkOrder:66]woType:60:="Transfer"
[WorkOrder:66]action:33:="PendingTransfer"
[WorkOrder:66]siteIDFrom:62:=$vtsiteIDFrom
[WorkOrder:66]siteIDTo:61:=$vtsiteIDTo
[WorkOrder:66]actionByLast:65:=Current user:C182
[WorkOrder:66]actionBy:8:=Current user:C182
[WorkOrder:66]actionByInitiated:9:=Current user:C182
[WorkOrder:66]activity:7:=$vtActivity
[WorkOrder:66]groupid:32:=$viGroupID
[WorkOrder:66]dtCreated:44:=DateTime_Enter
[WorkOrder:66]dtAction:5:=DateTime_Enter($vdDateAction)
[WorkOrder:66]dateComplete:64:=!00-00-00!
[WorkOrder:66]qtyActual:14:=[WorkOrder:66]qtyOrdered:13
SAVE RECORD:C53([WorkOrder:66])
WOTransfer_dInventory("Ship")

[WorkOrder:66]action:33:="CompletedTransfer"
[WorkOrder:66]dtComplete:6:=DateTime_Enter
[WorkOrder:66]dateComplete:64:=Current date:C33
SAVE RECORD:C53([WorkOrder:66])
WOTransfer_dInventory("Receive")

If ($vbPrint)
	WOTransferPrint
End if 

REDUCE SELECTION:C351([WorkOrder:66]; 0)

TallyInventory


