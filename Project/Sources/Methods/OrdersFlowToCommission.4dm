//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 09:52:07
// ----------------------------------------------------
// Method: OrdersFlowToCommission
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $orderFlow)
$orderFlow:=3
$balanceLine:=False:C215
If (Count parameters:C259>0)
	$orderFlow:=$1
End if 
C_REAL:C285($0; $backlog)
//
READ WRITE:C146([OrderLine:49])
REDUCE SELECTION:C351([OrderLine:49]; 0)
QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
C_LONGINT:C283($incBL; $cntBL)
$cntBL:=Records in selection:C76([OrderLine:49])
C_REAL:C285($backlog)
$backlog:=0
$lineNum:=1
READ WRITE:C146([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
For ($incBL; 1; $cntBL)
	$backlog:=$backlog+[OrderLine:49]backOrdAmount:26
	[OrderLine:49]commentProcess:60:=String:C10(Current date:C33)+"; QtyBLQ; "+String:C10([OrderLine:49]qtyBackLogged:8)+"; AmountBL; "+String:C10([OrderLine:49]backOrdAmount:26)+"; Converted to Bulk Commission"
	viOrdLnCnt:=MaxValueReturn(viOrdLnCnt; [OrderLine:49]sequence:30)
	[OrderLine:49]profileReal2:63:=[OrderLine:49]qtyBackLogged:8
	[OrderLine:49]dateShipOn:38:=Current date:C33
	[OrderLine:49]unitofMeasure:19:="BulkCommConvert"
	[OrderLine:49]backOrdAmount:26:=0
	[OrderLine:49]qtyBackLogged:8:=0
	[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyOrdered:6
	[OrderLine:49]complete:48:=True:C214
	SAVE RECORD:C53([OrderLine:49])
	NEXT RECORD:C51([OrderLine:49])
End for 
[Order:3]flow:134:=$orderFlow

SAVE RECORD:C53([Order:3])
$0:=$backlog