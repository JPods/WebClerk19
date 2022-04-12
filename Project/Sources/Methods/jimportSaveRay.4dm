//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/08/11, 12:20:22
// ----------------------------------------------------
// Method: jimportSaveRay
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Modified by: williamjames (110408)

C_LONGINT:C283($incFld; $Match; $p)
C_PICTURE:C286($thePict)
C_BLOB:C604($loadBlob)
//C_POINTER($1)
C_TEXT:C284($thePrimary)
C_LONGINT:C283($doRecord)
C_TEXT:C284(scriptBegin; scriptRecord)
C_LONGINT:C283(vSetPublish; vMakeKeyWords; vMakeItemNum; $error)

$doRecord:=1

// Method: [Control].importGeneral.Variable22
If (scriptBegin#"")  //  ImportScriptLoad ("ImportScript";vtallyMastersName)  
	myOK:=1
	ExecuteText(0; scriptBegin)
	$doRecord:=myOK
End if 

If ($doRecord=1)
	For ($incFld; 1; Size of array:C274(aImpFields))
		
		
		Case of 
			: ($Match=-2)
				//
			: ((aMatchType{$incFld}="A") | (aMatchType{$incFld}="T"))
				Field:C253(curTableNum; aMatchNum{$incFld})->:=aImpFields{$incFld}
			: ((aMatchType{$incFld}="R") | (aMatchType{$incFld}="I"))
				Field:C253(curTableNum; aMatchNum{$incFld})->:=Num:C11(aImpFields{$incFld})
			: (aMatchType{$incFld}="L")
				DT_ParseImport(Field:C253(curTableNum; aMatchNum{$incFld}); aImpFields{$incFld})
			: (aMatchType{$incFld}="H")
				Field:C253(curTableNum; aMatchNum{$incFld})->:=Time:C179(aImpFields{$incFld})
			: (aMatchType{$incFld}="D")
				Field:C253(curTableNum; aMatchNum{$incFld})->:=Date_GoFigure(aImpFields{$incFld})
			: (aMatchType{$incFld}="B")
				Field:C253(curTableNum; aMatchNum{$incFld})->:=((aImpFields{$incFld}="1") | (aImpFields{$incFld}="true") | (aImpFields{$incFld}="Yes") | (aImpFields{$incFld}="Y"))
			: (aMatchType{$incFld}="P")
				If (HFS_Exists(aImpFields{$incFld})=1)
					DOCUMENT TO BLOB:C525(aImpFields{$incFld}; $loadBlob)
					BLOB TO PICTURE:C682($loadBlob; $thePict)
					If ($err=0)
						Field:C253(curTableNum; aMatchNum{$incFld})->:=$thePict
					End if 
				End if 
		End case 
	End for 
	If (curTableNum=Table:C252(->[Item:4]))
		If (vSetPublish>0)
			[Item:4]publish:60:=vSetPublish
		End if 
		If (vMakeKeyWords>0)
			KeyWordsMake(->[Item:4])
		End if 
	End if 
	If (scriptRecord#"")
		myOK:=1  //  set in script to 
		ExecuteText(0; scriptRecord)
		$doRecord:=myOK
	End if 
	If (STR_CounterNewSkip(Table name:C256(curTableNum)))
		// uniqueID is automatic
	Else 
		C_POINTER:C301($ptField)
		C_TEXT:C284($vtValue)
		$ptField:=STR_GetUniqueFieldPointer(Table name:C256(curTableNum))
		$vtValue:=STR_GetProtectString(Table name:C256(curTableNum))
		If ($vtValue="")
			$ptField->:=CounterNew(Table:C252(curTableNum))
		End if 
	End if 
	// ### bj ### 20210213_1910  Test this
	SAVE RECORD:C53(Table:C252(curTableNum)->)
End if 
myOK:=0