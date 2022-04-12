//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-30T00:00:00, 01:59:53
// ----------------------------------------------------
// Method: CounterRecover
// Description
// Modified: 08/30/17
// 
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($ptTable; $ptKeyField; $ptTable)
If (Count parameters:C259=0)
	$ptTable:=ptCurTable
Else 
	$ptTable:=$1
End if 
If (Is new record:C668($ptTable->))
	C_LONGINT:C283($i; $tableNum)
	C_LONGINT:C283($tableNum; $tableNum; $protectedFieldNum; $uniqueToRecover; $theType)
	C_TEXT:C284($errorMessage)
	C_BOOLEAN:C305($doCounterRecover)
	$doCounterRecover:=True:C214  // only recover counters for the big four
	$tableNum:=Table:C252($ptTable)
	$uniqueToRecover:=-100  // unless positive ignore
	Case of 
		: ($ptTable=(->[Invoice:26]))
			$uniqueToRecover:=[Invoice:26]invoiceNum:2
		: ($ptTable=(->[Order:3]))
			$uniqueToRecover:=[Order:3]orderNum:2
		: ($ptTable=(->[PO:39]))
			$uniqueToRecover:=[PO:39]poNum:5
		: ($ptTable=(->[Project:24]))
			$uniqueToRecover:=[Project:24]projectNum:1
		: ($ptTable=(->[Proposal:42]))
			$uniqueToRecover:=[Proposal:42]proposalNum:5
		: ($ptTable=(->[WorkOrder:66]))
			$uniqueToRecover:=[WorkOrder:66]woNum:29
		Else 
			//If (False)  // no other tables are recaptures
			//$doCounterRecover:=False  // only recover counters for the big four
			//If ($doCounterRecover)  // only recover counters for the big four
			//$protectedFieldNum:=UniqueFieldNum($tableNum)
			//$ptKeyField:=Field($tableNum; $protectedFieldNum)
			//// could write this to recover any, but right now just the big four
			//
			//$theType:=Type($ptKeyField->)
			//If ($theType=Is longint)
			////$uniqueToRecover:=$ptKeyField->
			//End if 
			//End if 
			//End if 
	End case 
	
	If ($uniqueToRecover>0)
		C_LONGINT:C283($childProcess)
		C_TEXT:C284($processName)
		$processName:="Counter_"+Table name:C256($ptTable)
		$childProcess:=Execute on server:C373("CounterConfirmUnique"; <>tcPrsMemory; $processName; $tableNum; $uniqueToRecover)
	End if 
End if 