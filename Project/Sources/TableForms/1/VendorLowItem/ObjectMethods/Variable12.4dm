C_LONGINT:C283($index; $index2)
C_DATE:C307($baseDate)
C_LONGINT:C283($leadQty; $qtyShort)
$leadQty:=0
KeyModifierCurrent
If (OptKey=0)
	$baseDate:=Date_ThisMon(Current date:C33; 1)+1
End if 
READ ONLY:C145([Item:4])
READ ONLY:C145([Usage:5])
Itm_FillLowVend(0; 0; 0; 0; 0)
For ($index; 1; Size of array:C274(aLwVndLines))
	QUERY:C277([Item:4]; [Item:4]vendorID:45=aVndAlpha{aLwVndLines{$index}})
	FIRST RECORD:C50([Item:4])
	$cntRecs:=Records in selection:C76([Item:4])
	For ($index2; 1; $cntRecs)
		If (OptKey=0)
			QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]itemNum:1; *)
			QUERY:C277([Usage:5];  & [Usage:5]periodDate:2=$baseDate)
			$leadQty:=Round:C94([Usage:5]salesQtyPlan:3*([Item:4]leadTimeSales:12/30); 0)
		End if 
		$qtyShort:=[Item:4]qtyOnHand:14+[Item:4]qtyOnPo:20-[Item:4]qtyOnSalesOrder:16-$leadQty-[Item:4]qtyMinStock:18
		If (($qtyShort<0) | (OptKey=1))
			Itm_FillLowVend(1; 1; 1; $qtyShort; $leadQty)  //action; element; num elements; short; forecast
		End if 
		NEXT RECORD:C51([Item:4])
	End for 
End for   //selected vendor array 
doSearch:=2000
READ WRITE:C146([Item:4])
READ WRITE:C146([Usage:5])