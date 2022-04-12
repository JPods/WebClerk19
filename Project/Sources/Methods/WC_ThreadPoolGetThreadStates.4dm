//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/08/08, 10:05:03
// ----------------------------------------------------
// Method: WC_ThreadPoolGetThreadStates
// Description

// Fills a bunch of arrays with info about the various threads and their states
// $1 = Pointer to array with process ID
// $2 = Pointer to array with process name
// $3 = Pointer to array with process state
// ----------------------------------------------------



C_POINTER:C301($1; $processIDs)
C_POINTER:C301($2; $processNames)
C_POINTER:C301($3; $processStates)
C_LONGINT:C283($index; $count; $processID; $processState; $processTime)
C_TEXT:C284($processName)

$processIDs:=$1
$processNames:=$2
$processStates:=$3

If (Type:C295(<>ThreadPool_ThreadID)=Is undefined:K8:13)
	$count:=0
Else 
	$count:=Size of array:C274(<>ThreadPool_ThreadID)
End if 

Array_SetSize($count; $processIDs; $processNames; $processStates)
For ($index; 1; $count)
	
	$processID:=<>ThreadPool_ThreadID{$index}
	PROCESS PROPERTIES:C336($processID; $processName; $processState; $processTime)
	If (<>viDebugMode>0)
		
	End if 
	
	$processIDs->{$index}:=$processID
	$processNames->{$index}:=$processName
	
	Case of 
		: ($processState=Does not exist:K13:3)
			$processStates->{$index}:="Does not exist"
		: ($processState=Aborted:K13:1)
			$processStates->{$index}:="Aborted"
		: ($processState=Executing:K13:4)
			$processStates->{$index}:="Executing; "+<>ThreadPool_jitURL{$index}
		: ($processState=Delayed:K13:2)
			$processStates->{$index}:="Delayed"
		: ($processState=Waiting for user event:K13:9)
			$processStates->{$index}:="Waiting for user event; "+<>ThreadPool_jitURL{$index}
		: ($processState=Waiting for input output:K13:7)
			$processStates->{$index}:="Waiting for input output; "+<>ThreadPool_jitURL{$index}
		: ($processState=Waiting for internal flag:K13:8)
			$processStates->{$index}:="Waiting for internal flag"
		: ($processState=Paused:K13:6)
			$processStates->{$index}:="Paused"
	End case 
	
End for 


