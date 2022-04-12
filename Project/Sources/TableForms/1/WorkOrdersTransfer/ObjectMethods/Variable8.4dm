// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/02/14, 13:19:20
// ----------------------------------------------------
// Method: [Control].WorkOrdersTransfer.Variable8
// Description Clone Button
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141202_1313 added WOTransers_Query

ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)
//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
$keyIndex:=2
$cntRec:=Size of array:C274(aRecvRecs)


CONFIRM:C162("Clone, there is no UnDo?")
If (OK=1)
	C_LONGINT:C283($dtcurrent)
	$dtcurrent:=DateTime_Enter
	//CREATE SET([WorkOrder];"Current")
	$cntRec:=Size of array:C274(aRecvRecs)
	ARRAY LONGINT:C221($aUniqueIDs; 0)
	For ($incRec; 1; $cntRec)
		//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{$incRec}; $keyIndex; $tData)
		APPEND TO ARRAY:C911($aUniqueIDs; Num:C11($tData))
	End for 
	READ ONLY:C145([Item:4])
	For ($incRec; 1; $cntRec)
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$aUniqueIDs{$incRec})
		If (Records in selection:C76([WorkOrder:66])=1)
			DUPLICATE RECORD:C225([WorkOrder:66])
			[WorkOrder:66]woNum:29:=CounterNew(->[WorkOrder:66])
			[WorkOrder:66]qtyActual:14:=0
			[WorkOrder:66]action:33:="RequestedTransfer"
			[WorkOrder:66]dtComplete:6:=0
			[WorkOrder:66]dtAction:5:=DateTime_Enter(iLoDate1)
			[WorkOrder:66]dateComplete:64:=iLoDate1
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[WorkOrder:66]itemNum:12)
			[WorkOrder:66]itemDescript:34:=[Item:4]description:7
			[WorkOrder:66]costPlanned:15:=[Item:4]costAverage:13
			[WorkOrder:66]groupid:32:=vltaskID
			[WorkOrder:66]idNumTask:22:=vltaskID
			[WorkOrder:66]actionByInitiated:9:=Current user:C182
			[WorkOrder:66]actionByApproved:48:=iLo80String3
			[WorkOrder:66]actionBy:8:=iLo80String4
			[WorkOrder:66]woType:60:="Transfer"
			[WorkOrder:66]activity:7:="Transfer"
			[WorkOrder:66]profile2:38:="cloned: "+String:C10($aUniqueIDs{$incRec})
			[WorkOrder:66]profile4:40:=Current user:C182
			[WorkOrder:66]profile3:39:=Current machine:C483
			SAVE RECORD:C53([WorkOrder:66])
			//ADD TO SET([WorkOrder];"Current")
		End if 
	End for 
	//USE SET("Current")
	//CLEAR SET("Current")
	// ### jwm ### 20141202_1313
	WOTransfers_Query
	WOTransfers_Sort(iLoText2)
	//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
	REDUCE SELECTION:C351([Item:4]; 0)
End if 
