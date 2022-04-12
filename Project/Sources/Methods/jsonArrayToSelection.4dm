//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/20/19, 13:00:05
// ----------------------------------------------------
// Method: jsonArrayToSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($error)
C_TEXT:C284($1; $tableName)
C_POINTER:C301($2; $ptaData)
$ptaData:=$2

$tableName:=$1
C_OBJECT:C1216($obData)
C_LONGINT:C283($tableNum; $incRay; $cntRay; $fia)
$cntRay:=Size of array:C274($ptaData->)

C_TEXT:C284($ItemNum; $Description; $UnitOfMeasure)
C_REAL:C285($QtyOrdered; $UnitCost; $Discount; $ExtendedCost)


For ($incRay; 1; $cntRay)
	$obData:=$ptaData->{$incRay}
	
	// should use mapping, but hacking this for convience
	
	$itemNum:=OB Get:C1224($obData; "ItemNum")
	$Description:=OB Get:C1224($obData; "ItemNum")
	$UnitOfMeasure:=OB Get:C1224($obData; "UnitOfMeasure")
	$QtyOrdered:=OB Get:C1224($obData; "QtyOrdered")
	$UnitCost:=OB Get:C1224($obData; "UnitCost")
	$Discount:=OB Get:C1224($obData; "Discount")
	$ExtendedCost:=OB Get:C1224($obData; "ExtendedCost")
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
	pPartNum:=[Item:4]itemNum:1
	pDescript:=[Item:4]description:7
	pUnitCost:=[Item:4]costAverage:13
	pQtyShip:=0
	// (Size of array(aPOLineAction)+1)
	POLnAdd($incRay; 1; False:C215)
	
	If ($UnitCost#aPoUnitCost{$incRay})
		[PO:39]commentProcess:63:=[PO:39]commentProcess:63+"\r"+"CostMisMatch: "+$itemNum+": "+String:C10($incRay)+": Inbound: "+String:C10($UnitCost)+": internal: "+String:C10(aPoUnitCost{$incRay})
	End if 
	
	If ($Discount#aPODiscnt{$incRay})
		[PO:39]commentProcess:63:=[PO:39]commentProcess:63+"\r"+"CostMisMatch: "+$itemNum+": "+String:C10($incRay)+": Inbound: "+String:C10($Discount)+": internal: "+String:C10(aPODiscnt{$incRay})
	End if 
	
	pUnitPrice:=$UnitCost
	aPoUnitCost{$incRay}:=$UnitCost
	
	pQtyOrd:=$QtyOrdered
	aPOQtyOrder{$incRay}:=$QtyOrdered
	
	pDiscnt:=$Discount
	aPODiscnt{$incRay}:=$Discount
	
	aPOLineAction:=$incRay
	PoLnExtend(aPOLineAction)
	
End for 

booAccept:=True:C214
acceptPO
C_LONGINT:C283(<>viRecordShow)
C_LONGINT:C283($poNum)
$poNum:=[PO:39]poNum:5
If (<>viRecordShow=1)
	C_TEXT:C284($script; $tag)
	$script:="Query([Po];[Po]ponum="+String:C10($poNum)+")"
	$tag:="SyncRecord: "+String:C10([SyncRecord:109]idNum:1)
	ProcessTableOpen(Table:C252(->[PO:39]); $script; $tag)
End if 
