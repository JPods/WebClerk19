// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/22/06, 16:31:46
// ----------------------------------------------------
// Method: Form Method: iWorkOrders_9
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[WorkOrder:66])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		WOEvents_FillArrays(0)
		WoTasksFillArrays(0)
		[WorkOrder:66]actionBy:8:=Current user:C182
		[WorkOrder:66]idNum:29:=CounterNew(->[WorkOrder:66])
		[WorkOrder:66]dtCreated:44:=DateTime_DTTo
		If (<>vTempDate1#!00-00-00!)
			[WorkOrder:66]dtAction:5:=DateTime_DTTo(<>vTempDate1; <>vTempTime1)
		End if 
		If (<>vTempText1#"")
			[WorkOrder:66]actionBy:8:=<>vTempText1
		Else 
			[WorkOrder:66]actionBy:8:=Current user:C182
		End if 
		<>vTempDate1:=!00-00-00!
		<>vTempTime1:=?00:00:00?
		<>vTempText1:=""
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	iLoText5:=""  // sandbox
	iLoText4:=""
	
	If ([WorkOrder:66]idNumTask:22#[Order:3]idNumTask:85)
		QUERY:C277([Order:3]; [Order:3]idNumTask:85=[WorkOrder:66]idNumTask:22)
	End if 
	
	pPartNum:=[WorkOrder:66]itemNum:12
	srWO:=[WorkOrder:66]idNum:29
	WOCustomerLoad
	
	
	// ### bj ### 20201127_2109  force these to become the same
	If ([WorkOrder:66]actionDate:105#!00-00-00!)
		[WorkOrder:66]dtAction:5:=DateTime_DTTo([WorkOrder:66]actionDate:105; [WorkOrder:66]actionTime:111)
	End if 
	DateTime_DTFrom([WorkOrder:66]dtAction:5; ->vdWoAction; ->vtWoAction)
	If ([WorkOrder:66]actionDate:105=!00-00-00!)
		[WorkOrder:66]actionDate:105:=vdWoAction
		[WorkOrder:66]actionTime:111:=vtWoAction
	End if 
	// ### bj ### 20190428_0906
	// driving everything from the human readable dates and times
	[WorkOrder:66]dtEndPlanned:69:=DateTime_DTTo([WorkOrder:66]dateBegin:106; [WorkOrder:66]timeBegin:109)  // assure alignment
	[WorkOrder:66]dtBeginPlanned:107:=DateTime_DTTo([WorkOrder:66]dateEnd:108; [WorkOrder:66]timeEnd:110)  // assure alignment
	
	DateTime_DTFrom([WorkOrder:66]dtCreated:44; ->iLoDate1; ->iLoTime1)
	DateTime_DTFrom([WorkOrder:66]dtRequested:31; ->iLoDate2; ->iLoTime2)
	
	DateTime_DTFrom([WorkOrder:66]dtStarted:79; ->iLoDate4; ->iLoTime4)
	DateTime_DTFrom([WorkOrder:66]dtUpdated:78; ->iLoDate5; ->iLoTime5)
	DateTime_DTFrom([WorkOrder:66]dtComplete:6; ->iLoDate6; ->iLoTime6)
	DateTime_DTFrom([WorkOrder:66]dtArchived:81; ->iLoDate7; ->iLoTime7)
	
End if 
If (myOK=6)
	[WorkOrder:66]dtAction:5:=DateTime_DTTo(vDate5; vTime1)
	[WorkOrder:66]actionBy:8:=Current user:C182
	myOK:=0
End if 

booAccept:=True:C214  // no madatory fields


