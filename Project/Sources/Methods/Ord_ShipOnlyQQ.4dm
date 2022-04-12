//%attributes = {"publishedWeb":true}
//Procedure: Ord_ShipOnlyQQ
C_LONGINT:C283($0)
//
C_BOOLEAN:C305($open)
C_LONGINT:C283($i; $ii; $k; $j; $cntShipItem)
//
ARRAY TEXT:C222($aShipItem; 0)
$cntShipItem:=Size of array:C274(<>aItemLines)
For ($incShipItem; 1; $cntShipItem)
	GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$incShipItem}})
	INSERT IN ARRAY:C227($aShipItem; 1; 1)
	$aShipItem{1}:=[Item:4]itemNum:1
	UNLOAD RECORD:C212([Item:4])
End for 
$k:=Records in selection:C76([Order:3])
CREATE EMPTY SET:C140([Order:3]; "BackOrders")
FIRST RECORD:C50([Order:3])
For ($i; 1; $k)
	//GOTO RECORD([Order];aOrdRecs{aRayLines{$i}})
	C_LONGINT:C283($cntLines; $incLines; $w)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0)
	$cntLines:=Records in selection:C76([OrderLine:49])
	FIRST RECORD:C50([OrderLine:49])
	For ($incLines; 1; $cntLines)
		$w:=Find in array:C230($aShipItem; [OrderLine:49]itemNum:4)
		If ($w>0)
			ADD TO SET:C119([Order:3]; "BackOrders")
			$incLines:=$cntLines
		End if 
		NEXT RECORD:C51([OrderLine:49])
	End for 
	NEXT RECORD:C51([Order:3])
End for 
REDUCE SELECTION:C351([OrderLine:49]; 0)
$0:=Records in set:C195("BackOrders")
If ($0#0)
	USE SET:C118("BackOrders")
Else 
	ALERT:C41("No Records to process")
End if 
CLEAR SET:C117("BackOrders")