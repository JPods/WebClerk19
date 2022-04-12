//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-13T00:00:00, 21:18:45
// ----------------------------------------------------
// Method: CounterResetPending
// Description
// Modified: 04/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// buttons on Counter Input Layout


C_TEXT:C284($tableName)
C_LONGINT:C283($tableNum)
If (Not:C34(Locked:C147([QQQCounter:41])))
	$tableNum:=[QQQCounter:41]TableNum:4
	$tableName:=Table name:C256($tableNum)
	
	CONFIRM:C162("Rebuild CountersPending for Table: "+$tableName)
	If (OK=1)
		READ WRITE:C146([CounterPending:135])
		SAVE RECORD:C53([QQQCounter:41])  //  save the value for Counter
		QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum)
		C_LONGINT:C283($timer)
		$timer:=Tickcount:C458+300
		C_BOOLEAN:C305($timeOut)
		$timeOut:=False:C215
		Repeat 
			DELETE SELECTION:C66([CounterPending:135])
			DELAY PROCESS:C323(Current process:C322; 60)
			
			START TRANSACTION:C239
			SET QUERY AND LOCK:C661(True:C214)
			QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum)
			//At this moment, the records found are automatically locked for all other processes
			DELETE SELECTION:C66([CounterPending:135])
			SET QUERY AND LOCK:C661(False:C215)
			VALIDATE TRANSACTION:C240
			
			If ($timer<Tickcount:C458)
				$timeOut:=True:C214
			End if 
		Until ((Records in selection:C76([CounterPending:135])=0) | ($timeOut))  //  repeat until the Pending are cleared
		If (($timeOut) | (Records in selection:C76([CounterPending:135])#0))
			ALERT:C41("Pending cannot be renumbers because of locked records.\rRestart database or clear other processes.")
			USE SET:C118("LockedSet")
			CLEAR SET:C117("LockedSet")
			ProcessTableOpen(Table:C252(->[CounterPending:135]); ""; "Locked CounterPending")
		Else 
			
			$uniqueToRecover:=[QQQCounter:41]Counter:1  // next number to be created
			
			READ ONLY:C145([CounterPending:135])
			UNLOAD RECORD:C212([QQQCounter:41])  // allow record to be written in the other process
			
			$processName:="Counters_"+$tableName
			$childProcess:=Execute on server:C373("CounterConfirmUnique"; <>tcPrsMemory; $processName; $tableNum; $uniqueToRecover)
			
			READ ONLY:C145([CounterPending:135])
			Repeat 
				DELAY PROCESS:C323(Current process:C322; 30)  // the process 5 seconds to build records
				QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum)
			Until (Records in selection:C76([CounterPending:135])>=<>viCounterPending)
			DELAY PROCESS:C323(Current process:C322; 180)  // the process 5 seconds to build records
			QUERY:C277([QQQCounter:41]; [QQQCounter:41]TableNum:4=$tableNum)
		End if 
		ORDER BY:C49([CounterPending:135]; [CounterPending:135]PendingNum:4; >)
		FIRST RECORD:C50([CounterPending:135])
		iLoLongInt1:=[CounterPending:135]PendingNum:4
		LAST RECORD:C200([CounterPending:135])
		iLoLongInt2:=[CounterPending:135]PendingNum:4
		iLoLongInt3:=Records in selection:C76([CounterPending:135])
		[QQQCounter:41]Counter:1:=iLoLongInt2+1
		
		REDUCE SELECTION:C351([CounterPending:135]; 0)
		READ WRITE:C146([CounterPending:135])
	End if 
End if 