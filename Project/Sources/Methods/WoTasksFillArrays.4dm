//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/20/06, 13:22:08
// ----------------------------------------------------
// Method: WoTasksFillArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/20/06, 13:22:14
// ----------------------------------------------------
// Method: WOTasks_FillArrays
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
		ARRAY TEXT:C222(aWOTaskAction; 0)
		ARRAY TEXT:C222(aWOTaskActionBy; 0)
		ARRAY TEXT:C222(aWoTaskComment; 0)
		ARRAY LONGINT:C221(aWoTaskDTComplete; 0)
		ARRAY DATE:C224(aWoTaskDateComplete; 0)
		ARRAY LONGINT:C221(aWoTaskTimeComplete; 0)
		ARRAY TEXT:C222(aWoTaskItemNum; 0)
		ARRAY TEXT:C222(aWoTaskSafety; 0)
		ARRAY LONGINT:C221(aWoTaskSequence; 0)
		ARRAY TEXT:C222(aWoTaskTools; 0)
		ARRAY LONGINT:C221(aWotaskID; 0)
		ARRAY LONGINT:C221(aWoTaskWONum; 0)
		ARRAY LONGINT:C221(aWoTaskRecNum; 0)
		//
		ARRAY LONGINT:C221(aWoTasksLns; 0)  //selection array
	: ($1>0)
		SELECTION TO ARRAY:C260([WorkOrderTask:67]action:3; aWOTaskAction; [WorkOrderTask:67]actionBy:7; aWOTaskActionBy; [WorkOrderTask:67]comment:8; aWoTaskComment; [WorkOrderTask:67]dtComplete:6; aWoTaskDTComplete; [WorkOrderTask:67]itemNum:1; aWoTaskItemNum; [WorkOrderTask:67]safety:5; aWoTaskSafety; [WorkOrderTask:67]seq:2; aWoTaskSequence; [WorkOrderTask:67]tools:4; aWoTaskTools; [WorkOrderTask:67]idNum:9; aWotaskID; [WorkOrderTask:67]woNum:10; aWoTaskWONum; [WorkOrderTask:67]; aWoTaskRecNum)
		$k:=Size of array:C274(aWoTaskDTComplete)
		ARRAY DATE:C224(aWoTaskDateComplete; $k)
		ARRAY LONGINT:C221(aWoTaskTimeComplete; $k)
		For ($i; 1; $k)
			jDateTimeRecov(aWoTaskDTComplete{$i}; ->iLoDate13; ->iLoTime13)
			aWoTaskDateComplete{$i}:=iLoDate13
			aWoTaskTimeComplete{$i}:=iLoTime13*1
		End for 
		ARRAY LONGINT:C221(aWoTasksLns; 0)
	: (($1=-1) | ($1=-2))  //delete an element
		//-2  delete an element in array only
		If (aWoTaskRecNum{$2}>-1)
			READ WRITE:C146([WorkOrderTask:67])
			GOTO RECORD:C242([WorkOrderTask:67]; aWoTaskRecNum{$2})
			DELETE RECORD:C58([WorkOrderTask:67])
			READ ONLY:C145([WorkOrderTask:67])
		End if 
		DELETE FROM ARRAY:C228(aWOTaskAction; $2; $3)
		DELETE FROM ARRAY:C228(aWOTaskActionBy; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskComment; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskDTComplete; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskDateComplete; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskTimeComplete; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskItemNum; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskSafety; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskSequence; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskTools; $2; $3)
		DELETE FROM ARRAY:C228(aWotaskID; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskWONum; $2; $3)
		DELETE FROM ARRAY:C228(aWoTaskRecNum; $2; $3)
		//
		ARRAY LONGINT:C221(aWoTasksLns; 0)  //selection array
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aWOTaskAction; $2; $3)
		INSERT IN ARRAY:C227(aWOTaskActionBy; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskComment; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskDTComplete; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskDateComplete; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskTimeComplete; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskItemNum; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskSafety; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskSequence; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskTools; $2; $3)
		INSERT IN ARRAY:C227(aWotaskID; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskWONum; $2; $3)
		INSERT IN ARRAY:C227(aWoTaskRecNum; $2; $3)
		
		//
		ARRAY LONGINT:C221(aWoTasksLns; 0)  //selection array
	: ($1=-4)  //Fill a record
		
		[WorkOrderTask:67]action:3:=aWOTaskAction{$2}
		[WorkOrderTask:67]actionBy:7:=aWOTaskActionBy{$2}
		[WorkOrderTask:67]comment:8:=aWoTaskComment{$2}
		aWoTaskDTComplete{$2}:=DateTime_Enter(aWoTaskDateComplete{$2}; aWoTaskTimeComplete{$2})
		[WorkOrderTask:67]dtComplete:6:=aWoTaskDTComplete{$2}
		[WorkOrderTask:67]itemNum:1:=aWoTaskItemNum{$2}
		[WorkOrderTask:67]safety:5:=aWoTaskSafety{$2}
		[WorkOrderTask:67]seq:2:=aWoTaskSequence{$2}
		[WorkOrderTask:67]tools:4:=aWoTaskTools{$2}
		If (False:C215)  // should be the same if existing
			[WorkOrderTask:67]idNum:9:=aWotaskID{$2}
		End if 
		[WorkOrderTask:67]woNum:10:=aWoTaskWONum{$2}
		
		
		//
	: ($1=-5)  //array to selection
		
End case 
