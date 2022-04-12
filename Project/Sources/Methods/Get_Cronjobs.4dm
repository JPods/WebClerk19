//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/23/19, 09:47:57
// ----------------------------------------------------
// Method: Get_Cronjobs
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20200313_1014 added protection for empty or missing set

READ ONLY:C145([CronJob:82])

// get all valid cronjobs for Current User and Machine
$vtMachine:=Current machine:C483
$vtUser:=Current user:C182

// Active CronJobs
QUERY:C277([CronJob:82]; [CronJob:82]active:12=True:C214)
CREATE SET:C116([CronJob:82]; "Active")
CREATE EMPTY SET:C140([CronJob:82]; "Result")

// Current User & Current Machine
QUERY SELECTION:C341([CronJob:82]; [CronJob:82]nameid:10=$vtUser; *)
QUERY SELECTION:C341([CronJob:82]; [CronJob:82]machineName:22=$vtMachine; *)
QUERY SELECTION:C341([CronJob:82])

CREATE SET:C116([CronJob:82]; "Current")
UNION:C120("Result"; "Current"; "Result")
CLEAR SET:C117("Current")

// Current User & All Machines
If (Records in set:C195("Active")>0)
	USE SET:C118("Active")
	QUERY SELECTION:C341([CronJob:82]; [CronJob:82]nameid:10=$vtUser; *)
	QUERY SELECTION:C341([CronJob:82]; [CronJob:82]machineName:22="All@"; *)
	QUERY SELECTION:C341([CronJob:82])
	
	CREATE SET:C116([CronJob:82]; "Current")
	UNION:C120("Result"; "Current"; "Result")
	CLEAR SET:C117("Current")
End if 

// All Users & Current Machine
If (Records in set:C195("Active")>0)
	USE SET:C118("Active")
	QUERY SELECTION:C341([CronJob:82]; [CronJob:82]nameid:10="All@"; *)
	QUERY SELECTION:C341([CronJob:82]; [CronJob:82]machineName:22=$vtMachine; *)
	QUERY SELECTION:C341([CronJob:82])
	
	CREATE SET:C116([CronJob:82]; "Current")
	UNION:C120("Result"; "Current"; "Result")
	CLEAR SET:C117("Current")
End if 

// All Users & All Machines
If (Records in set:C195("Active")>0)
	USE SET:C118("Active")
	QUERY SELECTION:C341([CronJob:82]; [CronJob:82]nameid:10="All@"; *)
	QUERY SELECTION:C341([CronJob:82]; [CronJob:82]machineName:22="All@"; *)
	QUERY SELECTION:C341([CronJob:82])
	
	CREATE SET:C116([CronJob:82]; "Current")
	UNION:C120("Result"; "Current"; "Result")
End if 

// Check Result
If (Records in set:C195("Result")>0)
	USE SET:C118("Result")
Else 
	REDUCE SELECTION:C351([CronJob:82]; 0)
End if 

CLEAR SET:C117("Current")
CLEAR SET:C117("Result")
CLEAR SET:C117("Active")

READ WRITE:C146([CronJob:82])
