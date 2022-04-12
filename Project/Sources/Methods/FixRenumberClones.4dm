//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/25/20, 18:31:50
// ----------------------------------------------------
// Method: FixRenumberClones
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($tableName)


$tableName:=Table name:C256(Table:C252(ptCurTable))
CONFIRM:C162("Renumber Clones to low range: "+$tableName)
If (OK=1)
	C_LONGINT:C283($k; $i; $lastOK; $incSub; $cntSub; $startNum)
	C_BOOLEAN:C305($foundEmpty)
	ARRAY LONGINT:C221($aiRecordNums; 0)
	$lastOK:=101
	Case of 
		: (ptCurTable=(->[Proposal:42]))
			SELECTION TO ARRAY:C260([Proposal:42]; $aiRecordNums)
			$k:=Size of array:C274($aiRecordNums)
			
			$startNum:=0
			For ($i; 1; $k)
				$foundEmpty:=False:C215
				Repeat 
					QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=$lastOK)
					QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Proposal:42]idNumTask:70)
					DELETE SELECTION:C66([QA:70])
					If (Records in selection:C76([Proposal:42])=0)
						QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=$lastOK)
						DELETE SELECTION:C66([ProposalLine:43])
						$foundEmpty:=True:C214
						If ($startNum=0)
							$startNum:=$lastOK
						End if 
					Else 
						$lastOK:=$lastOK+1
					End if 
				Until ($foundEmpty)
				GOTO RECORD:C242([Proposal:42]; $aiRecordNums{$i})
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
				APPLY TO SELECTION:C70([ProposalLine:43]; [ProposalLine:43]proposalNum:1:=$lastOK)
				[Proposal:42]proposalNum:5:=$lastOK
				SAVE RECORD:C53([Proposal:42])
			End for 
			ConsoleMessage("Renumbered Proposals: "+String:C10($k)+" starting: "+String:C10($startNum)+" ending: "+String:C10($lastOK))
		: (ptCurTable=(->[Order:3]))
			SELECTION TO ARRAY:C260([Order:3]; $aiRecordNums)
			$k:=Size of array:C274($aiRecordNums)
			
			$startNum:=0
			For ($i; 1; $k)
				$foundEmpty:=False:C215
				Repeat 
					QUERY:C277([Order:3]; [Order:3]orderNum:2=$lastOK)
					If (Records in selection:C76([Order:3])=0)
						QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=$lastOK)
						DELETE SELECTION:C66([OrderLine:49])
						$foundEmpty:=True:C214
						If ($startNum=0)
							$startNum:=$lastOK
						End if 
					Else 
						$lastOK:=$lastOK+1
					End if 
				Until ($foundEmpty)
				GOTO RECORD:C242([Order:3]; $aiRecordNums{$i})
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
				APPLY TO SELECTION:C70([OrderLine:49]; [OrderLine:49]orderNum:1:=$lastOK)
				[Order:3]orderNum:2:=$lastOK
				SAVE RECORD:C53([Order:3])
			End for 
			ConsoleMessage("Renumbered Orders: "+String:C10($k)+" starting: "+String:C10($startNum)+" ending: "+String:C10($lastOK))
		Else 
			ConsoleMessage("Renumbering is only for Proposals and Orders")
	End case 
End if 

If (False:C215)  // keep this for DataCleanUp
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For (vi1; 1; vi2)
		QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Order:3]idNumTask:85)
		DELETE SELECTION:C66([QA:70])
		NEXT RECORD:C51([Order:3])
	End for 
	UNLOAD RECORD:C212([Order:3])
	
	vi2:=Records in selection:C76([Proposal:42])
	FIRST RECORD:C50([Proposal:42])
	For (vi1; 1; vi2)
		QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Proposal:42]idNumTask:70)
		DELETE SELECTION:C66([QA:70])
		NEXT RECORD:C51([Proposal:42])
	End for 
	UNLOAD RECORD:C212([Proposal:42])
End if 