//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 16:08:57
// ----------------------------------------------------
// Method: GLAccountsiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (UserInPassWordGroup("Archive"))
			If (vHere>1)  //coming from another table's input layout
				If (Is new record:C668([QQQGLAccount:53]))
					$ptLastTable:=ptCurTable
					$fillFromPrevious:=True:C214
				End if 
			End if 
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[QQQGLAccount:53])
		//
		$doMore:=False:C215
		Case of 
			: (iLoRecordNew)  //set in iLoProcedure only once
				
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once
				
				$doMore:=True:C214
		End case 
		If ($doMore)
			C_LONGINT:C283($w)
			$w:=Find in array:C230(<>aTableNums; [QQQGLAccount:53]FileRefNum:2)
			If ($w=-1)
				[QQQGLAccount:53]FileRefNum:2:=4
				$w:=Find in array:C230(<>aTableNums; [QQQGLAccount:53]FileRefNum:2)
			End if 
			<>aTableNames:=$w
			Before_New(ptCurTable)  //last thing to do
		End if 
		booAccept:=([QQQGLAccount:53]Account:1#"")
	End if 
End if 
