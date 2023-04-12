//%attributes = {"publishedWeb":true}
//Method: Http_ItemReservationEach
C_LONGINT:C283($1)
C_TEXT:C284(vReservations)
//
//example from http_PostOrd
C_LONGINT:C283($endCycle; $endCart; $k; $endTime)
$endTime:=DateTime_DTTo
$endCycle:=$endTime-(<>vlCycleTime*60)
$endCart:=$endTime-(<>vlCartTime*60)
//QUERY([Reservation];[Reservation]DTActionLast>=$endCycle;*)
//QUERY([Reservation];|[Reservation]DTOriginated>=<>vlCartTime;*)
//QUERY([Reservation];|[Reservation]OrderNum>0;*)
QUERY:C277([Reservation:79]; [Reservation:79]active:10=True:C214; *)
QUERY:C277([Reservation:79];  & [Reservation:79]itemNum:1=[Item:4]itemNum:1)
//TRACE
If (Records in selection:C76([Reservation:79])=0)
	vReservations:=""
Else 
	vReservations:=WC_PageLoad(WC_DoPage("ReservationTextInItems.html"; ""))
	
	vReservations:=TagsToText(vReservations)
	ARRAY REAL:C219($aQty; 0)
	ARRAY LONGINT:C221($aSalesOrd; 0)
	SELECTION TO ARRAY:C260([Reservation:79]qtyReserved:6; $aQty; [Reservation:79]idNumOrder:14; $aSalesOrd)
	C_LONGINT:C283($i; $k)
	C_REAL:C285($qtyOnReserve)
	$k:=Size of array:C274($aQty)
	For ($i; 1; $k)
		If ($aSalesOrd{$i}=0)
			$qtyOnReserve:=$qtyOnReserve+$aQty{$i}
		End if 
	End for 
	pvQtyAvailable:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16-([Item:4]qtyAllocated:72*Num:C11([Item:4]qtyAllocated:72>0))-$qtyOnReserve
	pvQtyAvailable:=pvQtyAvailable*(Num:C11(pvQtyAvailable>0))
End if 