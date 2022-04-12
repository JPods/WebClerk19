//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-09-11T00:00:00, 12:54:00
// ----------------------------------------------------
// Method: CounterNew
// Description
// Modified: 09/11/14
// Structure: CEv13_131005
//
//
// Parameters
// ----------------------------------------------------

//  REF:  (P): StructureToArrays
var $1 : Variant
var $tableName : Text
Case of 
	: ((Value type:C1509($1)=Is longint:K8:6) | (Value type:C1509($1)=Is real:K8:4) | (Value type:C1509($1)=Is integer:K8:5))
		$tableName:=Table name:C256($1)
	: ((Value type:C1509($1)=Is text:K8:3) | (Value type:C1509($1)=Is string var:K8:2))
		$tableName:=$1
	: (Value type:C1509($1)=Is object:K8:27)
		$tableName:=$1
	: (Value type:C1509($1)=12)
		$tableName:=$1
	: (Value type:C1509($1)=Is pointer:K8:14)
		$tableName:=Table name:C256($1)
	Else 
		//
End case 

var $ptProtectedField; $ptTable : Pointer
$ptTable:=STR_GetTablePointer($tableName)

READ WRITE:C146([CounterPending:135])

var $protectedFieldNum; $protectedFieldSigned; $totalRecs; $uniqueToRecover : Integer

var $protectedFieldName; $tableName : Text
var $lockedNums; $tableNum : Integer
// Set in StructureToArrays


If ($ptTable=(->[DialingInfo:81]))
	$vbDoCounter:=False:C215
	CREATE RECORD:C68([DialingInfo:81])  // creating a taskID
	$0:=[DialingInfo:81]idNum:7
	REDUCE SELECTION:C351([DialingInfo:81]; 0)  // abandon the record
Else 
	$vbDoCounter:=True:C214
	Case of 
		: ($ptTable=(->[Customer:2]))
		: ($ptTable=(->[Vendor:38]))
		: ($ptTable=(->[Rep:8]))
		: ($ptTable=(->[Item:4]))
			
			// numbers
		Else 
			$vbDoCounter:=False:C215
	End case 
	If ($vbDoCounter)
		$tableNum:=Table:C252($ptTable)
		READ ONLY:C145([Counter:41])
		READ WRITE:C146([CounterPending:135])
		var $endLoop : Boolean
		$tableName:=Table name:C256($ptTable)
		$endLoop:=False:C215
		$uniqueToRecover:=0
		$processName:="Counters_"+$tableName
		QUERY:C277([CounterPending:135]; [CounterPending:135]tableNum:3=$tableNum)
		If (Records in selection:C76([CounterPending:135])<5)
			QUERY:C277([Counter:41]; [Counter:41]tableNum:4=$tableNum)
			$uniqueToRecover:=[Counter:41]counter:1
			REDUCE SELECTION:C351([Counter:41]; 0)
			$childProcess:=Execute on server:C373("CounterConfirmUnique"; <>tcPrsMemory; $processName; $tableNum; $uniqueToRecover)
			DELAY PROCESS:C323(Current process:C322; 60)
			QUERY:C277([CounterPending:135]; [CounterPending:135]tableNum:3=$tableNum)
		End if 
		$mycount:=0
		$recCount:=Records in selection:C76([CounterPending:135])
		$0:=-1000
		
		Repeat   // loop until a counterpending is available and then consume it.
			ORDER BY:C49([CounterPending:135]; [CounterPending:135]pendingNum:4; >)
			FIRST RECORD:C50([CounterPending:135])
			$mycount:=$mycount+1
			$recCount:=Records in selection:C76([CounterPending:135])
			For ($incRec; 1; $recCount)
				If (Locked:C147([CounterPending:135]))
					NEXT RECORD:C51([CounterPending:135])
				Else 
					$0:=[CounterPending:135]pendingNum:4
					// ### jwm ### 20170915_1123 begin
					If ($recCount<<>viCounterPending)
						$uniqueToRecover:=[CounterPending:135]pendingNum:4+$recCount  // build counter pending up to buffer size
					Else 
						$uniqueToRecover:=[CounterPending:135]pendingNum:4+<>viCounterPending  // increment by buffer size
					End if 
					// ### jwm ### 20170915_1123 end
					DELETE RECORD:C58([CounterPending:135])
					$incRec:=$recCount  // drop out
					$endLoop:=True:C214
				End if 
			End for 
			
			If ($endLoop)
				$childProcess:=Execute on server:C373("CounterConfirmUnique"; <>tcPrsMemory; $processName; $tableNum; $uniqueToRecover)  // finished
			Else 
				If ($mycount=1)
					QUERY:C277([Counter:41]; [Counter:41]tableNum:4=$tableNum)
					$uniqueToRecover:=[Counter:41]counter:1
					REDUCE SELECTION:C351([Counter:41]; 0)
					// ran thru all records without success
					// send a call to build
					$childProcess:=Execute on server:C373("CounterConfirmUnique"; <>tcPrsMemory; $processName; $tableNum; $uniqueToRecover)
				End if 
				DELAY PROCESS:C323(Current process:C322; 30)
				QUERY:C277([CounterPending:135]; [CounterPending:135]tableNum:3=$tableNum)
			End if 
		Until ($endLoop)  // if there is no record the value will be zero
	End if 
	READ WRITE:C146([Counter:41])
	READ WRITE:C146([CounterPending:135])
	REDUCE SELECTION:C351([CounterPending:135]; 0)
	REDUCE SELECTION:C351([Counter:41]; 0)
End if 