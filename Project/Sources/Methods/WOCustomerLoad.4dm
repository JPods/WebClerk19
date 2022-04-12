//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/22/06, 16:40:30
// ----------------------------------------------------
// Method: WOCustomerLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------
$noCust:=([WorkOrder:66]customerID:28="")
$noOrd:=([WorkOrder:66]idNumTask:22=0)
OBJECT SET ENTERABLE:C238([WorkOrder:66]idNumTask:22; $noCust)
If ($noCust)
	FontSrchLabels(1)
	REDUCE SELECTION:C351([Customer:2]; 0)
	srAddr1:=""
	srPhone:=""
	srZip:=""
	srAcct:=""
	srCustomer:=""
Else 
	If ([WorkOrder:66]customerID:28#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
	End if 
	srAddr1:=[Customer:2]address1:4
	srPhone:=[Customer:2]phone:13
	srZip:=[Customer:2]zip:8
	srAcct:=[Customer:2]customerID:1
	srCustomer:=[Customer:2]company:2
	srDisplayEmail:=[Customer:2]email:81
	FontSrchLabels(3)
End if 
If (Not:C34($noOrd))
	If ([WorkOrder:66]idNumTask:22#[Order:3]idNumTask:85)
		QUERY:C277([Order:3]; [Order:3]idNumTask:85=[WorkOrder:66]idNumTask:22)
		srAddr1:=[Order:3]address1:16
	End if 
End if 

jDateTimeRecov([WorkOrder:66]dtCreated:44; ->iLoDate1; ->iLoTime1)
jDateTimeRecov([WorkOrder:66]dtRequested:31; ->iLoDate2; ->iLoTime2)
jDateTimeRecov([WorkOrder:66]dtAction:5; ->vdWoAction; ->vtWoAction)
jDateTimeRecov([WorkOrder:66]dtStarted:79; ->iLoDate4; ->iLoTime4)
jDateTimeRecov([WorkOrder:66]dtUpdated:78; ->iLoDate5; ->iLoTime5)
jDateTimeRecov([WorkOrder:66]dtComplete:6; ->iLoDate6; ->iLoTime6)
jDateTimeRecov([WorkOrder:66]dtArchived:81; ->iLoDate7; ->iLoTime7)

QUERY:C277([WorkOrderEvent:121]; [WorkOrderEvent:121]woNum:5=[WorkOrder:66]woNum:29)
WOEvents_FillArrays(Records in selection:C76([WorkOrderEvent:121]))
If (eWOEvents>0)
	//  --  CHOPPED  AL_UpdateArrays(eWOEvents; -2)
End if 
REDUCE SELECTION:C351([WorkOrderEvent:121]; 0)
////  --  CHOPPED  AL_UpdateArrays (eWOEvents;-2)
QUERY:C277([WorkOrderTask:67]; [WorkOrderTask:67]woNum:10=[WorkOrder:66]woNum:29)
WoTasksFillArrays(Records in selection:C76([WorkOrderTask:67]))
If (eWOEvents>0)
	//  --  CHOPPED  AL_UpdateArrays(eWOTasks; -2)
End if 
REDUCE SELECTION:C351([WorkOrderTask:67]; 0)
////  --  CHOPPED  AL_UpdateArrays (eWOTasks;-2)
$doChange:=(UserInPassWordGroup("UnlockRecord"))
If (Not:C34($doChange))
	OBJECT SET ENTERABLE:C238([WorkOrder:66]publish:30; False:C215)
End if 
srWO:=[WorkOrder:66]woNum:29
pPartNum:=[WorkOrder:66]itemNum:12
//
iLoDate7:=Current date:C33
iLoTIme7:=Current time:C178