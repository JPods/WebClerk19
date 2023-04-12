C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
$doMore:=False:C215
Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([TechNote:58]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		
		If ((<>vtShareName#"") & (<>jitHelpServer=""))  // retest the connection
			PathSetServer
		End if 
		If (Test path name:C476(<>jitHelpServer)=0)
			<>jitHelpFolder:=<>jitHelpServer
		Else 
			<>jitHelpFolder:=<>jitHelpLocal
		End if 
End case 


C_LONGINT:C283($formEvent)
$formEvent:=iLoProcedure(->[TechNote:58])


Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		[TechNote:58]datePublished:5:=Current date:C33
		
		
	: ((iLoRecordChange) | (changeRecord#0))  //set in iLoProcedure only once, existing record
		changeRecord:=0
		$doMore:=True:C214
		
		vtDraftPath:=""
End case 
If ($doMore)  //action for the form regardless of new or existing record
	C_TEXT:C284($myfolder)
	C_LONGINT:C283($p)
	
	C_TEXT:C284(vtTNPathURL)
	If (Is macOS:C1572)
		C_LONGINT:C283($foundFold)
		$foundFold:=Position:C15(":"; vtTNPathSystem)
		vtTNPathURL:=Substring:C12(vtTNPathSystem; $foundFold+1)
	Else 
		///  FIX THIS WHAT is a PC 
	End if 
	$doMore:=True:C214
	vtDraftPath:=""
	viWidth:=504
	iLoText3:="imageName.png"
	
	// redundant to iLo procedure for Web Area
	
	
	vtDraftPath:=""
	C_BOOLEAN:C305($doInternal)
	
	TNToWebAreaBody
	
	
	
	// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
	// Build and show related
	var $doc_o; $discuss_o : Object
	$doc_o:=ds:C1482.Document.query("idTechNote = :1"; process_o.cur.id)
	$discuss_o:=ds:C1482.Discussion.query("idForeign = :1 & tableName = :2"; process_o.cur.id; process_o.dataClassName)
	$doInternal:=True:C214
	
	C_LONGINT:C283($curStyle)
	
	
	$doChange:=(UserInPassWordGroup("UnlockRecord"))
	If ($doChange)
		OBJECT SET ENTERABLE:C238([TechNote:58]publish:11; False:C215)
	End if 
	
	<>aTableNames:=Find in array:C230(<>aTableNums; [TechNote:58]tableNum:12)
	MESSAGES ON:C181
	b1:=0  //turn off hyper Text    
	<>aTableNames:=Find in array:C230(<>aTableNums; [TechNote:58]tableNum:12)
	Before_New(ptCurTable)  //last thing to do
End if 
//every cycle
C_TEXT:C284(vtDraftPath)
C_BOOLEAN:C305($activeText)
$activeText:=(vtDraftPath#"")
OBJECT SET ENABLED:C1123(bSaveText; $activeText)
booAccept:=(([TechNote:58]idNum:1#0) & ([TechNote:58]name:2#""))
vMod:=True:C214  // in case changes are only made in tinymce
