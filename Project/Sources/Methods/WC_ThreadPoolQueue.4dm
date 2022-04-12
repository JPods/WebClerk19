//%attributes = {}
// (PM) WC_ThreadPoolQueue
// Queues a work item for the thread pool
// $1 = Method name to execute
// $2 = Parameter

C_TEXT:C284($1; $2; $method; $params)
C_LONGINT:C283($index)

$method:=$1
$params:=$2
IPC Send(<>ThreadPool_IPCChannel; $method; $params)

// Check if there is a thread available
$index:=Find in array:C230(<>ThreadPool_IsAvailable; True:C214)
If ($index#-1)
	// If so, wake it up
	RESUME PROCESS:C320(<>ThreadPool_ThreadID{$index})
Else 
	// Otherwise the first available thread will automatically pick up the task
End if 
