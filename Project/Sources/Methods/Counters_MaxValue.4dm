//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-12T00:00:00, 22:35:13
// ----------------------------------------------------
// Method: Counters_MaxValue
// Description
// Modified: 04/12/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// UniqueForce should be used for most tables
// This should be used for the key tables where sequences numbers cannot be used because of relationships based on uniqueIDs
// aaaqqqzzz


// to do as a script:  SequenceNumberReset

If (False:C215)  // transfer the existing counters, then let the walkover feature correct for defects
	
	C_LONGINT:C283($testNum; $maxNum; $i)
	C_POINTER:C301($1)
	C_LONGINT:C283($maxValue; $theType)
	C_LONGINT:C283($tableNum; $protectedFieldNum)
	C_TEXT:C284($tableName; $moreString)
	C_POINTER:C301($ptTable; $ptField)
	
	C_BOOLEAN:C305($doCounterPending)
	$doCounterPending:=False:C215
	C_LONGINT:C283(<>vCounterBuffer)
	If (<>vCounterBuffer=0)
		<>vCounterBuffer:=10
	End if 
	If (Count parameters:C259=0)
		C_LONGINT:C283($countTables; $incrementTables; <>vCounterBuffer; $childProcess)
		$countTables:=Get last table number:C254
		For ($incrementTables; 1; $countTables)
			Counters_MaxValue(Table:C252($incrementTables))
		End for 
	Else 
		$tableNum:=Table:C252($1)
		$ptTable:=Table:C252($tableNum)
		$tableName:=Table name:C256($tableNum)
		If (($tableName="Customer") | ($tableName="Order") | ($tableName="Item") | ($tableName="Invoice") | ($tableName="Proposal"))
			
		End if 
		Case of 
			: (($tableName="Counter@") | ($tableName="Default"))  // automatically unique by 4D
				// Isolated table. take no action
			: (($tableName="zz@") | ($tableName="(@"))  // Remove all records
				// ### bj ### 20190924_2327
				// delete these records by intent, not during conversion
				// ALL RECORDS($ptTable->)
				// DELETE SELECTION($ptTable->)
			Else 
				READ WRITE:C146([Counter:41])
				QUERY:C277([Counter:41]; [Counter:41]tableNum:4=$tableNum)
				If (Locked:C147([Counter:41]))
					ConsoleLog($tableName+": LOCKED: Setting Counter to Max")
				Else 
					ConsoleLog($tableName+": Setting Counter to Max")
					$protectedFieldNum:=STR_GetUniqueFieldNum($tableName)
					$ptField:=Field:C253($tableNum; $protectedFieldNum)
					$theType:=Type:C295($ptField->)
					READ WRITE:C146($ptTable->)
					ALL RECORDS:C47($ptTable->)
					ARRAY TEXT:C222($atextUnique; 0)
					C_LONGINT:C283($incUnique; $cntUnique; $thevalue; $maxValue)
					Case of 
						: ($theType=Is alpha field:K8:1)
							SELECTION TO ARRAY:C260($ptField->; $atextUnique)  // put the Primary field into an array 
							$cntUnique:=Size of array:C274($atextUnique)
							For ($incUnique; 1; $cntUnique)
								$thevalue:=Num:C11($atextUnique{$incUnique})  // loop for the largest number value, ignoring text
								If ($thevalue>$maxValue)
									$maxValue:=$thevalue
								End if 
							End for 
						: ($theType=Is longint:K8:6)
							ORDER BY:C49($ptTable->; $ptField->; <)
							FIRST RECORD:C50($ptTable->)
							If ($maxValue<$ptField->)
								$maxValue:=$ptField->
							End if 
					End case 
					
					If ($maxValue<100)
						$maxValue:=100
					End if 
					
					[Counter:41]counter:1:=$maxValue+1  // always at least 30
					SAVE RECORD:C53([Counter:41])
					REDUCE SELECTION:C351($1->; 0)
					
					C_LONGINT:C283($sequenceNum)
					$sequenceNum:=Sequence number:C244($ptTable->)
					If ($sequenceNum<$maxValue)
						SET DATABASE PARAMETER:C642($ptTable->; Table sequence number:K37:31; $maxValue+10)
						$sequenceNum:=$maxValue+10
					End if 
					$maxValue:=Records in table:C83($ptTable->)
					If ($sequenceNum<$maxValue)
						SET DATABASE PARAMETER:C642($ptTable->; Table sequence number:K37:31; $maxValue+10)
					End if 
					
					// Clear all the available Counter Pending Records
					READ WRITE:C146([CounterPending:135])
					QUERY:C277([CounterPending:135]; [CounterPending:135]tableNum:3=$tableNum)
					DELETE SELECTION:C66([CounterPending:135])
					
					// Need to check this
					//  qqqq
					
				End if 
				REDUCE SELECTION:C351([Counter:41]; 0)
				
		End case 
	End if 
End if 