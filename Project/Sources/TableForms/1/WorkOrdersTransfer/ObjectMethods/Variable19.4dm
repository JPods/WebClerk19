ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)

REDUCE SELECTION:C351([WorkOrder:66]; 0)
iLoDate1:=Current date:C33
vltaskID:=CounterNew(->[DialingInfo:81])
If (pQtyOrd<1)
	pQtyOrd:=Num:C11(Request:C163("Enter Quantity"))
End if 

WOTransfers_Sort(iLoText2)
//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)

iLoText2:="Request"
OBJECT SET RGB COLORS:C628(iLoText2; 0x00FFFF00; 0x00FF)