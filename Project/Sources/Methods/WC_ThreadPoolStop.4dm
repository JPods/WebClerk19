//%attributes = {}
// (PM) WC_ThreadPoolStop
// Stops the thread pool

C_LONGINT:C283($index)

<>ThreadPool_Stop:=True:C214

// Wake up all the worker threads so they can stop
For ($index; 1; Size of array:C274(<>ThreadPool_ThreadID))
	RESUME PROCESS:C320(<>ThreadPool_ThreadID{$index})
End for 
