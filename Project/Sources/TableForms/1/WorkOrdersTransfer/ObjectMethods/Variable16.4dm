// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/02/14, 13:14:13
// ----------------------------------------------------
// Method: [Control].WorkOrdersTransfer.Variable16
// Description: Receive Button
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141202_1313 added WOTransfers_Query

ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)
//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
$cntRec:=Size of array:C274(aRecvRecs)
If ($cntRec>0)
	
	If ((iLo80String1="") | (iLo80String2="") | (iLo80String3="") | (iLo80String4=""))
		ALERT:C41("Set who and locations")
	Else 
		
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
		
		$dtcurrent:=DateTime_Enter
		READ WRITE:C146([WorkOrder:66])  // ### jwm ### 20150114_1455 was accidentally commented out
		//CREATE SET([WorkOrder];"Current")
		For ($i; 1; $k)
			
			WO_TransferReceive($aUniqIds{$i}; iLo80String2; Current user:C182; "")  //[WorkOrder]Status:="CompletedTransfer"
			C_LONGINT:C283($workOrderNum)
			
		End for 
		//USE SET("Current")
		//CLEAR SET("Current")
	End if 
	//ORDER BY([WorkOrder];[WorkOrder]WONum;<)  //### jwm ### 20130207_1727
	// ### jwm ### 20141202_1313
	WOTransfers_Query
	WOTransfers_Sort(iLoText2)
	//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
End if 