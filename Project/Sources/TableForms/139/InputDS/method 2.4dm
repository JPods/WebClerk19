C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
$doMore:=False:C215

iLoRecordNew:=False:C215
iLoRecordChange:=False:C215

If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([Discussion:139]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Discussion:139])
	//
	
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
			iLoRecordNew:=False:C215
			
		: (iLoRecordChange)  //set in iLoProcedure only once
			iLoRecordChange:=False:C215
			
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		
		WAtinymceCall("WebTech"; [Discussion:139]Body:6; "editorDiscussions.html")
		
		
	End if 
	
End if 
vMod:=True:C214  // in case changes are only made in tinymce
booAccept:=True:C214
