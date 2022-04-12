//%attributes = {"publishedWeb":true}
If (booAccept=True:C214)
	If (Is new record:C668([Customer:2]))
		TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
		//Data_ArchiveOld(process_o.oldCustomer)
		Data_ArchiveOld
		//acceptFilePt ($unLoad;->[Customer];->[Contact];->[Service];->[ReferencesTable];->[CallReport])
		//acceptFilePt ($unLoad;->[OrderLine];->[Order];->[Invoice];->[Proposal];->[InvoiceLine])
	End if 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	<>aLastRecNum{2}:=Record number:C243([Customer:2])
	If ((<>tcMONEYCHAR#strCurrency) & (<>tcMONEYCHAR#"") & (strCurrency#"") & ([Proposal:42]exchangeRate:54#0))
		vMod:=True:C214
		Exch_FillRays
	End if 
	If ((Modified record:C314([Proposal:42])) | (vMod) | (vLineMod))
		
		vMod:=calcProposal(True:C214)
		If ((<>tcNeedDelay>-1) & ([Proposal:42]dateNeeded:4=!00-00-00!))
			[Proposal:42]dateNeeded:4:=Current date:C33+<>tcNeedDelay
		End if 
		If ([Proposal:42]dateExpected:42=!00-00-00!)
			[Proposal:42]dateExpected:42:=[Proposal:42]dateNeeded:4
		End if 
		[Proposal:42]lineCount:48:=Size of array:C274(aPLineAction)
		SAVE RECORD:C53([Proposal:42])
		vrOldValue:=[Proposal:42]amount:26
		newProp:=False:C215
		PpLnFillRec
	End if 
	vMod:=False:C215
	// Modified by: William James (2014-02-12T00:00:00 Subrecord eliminated)
	TransactionValidate
End if 