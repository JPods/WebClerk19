//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-14T00:00:00, 14:22:01
// ----------------------------------------------------
// Method: CounterConfirmUnique
// Description
// Modified: 05/14/17
// 
// 
//
// Parameters
// ----------------------------------------------------

// Only method for building CounterPending

C_LONGINT:C283($1; $tableNum; $2; $uniqueToRecover; $counterCount)
C_LONGINT:C283($recordCount; $recordsFound; $moreBuffer; $typeField; $protectedFieldNum; $msCount; $loops)
C_POINTER:C301($ptTable; $ptUniqueField)
C_BOOLEAN:C305($endLoop)
READ WRITE:C146([QQQCounter:41])
READ WRITE:C146([CounterPending:135])
$msCount:=Milliseconds:C459
$endLoop:=False:C215
$tableNum:=$1
$uniqueToRecover:=$2
$tableName:=Table name:C256($tableNum)
If (Not:C34(STR_CounterNewSkip($tableName)))  // false returns positive and negative numbers (negatives are managed)
	$ptTable:=Table:C252($tableNum)
	$ptUniqueField:=STR_GetUniqueFieldPointer($tableName)  // false returns positive and negative numbers
	
	READ ONLY:C145($ptTable->)
	$typeField:=Type:C295($ptUniqueField->)
	//  QUERY([CounterPending];[CounterPending]TableNum=$tableNum)
	//  &(records in selection([CounterPending])<=<>viCounterPending))
	// do not limit record count here, do it on calling this procedure to build new, do not prevent recovery
	$vIncrement:=0
	$loops:=-1
	Repeat 
		Repeat   // Prime table loop
			If ($typeField=Is longint:K8:6)  // check to see if there is a primary record already using this ID
				QUERY:C277($ptTable->; $ptUniqueField->=$uniqueToRecover)
			Else 
				QUERY:C277($ptTable->; $ptUniqueField->=String:C10($uniqueToRecover))  // not used at this time
			End if 
			If (Records in selection:C76($ptTable->)#0)
				$uniqueToRecover:=$uniqueToRecover+1  // increment hire to step over any block of used numbers
			End if 
			$loops:=$loops+1
		Until (Records in selection:C76($ptTable->)=0)  // Until there is a unique value step over primary table records
		$loops:=$loops+1
		QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum; *)
		QUERY:C277([CounterPending:135];  & [CounterPending:135]PendingNum:4=$uniqueToRecover)
		If (Records in selection:C76([CounterPending:135])=0)
			CREATE RECORD:C68([CounterPending:135])
			[CounterPending:135]TableNum:3:=$tableNum
			[CounterPending:135]TableName:2:=$tableName
			[CounterPending:135]PendingNum:4:=$uniqueToRecover
			[CounterPending:135]MSToCreate:8:=$loops
			[CounterPending:135]Status:7:=1
			SAVE RECORD:C53([CounterPending:135])
			
			C_BOOLEAN:C305($endCounterLoop)  // if a Pending record was created, set the Counter Counter higher.
			$endCounterLoop:=False:C215
			READ WRITE:C146([QQQCounter:41])
			QUERY:C277([QQQCounter:41]; [QQQCounter:41]TableNum:4=$tableNum)
			Repeat 
				If ($uniqueToRecover>[QQQCounter:41]Counter:1)
					If (Not:C34(Locked:C147([QQQCounter:41])))
						$endCounterLoop:=True:C214
						[QQQCounter:41]Counter:1:=$uniqueToRecover
						SAVE RECORD:C53([QQQCounter:41])
					Else 
						DELAY PROCESS:C323(Current process:C322; 10)  // tics
					End if 
				Else 
					$endCounterLoop:=True:C214
				End if 
			Until ($endCounterLoop)
		End if 
		
		QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum)  // keep makering records until the que is filled
		$counterCount:=Records in selection:C76([CounterPending:135])
		$uniqueToRecover:=$uniqueToRecover+1  // increment hire to step over any block of used numbers
	Until ($counterCount>=<>viCounterPending)
	//
	
	// Modified by: Bill James (2017-08-29T00:00:00)
	
	// this should not be required after a time, 
	// coerce unique pending value
	QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum)
	$cntPending:=Records in selection:C76([CounterPending:135])
	C_LONGINT:C283($incPending; $rayPending)
	ARRAY LONGINT:C221($aPending; 0)
	ORDER BY:C49([CounterPending:135]; [CounterPending:135]PendingNum:4)
	DISTINCT VALUES:C339([CounterPending:135]PendingNum:4; $aPending)
	If (Size of array:C274($aPending)<$cntPending)
		$rayPending:=Size of array:C274($aPending)
		For ($incPending; 1; $rayPending)
			QUERY:C277([CounterPending:135]; [CounterPending:135]TableNum:3=$tableNum; *)
			QUERY:C277([CounterPending:135];  & [CounterPending:135]PendingNum:4=$aPending{$incPending})
			$cntPending:=Records in selection:C76([CounterPending:135])
			If ($cntPending>1)
				REDUCE SELECTION:C351([CounterPending:135]; $cntPending-1)
				DELETE SELECTION:C66([CounterPending:135])
			End if 
		End for 
	End if 
End if 

READ ONLY:C145([QQQCounter:41])
READ ONLY:C145([CounterPending:135])
