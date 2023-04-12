//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/05/07, 05:40:37
// ----------------------------------------------------
// Method: TallyInventoryValue
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptField2Tally; $3; $ptContainerResults; $5; $ptContainerName)
C_TEXT:C284($2; $strValue2Tally; $4; $nameContainer)
If (Count parameters:C259=5)
	$ptField2Tally:=$1
	$strValue2Tally:=$2
	QUERY:C277([Item:4]; $1->=$2)
	$ptContainerResults:=$3
	$nameContainer:=$4
	$ptContainerName:=$5
Else 
	ALL RECORDS:C47([Item:4])
	$doTotal:=True:C214
	$nameContainer:="InventoryTotal"
	$ptContainerResults:=(->[TallyResult:73]real1:13)
	$ptContainerName:=(->[TallyResult:73]nameReal1:20)
End if 
FIRST RECORD:C50([Item:4])
$cntRecords:=Records in selection:C76([Item:4])
$inventoryValue:=0
For ($incRecords; 1; $cntRecords)
	$inventoryItemValue:=[Item:4]qtyOnHand:14*[Item:4]costAverage:13
	$inventoryValue:=$inventoryValue+$inventoryItemValue
	NEXT RECORD:C51([Item:4])
End for 

C_LONGINT:C283($dtTally; $incRecords; $cntRecords)
C_REAL:C285($inventoryValue; $inventoryItemValue)
vDate1:=Current date:C33
vTime1:=?00:00:00?
$dtTally:=DateTime_DTTo(Current date:C33; vTime1)
QUERY:C277([TallyResult:73]; [TallyResult:73]dtCreated:11=$dtTally; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="DailyInventory")
If (Records in selection:C76([TallyResult:73])=0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]dtCreated:11:=$dtTally
	[TallyResult:73]dtReport:12:=$dtTally
	[TallyResult:73]purpose:2:="DailyInventory"
	[TallyResult:73]name:1:="DailyInventory"
	//Save Record([TallyResult])
End if 
$ptContainerResults->:=$inventoryValue
$ptContainerName->:=$ptContainerName
SAVE RECORD:C53([TallyResult:73])
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([TallyResult:73])