//%attributes = {}
// (PM) WC_ThreadPoolWorker
// Performs work for the thread pool

C_TEXT:C284($message; $data)
C_LONGINT:C283($index)
//
WC_InitServerProcess  //original
//
Roles_Startup
// Loop until we're told to quit
While (<>vbWCstop=False:C215)  //((Process aborted=False)&
	
	// Check if there is work available
	Case of 
		: (IPC Receive(<>ThreadPool_IPCChannel; $message; $data)=1)
			$index:=Find in array:C230(<>ThreadPool_ThreadID; Current process:C322)
			<>ThreadPool_IsAvailable{$index}:=False:C215
			EXECUTE FORMULA:C63($message+"("+$data+")")
			<>ThreadPool_IsAvailable{$index}:=True:C214
			
		Else 
			
			// Goto sleep until someone wakes us
			PAUSE PROCESS:C319(Current process:C322)
			
			If (<>vbWCstop)
				EXECUTE FORMULA:C63("WC_RequestHandler(0)")
				<>ThreadPool_IsAvailable{$index}:=False:C215
			End if 
	End case 
	
End while 
