ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)
//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
$cntRec:=Size of array:C274(aRecvRecs)
If ($cntRec>0)
	//get the uniqueIDs for the selected rows
	$cntRec:=Size of array:C274(aRecvRecs)
	
	//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{1}; 2; $tData)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=Num:C11($tData))
	vltaskID:=[WorkOrder:66]idNumTask:22
	
	QUERY:C277([WorkOrder:66];  & ; [WorkOrder:66]idNumTask:22=vltaskID)
	WOTransfers_Sort(iLoText2)
	//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
	
End if 