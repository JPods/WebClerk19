//%attributes = {}
// (PM) NTKThreadPool__Init
// Initializes the variables used by the thread pool

C_BOOLEAN:C305(<>ThreadPool_IsInitialised; <>ThreadPool_Stop)
C_LONGINT:C283(<>ThreadPool_IPCChannel)

If (<>ThreadPool_IsInitialised=False:C215)
	
	<>ThreadPool_IsInitialised:=True:C214
	<>ThreadPool_IPCChannel:=99999
	
	ARRAY LONGINT:C221(<>ThreadPool_ThreadID; 0)
	ARRAY BOOLEAN:C223(<>ThreadPool_IsAvailable; 0)
	ARRAY TEXT:C222(<>ThreadPool_jitURL; 0)
	//ARRAY TEXT(<>ThreadPool_eventID;0)
	
	
End if 
