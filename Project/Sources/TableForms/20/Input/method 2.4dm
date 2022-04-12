C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([QQQLetter:20]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		$formEvent:=iLoProcedure(->[QQQLetter:20])
	End if 
	//
	C_LONGINT:C283($formEvent)
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		iLoRecordChange:=False:C215
		iLoRecordNew:=False:C215
		<>aTableNames:=Find in array:C230(<>aTableNums; [QQQLetter:20]tableNum:8)
		P_InitPrintCnt
		$w:=Size of array:C274(SRVarNames)+1
		INSERT IN ARRAY:C227(SRVarNames; $w)
		SRVarNames{$w}:="Ltr_FillVar"
		If ([QQQLetter:20]tableNum:8>0)
			ptPrintTable:=Table:C252([QQQLetter:20]tableNum:8)
			Ltr_FillVar(ptPrintTable)
		Else 
			ptPrintTable:=(->[QQQLetter:20])
		End if 
		$fia:=Find in array:C230(<>yURFAUniqID; [QQQLetter:20]FaxAttachment:13)
		If ($fia>0)
			<>yURFAName:=$fia
		Else 
			<>yURFAName:=1  //none
			[QQQLetter:20]FaxAttachment:13:=<>yURFAUniqID{1}  //none
		End if 
		
		// add path corrections
		
		// WATextIntoArea (->WebTech;[Letter]Body;"tiny")
		
		//**WR PICTURE TO AREA (eLetterArea;[Letter]LetterPict)
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 
