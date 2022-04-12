// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/20/14, 15:41:36
// ----------------------------------------------------
// Method: [Control].WorkOrdersTransfer.Variable2
// Description
// 
//
// Parameters
// ----------------------------------------------------


ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)
//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
$cntRec:=Size of array:C274(aRecvRecs)
If ($cntRec>0)
	//get the uniqueIDs for the selected rows
	$cntRec:=Size of array:C274(aRecvRecs)
	For ($incRec; 1; $cntRec)
		//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{$incRec}; 2; $tData)
		
		// Preg Replace( find ; replace ; subject { ; flags ; maxTimes }) --> result
		
		// Modified by: Medlen (2013-12-18T00:00:00)
		$tData:=Preg Replace("[^0-9]"; ""; $tData; Regex Multi Line+Regex Ignore Case)
		APPEND TO ARRAY:C911($aUniqIds; Num:C11($tData))
	End for 
	
	QUERY WITH ARRAY:C644([WorkOrder:66]woNum:29; $aUniqIds)
	ProcessTableOpen(Table:C252(->[WorkOrder:66]))
	
	//ARRAY LONGINT(<>aLongInt1;0)
	//COPY ARRAY($aUniqIds;<>aLongInt1)
	//vText1:="jSetFromArray (->[WorkOrder];-><>aLongInt1;0;->[WorkOrder]WONum)"
	//ProcessTableOpen (Table(->[WorkOrder]);vText1;"";->[WorkOrder])
End if 


