//%attributes = {}
// (PM) WC_ThreadPoolStart
// Launches a pool of threads (processes)
// $1 = Thread count
// $2 = Stack size
// $3 = Process name

C_LONGINT:C283($1; $2; $count; $stackSize; $index; $processID)
C_TEXT:C284($3; $processName)

$count:=$1
$stackSize:=$2
$processName:=Substring:C12($3; 1; 28)
NTKThreadPool__Init
NTKArray_SetSize($count; -><>ThreadPool_ThreadID; -><>ThreadPool_IsAvailable; -><>ThreadPool_jitURL)
<>ThreadPool_Stop:=False:C215

// Launch the processes for our thread pool
For ($index; 1; $count)
	
	$processID:=Process number:C372($processName+" "+String:C10($index))
	//
	<>ThreadPool_jitURL{$index}:=""
	//
	If ($processID=0)
		<>ThreadPool_IsAvailable{$index}:=True:C214
		<>ThreadPool_ThreadID{$index}:=New process:C317("WC_ThreadPoolWorker"; $stackSize; $processName+" "+String:C10($index))
	Else 
		<>ThreadPool_ThreadID{$index}:=$processID
	End if 
	
End for 

