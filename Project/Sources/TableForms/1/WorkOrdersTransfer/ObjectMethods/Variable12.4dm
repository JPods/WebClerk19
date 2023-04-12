// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/24/14, 15:47:09
// ----------------------------------------------------
// Method: [Control].WorkOrdersTransfer.Variable12
// Description: Ship Button
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141124_1421 use existing value unless empty or overridden
// ### jwm ### 20141202_1313 added WOTransfers_Query

ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)
//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
$cntRec:=Size of array:C274(aRecvRecs)
If ($cntRec>0)
	//get the uniqueIDs for the selected rows
	C_LONGINT:C283($cntRec; $incRec; $woNum; $w)
	$cntRec:=Size of array:C274(aRecvRecs)
	For ($incRec; 1; $cntRec)
		//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{$incRec}; 2; $tData)
		$woNum:=Num:C11($tData)
		APPEND TO ARRAY:C911($aUniqIds; $woNum)
	End for 
	
	$k:=Size of array:C274($aUniqIds)
	C_LONGINT:C283($i; $k)
	C_LONGINT:C283($dtcurrent)
	
	
	If ((iLo80String1="") | (iLo80String2="") | (iLo80String3="") | (iLo80String4=""))
		ALERT:C41("Set who and locations")
	Else 
		$dtcurrent:=DateTime_DTTo
		READ WRITE:C146([WorkOrder:66])
		//CREATE SET([WorkOrder];"Current")
		For ($i; 1; $k)
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNum:29=$aUniqIds{$i})
			
			C_LONGINT:C283($workOrderNum)
			If ([WorkOrder:66]action:33="RequestedTransfer")
				[WorkOrder:66]action:33:="PendingTransfer"
				// ### jwm ### 20141124_1421 use existing value unless empty or overridden
				If (([WorkOrder:66]siteIDFrom:62="") | (Macintosh option down:C545) | (Windows Alt down:C563))
					[WorkOrder:66]siteIDFrom:62:=iLo80String1
				End if 
				// ### jwm ### 20141124_1421 use existing value unless empty or overridden
				If (([WorkOrder:66]siteIDTo:61="") | (Macintosh option down:C545) | (Windows Alt down:C563))
					[WorkOrder:66]siteIDTo:61:=iLo80String2
				End if 
				// ### jwm ### 20141124_1421 use existing value unless empty or overridden
				If (([WorkOrder:66]actionByLast:65="") | (Macintosh option down:C545) | (Windows Alt down:C563))
					[WorkOrder:66]actionByLast:65:=iLo80String3
				End if 
				// ### jwm ### 20141124_1421 use existing value unless empty or overridden
				If (([WorkOrder:66]actionBy:8="") | (Macintosh option down:C545) | (Windows Alt down:C563))
					[WorkOrder:66]actionBy:8:=iLo80String4
				End if 
				// ### jwm ### 20141124_1421 use existing value unless empty or overridden
				If (([WorkOrder:66]activity:7="") | (Macintosh option down:C545) | (Windows Alt down:C563))
					[WorkOrder:66]activity:7:=iLo80String5
				End if 
				[WorkOrder:66]actionByInitiated:9:=Current user:C182
				[WorkOrder:66]dtAction:5:=$dtcurrent
				[WorkOrder:66]qty:14:=[WorkOrder:66]qtyOrdered:13
				SAVE RECORD:C53([WorkOrder:66])
				WOTransfer_dInventory("Ship")
				//
				WOTransferPrint
				//
				UNLOAD RECORD:C212([UserReport:46])
			End if 
		End for 
		//USE SET("Current")
		//CLEAR SET("Current")
	End if 
End if 
// ### jwm ### 20141202_1313
WOTransfers_Query
WOTransfers_Sort(iLoText2)
//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)

