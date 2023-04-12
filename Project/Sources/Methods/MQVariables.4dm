//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/02/19, 14:15:39
// ----------------------------------------------------
// Method: MQVariables
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $action)
If (Count parameters:C259=1)
	$action:=$1
Else 
	$action:="send"
End if 
// must have records for
// [Customer]
// [Contact]
// [WorkOrder]
//  [WorkOrderEvent]
// [TallyMaster]

C_TEXT:C284(dtEpochCreated; dtEpochUpdated; dtEpochArchived)
C_TEXT:C284(dtEpochRequested; dtEpochReleased; dtEpochPlanned; dtEpochStarted)
C_TEXT:C284(dtEpochCompleted; dtEpochEndPlan)

C_TEXT:C284(vtMapTasQWorkerID; vtMapTasQPhone; vtMapTasQemail; vtMapTasQpin)
C_TEXT:C284(vtSender)

C_LONGINT:C283(vrdurationplanned)  // days or fractions of days
C_TEXT:C284(vtdurationplanned)
C_TEXT:C284(vtLat1; vtLat2; vtLng1; vtLng2)

C_TEXT:C284(vtEmployeeUUID)

C_BOOLEAN:C305(<>vbAllowTextZero)
<>vbAllowTextZero:=True:C214

// header
vtMapTasQAccountID:=[Customer:2]customerID:1  // change to a sequence number
vtDeviceID:=Current machine:C483  // [WorkOrder]NameApproved  // +"-"+
vtMapTasQSender:=[Customer:2]id:127

If ($action="send")
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtCreated:44; ->dtEpochCreated)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtUpdated:78; ->dtEpochUpdated)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtArchived:81; ->dtEpochArchived)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtRequested:31; ->dtEpochRequested)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtReleased:4; ->dtEpochReleased)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtAction:5; ->dtEpochPlanned)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtStarted:79; ->dtEpochStarted)
	// ### bj ### 20190428_0958  so they are always aligned
	[WorkOrder:66]dtBeginPlanned:107:=DateTime_DTTo([WorkOrder:66]dateBegin:106; [WorkOrder:66]timeBegin:109)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtBeginPlanned:107; ->dtEpochBeginPlan)
	[WorkOrder:66]dtEndPlanned:69:=DateTime_DTTo([WorkOrder:66]dateEnd:108; [WorkOrder:66]timeEnd:110)
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtEndPlanned:69; ->dtEpochEndPlan)
	
	DateTimeDTEpoch("ToEpoch"; ->[WorkOrder:66]dtComplete:6; ->dtEpochCompleted)
	
	DateTimeEpoch  // sets variable dtEpochCurrent to current data time, with zero parameters
	
	//  http://139.59.95.142:8080/webtrak-server/uploads/  photo name
	
	If (False:C215)  // seconds 
		vrdurationplanned:=Round:C94([WorkOrder:66]durationPlanned:10*8*3600; 0)
	End if 
	Case of 
		: ([WorkOrder:66]unitTime:18="Min@")
			vrdurationplanned:=Round:C94([WorkOrder:66]durationPlanned:10*60*1000; 0)
		: ([WorkOrder:66]unitTime:18="Day@")
			
			C_LONGINT:C283(<>hoursInWorkDay)
			If (<>hoursInWorkDay=0)
				<>hoursInWorkDay:=8
			End if 
			vrdurationplanned:=Round:C94([WorkOrder:66]durationPlanned:10*<>hoursInWorkDay*3600*1000; 0)
		Else 
			//  : ([WorkOrder]UnitTime="Ho@")
			vrdurationplanned:=Round:C94([WorkOrder:66]durationPlanned:10*3600*1000; 0)
	End case 
	//[WorkOrder]lat; ->vtLat1; ->vtLng1)
	//LatLngFromString([WorkOrder]latEnd; ->vtLat2; ->vtLng2)
	
	vtMapTasQWorker:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
	vtMapTasQWorkerID:=[Contact:13]id:62
	vtMapTasQPhone:=[Contact:13]phoneCell:52
	vtMapTasQpin:=[Contact:13]profile5:22
	vtMapTasQemail:=[Contact:13]email:35
End if 