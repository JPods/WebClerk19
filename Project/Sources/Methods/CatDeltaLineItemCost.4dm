//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/13/20, 16:18:02
// ----------------------------------------------------
// Method: CatDeltaLineItemCost
// Description
// 
//
// Parameters
// ----------------------------------------------------
ALL RECORDS:C47([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
If ([OrderLine:49]obGeneral:71.costchange=Null:C1517)
	[OrderLine:49]obGeneral:71.costchange:=New object:C1471
End if 
[OrderLine:49]obGeneral:71.costchange.date:=Current date:C33
[OrderLine:49]obGeneral:71.costchange.change:=$vrCostChange
[OrderLine:49]obGeneral:71.costchange.percent:=$vrPerCent
SAVE RECORD:C53([OrderLine:49])
REDUCE SELECTION:C351([OrderLine:49]; 0)

C_POINTER:C301($1; $ptObCatalog)
C_POINTER:C301($2; $ptvtReport)
$ptObCatalog:=$1
$ptvtReport:=$2
C_REAL:C285($3; $4; $vrCostChange; $vrPerCent)
$vrCostChange:=$3
$vrPerCent:=$4

C_LONGINT:C283($incRec; $cntRec)

QUERY:C277([OrderLine:49]; [OrderLine:49]qtyBackLogged:8>0; *)
QUERY:C277([OrderLine:49];  & ; [OrderLine:49]itemNum:4=[Item:4]itemNum:1)
$cntRec:=Records in selection:C76([OrderLine:49])

C_REAL:C285($vrTotalChange)
C_REAL:C285($vrQtyChange)
READ WRITE:C146([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
For ($incRec; 1; $cntRec)
	If ([OrderLine:49]obGeneral:71.costchange=Null:C1517)
		[OrderLine:49]obGeneral:71.costchange:=New object:C1471
	End if 
	[OrderLine:49]obGeneral:71.costchange.id:=$obCatalog->id
	[OrderLine:49]obGeneral:71.costchange.date:=Date:C102(String:C10(Current date:C33))
	[OrderLine:49]obGeneral:71.costchange.change:=$vrCostChange
	[OrderLine:49]obGeneral:71.costchange.percent:=$vrPerCent
	
	$vrQtyChange:=$vrQtyChange+[OrderLine:49]qtyBackLogged:8
	[OrderLine:49]profile4:35:="CostChange"
	SAVE RECORD:C53([OrderLine:49])
	NEXT RECORD:C51([OrderLine:49])
End for 
If ($ptObCatalog->orderlines=Null:C1517)
	$ptObCatalog->orderlines:=New object:C1471
End if 
$ptObCatalog->orderlines.records:=$cntRec
$ptObCatalog->orderlines.qty:=$vrQtyChange
$ptObCatalog->orderlines.changevalue:=Round:C94($vrQtyChange*$vrCostChange; 2)
REDUCE SELECTION:C351([OrderLine:49]; 0)


QUERY:C277([OrderLine:49]; [OrderLine:49]qtyBackLogged:8>0; *)
QUERY:C277([OrderLine:49];  & ; [OrderLine:49]itemNum:4=[Item:4]itemNum:1)
$cntRec:=Records in selection:C76([OrderLine:49])

C_REAL:C285($vrTotalChange)
C_REAL:C285($vrQtyChange)
READ WRITE:C146([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
For ($incRec; 1; $cntRec)
	If ([OrderLine:49]obGeneral:71.costchange=Null:C1517)
		[OrderLine:49]obGeneral:71.costchange:=New object:C1471
	End if 
	[OrderLine:49]obGeneral:71.costchange.id:=$obCatalog->id
	[OrderLine:49]obGeneral:71.costchange.date:=Date:C102(String:C10(Current date:C33))
	[OrderLine:49]obGeneral:71.costchange.change:=$vrCostChange
	[OrderLine:49]obGeneral:71.costchange.percent:=$vrPerCent
	
	$vrQtyChange:=$vrQtyChange+[OrderLine:49]qtyBackLogged:8
	[OrderLine:49]profile4:35:="CostChange"
	SAVE RECORD:C53([OrderLine:49])
	NEXT RECORD:C51([OrderLine:49])
End for 
If ($ptObCatalog->orderlines=Null:C1517)
	$ptObCatalog->orderlines:=New object:C1471
End if 
$ptObCatalog->orderlines.records:=$cntRec
$ptObCatalog->orderlines.qty:=$vrQtyChange
$ptObCatalog->orderlines.changevalue:=Round:C94($vrQtyChange*$vrCostChange; 2)
REDUCE SELECTION:C351([OrderLine:49]; 0)


QUERY:C277([ProposalLine:43]; [ProposalLine:43]qty:3>0; *)
QUERY:C277([ProposalLine:43];  & ; [ProposalLine:43]itemNum:2=[Item:4]itemNum:1)
$cntRec:=Records in selection:C76([ProposalLine:43])

C_REAL:C285($vrTotalChange)
C_REAL:C285($vrQtyChange)
READ WRITE:C146([ProposalLine:43])
FIRST RECORD:C50([ProposalLine:43])
For ($incRec; 1; $cntRec)
	If ([ProposalLine:43]obGeneral:59.costchange=Null:C1517)
		[ProposalLine:43]obGeneral:59.costchange:=New object:C1471
	End if 
	[ProposalLine:43]obGeneral:59.costchange.id:=$obCatalog->id
	[ProposalLine:43]obGeneral:59.costchange.date:=$obCatalog->date
	[ProposalLine:43]obGeneral:59.costchange.change:=$vrCostChange
	[ProposalLine:43]obGeneral:59.costchange.percent:=$vrPerCent
	
	$vrQtyChange:=$vrQtyChange+[ProposalLine:43]qty:3
	[ProposalLine:43]profile3:40:="CostChange"
	SAVE RECORD:C53([ProposalLine:43])
	NEXT RECORD:C51([ProposalLine:43])
End for 
If ($ptObCatalog->proposallines=Null:C1517)
	$ptObCatalog->proposallines:=New object:C1471
End if 
$ptObCatalog->proposallines.records:=$cntRec
$ptObCatalog->proposallines.qty:=$vrQtyChange
$ptObCatalog->proposallines.changevalue:=Round:C94($vrQtyChange*$vrCostChange; 2)
REDUCE SELECTION:C351([ProposalLine:43]; 0)


QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]qtyBackLogged:5>0; *)
QUERY:C277([QQQPOLine:40];  & ; [QQQPOLine:40]itemNum:2=[Item:4]itemNum:1)
$cntRec:=Records in selection:C76([QQQPOLine:40])

C_REAL:C285($vrTotalChange)
C_REAL:C285($vrQtyChange)
READ WRITE:C146([QQQPOLine:40])
FIRST RECORD:C50([QQQPOLine:40])
For ($incRec; 1; $cntRec)
	If ([QQQPOLine:40]obGeneral:38.costchange=Null:C1517)
		[QQQPOLine:40]obGeneral:38.costchange:=New object:C1471
	End if 
	[QQQPOLine:40]obGeneral:38.costchange.id:=$obCatalog->id
	[QQQPOLine:40]obGeneral:38.costchange.date:=Date:C102(String:C10(Current date:C33))
	[QQQPOLine:40]obGeneral:38.costchange.change:=$vrCostChange
	[QQQPOLine:40]obGeneral:38.costchange.percent:=$vrPerCent
	
	$vrQtyChange:=$vrQtyChange+[QQQPOLine:40]qtyBackLogged:5
	[QQQPOLine:40]itemProfile4:33:="CostChange"
	SAVE RECORD:C53([QQQPOLine:40])
	NEXT RECORD:C51([QQQPOLine:40])
End for 
If ($ptObCatalog->polines=Null:C1517)
	$ptObCatalog->polines:=New object:C1471
End if 
$ptObCatalog->polines.records:=$cntRec
$ptObCatalog->polines.qty:=$vrQtyChange
$ptObCatalog->polines.changevalue:=Round:C94($vrQtyChange*$vrCostChange; 2)
REDUCE SELECTION:C351([QQQPOLine:40]; 0)
