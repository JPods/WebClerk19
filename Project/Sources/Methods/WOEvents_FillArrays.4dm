//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/20/06, 13:22:14
// ----------------------------------------------------
// Method: WOEvents_FillArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------
//WO_FillArrays (0)

//Procedure: WO_FillArrays
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aWOEventReason; 0)
		ARRAY LONGINT:C221(aWoEventTimeOrig; 0)
		ARRAY LONGINT:C221(aWoeventID; 0)
		ARRAY DATE:C224(aWoEventDateOrig; 0)
		ARRAY LONGINT:C221(aWoEventWoNum; 0)
		ARRAY LONGINT:C221(aWoEventRecNum; 0)
		//
		ARRAY LONGINT:C221(aWoEventsLns; 0)  //selection array
	: ($1>0)
		SELECTION TO ARRAY:C260([WorkOrderEvent:121]; aWoEventRecNum; [WorkOrderEvent:121]dateOrig:3; aWoEventDateOrig; [WorkOrderEvent:121]action:4; aWOEventReason; [WorkOrderEvent:121]timeOrig:2; aWoEventTimeOrig; [WorkOrderEvent:121]idNum:1; aWoeventID; [WorkOrderEvent:121]woNum:5; aWoEventWoNum)
		ARRAY LONGINT:C221(aWoStepLns; 0)
	: (($1=-1) | ($1=-2))  //delete an element
		//-2  delete an element in array only
		If (aWoEventRecNum{$2}>-1)
			READ WRITE:C146([WorkOrderEvent:121])
			GOTO RECORD:C242([WorkOrderEvent:121]; aWoEventRecNum{$2})
			DELETE RECORD:C58([WorkOrderEvent:121])
			//READ ONLY([WorkOrderEvent])
		End if 
		DELETE FROM ARRAY:C228(aWOEventReason; $2; $3)
		DELETE FROM ARRAY:C228(aWoEventTimeOrig; $2; $3)
		DELETE FROM ARRAY:C228(aWoeventID; $2; $3)
		DELETE FROM ARRAY:C228(aWoEventDateOrig; $2; $3)
		DELETE FROM ARRAY:C228(aWoEventWoNum; $2; $3)
		DELETE FROM ARRAY:C228(aWoEventRecNum; $2; $3)
		//
		ARRAY LONGINT:C221(aWoEventsLns; 0)  //selection array
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aWOEventReason; $2; $3)
		INSERT IN ARRAY:C227(aWoEventTimeOrig; $2; $3)
		INSERT IN ARRAY:C227(aWoeventID; $2; $3)
		INSERT IN ARRAY:C227(aWoEventDateOrig; $2; $3)
		INSERT IN ARRAY:C227(aWoEventWoNum; $2; $3)
		INSERT IN ARRAY:C227(aWoEventRecNum; $2; $3)
		//
		ARRAY LONGINT:C221(aWoEventsLns; 0)  //selection array
	: ($1=-4)  //Fill a record
		
		[WorkOrderEvent:121]dateOrig:3:=aWoEventDateOrig{$2}
		[WorkOrderEvent:121]action:4:=aWOEventReason{$2}
		[WorkOrderEvent:121]timeOrig:2:=aWoEventTimeOrig{$2}
		[WorkOrderEvent:121]idNum:1:=aWoeventID{$2}
		[WorkOrderEvent:121]woNum:5:=aWoEventWoNum{$2}
		//
	: ($1=-5)  //array to selection
		
End case 
