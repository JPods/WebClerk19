
If (False:C215)
	// On Server Close Connection Database Method
	C_LONGINT:C283($1; $2; $3)
	// Retrieve the [ServerLog] record
	QUERY:C277([ServerLog:128]; [ServerLog:128]userid:4=$1; *)
	QUERY:C277([ServerLog:128];  & ; [ServerLog:128]connectionid:2=$2; *)
	QUERY:C277([ServerLog:128];  & ; [ServerLog:128]processid:17=0)
	
	// Save the Exit date and time
	[ServerLog:128]dateSignOff:1:=Current date:C33
	[ServerLog:128]timeSignOff:9:=Current time:C178
	[ServerLog:128]dtSignOff:11:=DateTime_DTTo
	
	// Save the process information
	[ServerLog:128]processid:17:=Current process:C322
	PROCESS PROPERTIES:C336([ServerLog:128]processid:17; $vtProcName; $viProcState; $viProcTime)
	[ServerLog:128]processName:12:=$vtProcName
	[ServerLog:128]processState:13:=$viProcState
	//[ServerLog]ProcessTime:=Round($viProcTime/60;0)  // convert Tics to seconds (duration)
	[ServerLog:128]processTime:14:=$viProcTime
	[ServerLog:128]dataFile:16:=Data file:C490
	[ServerLog:128]structure:15:=Structure file:C489
	SAVE RECORD:C53([ServerLog:128])
End if 
