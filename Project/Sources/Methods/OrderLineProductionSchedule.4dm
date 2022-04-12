//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/31/12, 15:24:12
// ----------------------------------------------------
// Method: OrderLineProductSchedule
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	READ WRITE:C146([OrderLine:49])
	ALL RECORDS:C47([OrderLine:49])
	ORDER BY:C49([OrderLine:49]; [OrderLine:49]orderNum:1)
	FIRST RECORD:C50([OrderLine:49])
	vi2:=Records in selection:C76([OrderLine:49])
	For (vi1; 1; vi2)
		If ([OrderLine:49]orderNum:1#[Order:3]orderNum:2)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
		End if 
		If (Record number:C243([Order:3])=-1)
			[OrderLine:49]dateRequired:23:=!2012-09-09!
			[OrderLine:49]dateOrdered:25:=!2012-09-06!
		Else 
			If ([Order:3]dateNeeded:5<!2012-09-07!)
				[OrderLine:49]dateRequired:23:=!2012-09-07!
				[OrderLine:49]dateOrdered:25:=!2012-09-07!
			Else 
				[OrderLine:49]dateRequired:23:=[Order:3]dateNeeded:5
				[OrderLine:49]dateOrdered:25:=[Order:3]dateOrdered:4
			End if 
		End if 
		SAVE RECORD:C53([OrderLine:49])
		NEXT RECORD:C51([OrderLine:49])
	End for 
	
End if 


C_DATE:C307($1; $baseDate)
C_LONGINT:C283($k; $i; $w; $daysUntilShip)
C_BOOLEAN:C305($currentFill)
$baseDate:=Current date:C33
If (Count parameters:C259=1)
	$baseDate:=$1
End if 

//$currentFill:=<>doOrderLines
//<>doOrderLines:=True
//OrdLnFillRays 

//ALL RECORDS([OrderLine])

SELECTION TO ARRAY:C260([OrderLine:49]itemNum:4; aOItemNum; [OrderLine:49]description:5; aODescpt; [OrderLine:49]altItem:31; aOAltItem; [OrderLine:49]qtyOrdered:6; aOQtyOrder; [OrderLine:49]dateRequired:23; aODateReq)


$k:=Size of array:C274(aOItemNum)
For ($i; 1; $k)
	$w:=Find in array:C230(aLsItemNum; aOItemNum{$i})
	If ($w<1)
		APPEND TO ARRAY:C911(aLsItemNum; aOItemNum{$i})
		APPEND TO ARRAY:C911(aLsItemDesc; aODescpt{$i})
		APPEND TO ARRAY:C911(aLsQtySO; aOQtyOrder{$i})
		APPEND TO ARRAY:C911(aDisplay1; aOAltItem{$i})
		APPEND TO ARRAY:C911(aLongInt1; 0)
		APPEND TO ARRAY:C911(aLongInt2; 0)
		APPEND TO ARRAY:C911(aLongInt3; 0)
		APPEND TO ARRAY:C911(aLongInt4; 0)
		APPEND TO ARRAY:C911(aLongInt5; 0)
		APPEND TO ARRAY:C911(aLongInt6; 0)
		APPEND TO ARRAY:C911(aLongInt7; 0)
		APPEND TO ARRAY:C911(aLongInt8; 0)
		APPEND TO ARRAY:C911(aLongInt9; 0)
		APPEND TO ARRAY:C911(aLongInt10; 0)
		$w:=Size of array:C274(aLsItemNum)
	End if 
	$daysUntilShip:=aODateReq{$i}-$baseDate
	Case of 
		: ($daysUntilShip<0)
			aLongInt8{$w}:=aLongInt8{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=0)
			aLongInt10{$w}:=aLongInt10{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=1)
			aLongInt1{$w}:=aLongInt1{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=2)
			aLongInt2{$w}:=aLongInt2{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=3)
			aLongInt3{$w}:=aLongInt3{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=4)
			aLongInt4{$w}:=aLongInt4{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=5)
			aLongInt5{$w}:=aLongInt5{$w}+aOQtyOrder{$i}
		: ($daysUntilShip=6)
			aLongInt6{$w}:=aLongInt6{$w}+aOQtyOrder{$i}
		Else   // ($daysUntilShip>6)
			aLongInt7{$w}:=aLongInt7{$w}+aOQtyOrder{$i}
	End case 
End for 
SORT ARRAY:C229(aLsItemNum; aLsItemDesc; aLsQtySO; aDisplay1; aLongInt1; aLongInt2; aLongInt3; aLongInt4; aLongInt5; aLongInt6; aLongInt7; aLongInt8; aLongInt10)
<>doOrderLines:=$currentFill




