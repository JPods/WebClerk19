If (False:C215)
	//Method:
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 

If (aTmp20Str1>1)
	CONFIRM:C162("Set case?")
	If (OK=1)
		TRACE:C157
		C_LONGINT:C283($i; $k; $fieldCnt; $fieldIndex; $fileNum)
		FIRST RECORD:C50(ptCurTable->)
		$fileNum:=Table:C252(ptCurTable)
		$k:=Records in selection:C76(ptCurTable->)
		$fieldCnt:=Size of array:C274(aFieldLns)
		If (($k>0) & ($fieldCnt>0))
			FIRST RECORD:C50(ptCurTable->)
			For ($i; 1; $k)
				For ($fieldIndex; 1; $fieldCnt)
					$theType:=Type:C295(Field:C253($fileNum; theFldNum{aFieldLns{$fieldIndex}})->)
					If (($theType=0) | ($theType=2))
						Case of 
							: (aTmp20Str1=2)
								Txt_CaseSentenc(Field:C253($fileNum; theFldNum{aFieldLns{$fieldIndex}}))
							: (aTmp20Str1=3)
								Txt_CaseUpper(Field:C253($fileNum; theFldNum{aFieldLns{$fieldIndex}}))
							Else 
								Txt_CaseLower(Field:C253($fileNum; theFldNum{aFieldLns{$fieldIndex}}))
						End case 
					End if 
				End for 
				SAVE RECORD:C53(ptCurTable->)
				NEXT RECORD:C51(ptCurTable->)
			End for 
		End if 
	End if 
End if 
aTmp20Str1:=1