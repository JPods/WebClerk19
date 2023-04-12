// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 01/28/13, 16:32:18
// ----------------------------------------------------
// Method: Object Method: B22
// Description:  Close Button
// File: Object Method: B22.txt
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141202_1313 added WOTransfers_Query
// ### jwm ### 20150204_0932 added check for User In Group

// ### jwm ### 20150204_0932
If (Not:C34(UserInPassWordGroup("Inventory")))
	ALERT:C41("User Does not have Authority - Inventory")
Else 
	
	ARRAY LONGINT:C221(aRecvRecs; 0)
	ARRAY LONGINT:C221($aUniqIds; 0)
	//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
	$cntRec:=Size of array:C274(aRecvRecs)
	If ($cntRec>0)
		//get the uniqueIDs for the selected rows
		$cntRec:=Size of array:C274(aRecvRecs)
		For ($incRec; 1; $cntRec)
			//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{$incRec}; 2; $tData)
			INSERT IN ARRAY:C227($aUniqIds; 1; 1)
			$aUniqIds{1}:=Num:C11($tData)
		End for 
		//CREATE SET([WorkOrder];"Current")
		$k:=Size of array:C274($aUniqIds)
		C_LONGINT:C283($i; $k)
		C_LONGINT:C283($dtcurrent)
		$dtcurrent:=DateTime_DTTo
		//READ WRITE([WorkOrder])
		//CREATE SET([WorkOrder];"Current")
		
		For ($i; 1; $k)
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNum:29=$aUniqIds{$i})
			C_LONGINT:C283($workOrderNum)
			//CONFIRM("Query and receive "+String([WorkOrder]WONum))
			
			If ([WorkOrder:66]action:33="RequestedTransfer")
				[WorkOrder:66]action:33:="ClosedTransfer"
				//### jwm ### 20130128_1541
				//[WorkOrder]DateCompleted:=$dtcurrent
				DateTime_DTFrom($dtcurrent; ->[WorkOrder:66]dateComplete:64)
				SAVE RECORD:C53([WorkOrder:66])
			End if 
			
		End for 
		//USE SET("Current")
		//CLEAR SET("Current")
	End if 
	// ### jwm ### 20141202_1313
	WOTransfers_Query
	WOTransfers_Sort(iLoText2)
	//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
	
End if 