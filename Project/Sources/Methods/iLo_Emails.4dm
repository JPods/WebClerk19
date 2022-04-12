//%attributes = {}
C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious)
C_LONGINT:C283($formEvent; viDoTinymce)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([QQQMessage:137]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[QQQMessage:137])
	//
	Case of 
		: (iLoRecordChange)
			iLoRecordChange:=False:C215
			
			// ### jwm ### 20181017_1645
			Case of 
				: ([QQQMessage:137]Body:12#"")
					ddEmail:=1
					TabControl:=1
					FORM GOTO PAGE:C247(TabControl)
					WATextIntoArea(->myWebArea; [QQQMessage:137]Body:12; "view")
					
				: ([QQQMessage:137]BodyText:37#"")
					TabControl:=2
					FORM GOTO PAGE:C247(TabControl)
					//WATextIntoArea (->myWebArea;[Message]BodyText;"view")
				Else 
					ddEmail:=1
					TabControl:=1
					FORM GOTO PAGE:C247(TabControl)
					WATextIntoArea(->myWebArea; [QQQMessage:137]Body:12; "view")
			End case 
			
			
			If (False:C215)
				Case of 
					: ([QQQMessage:137]Body:12#"")
						WA SET PAGE CONTENT:C1037(myWebArea; [QQQMessage:137]Body:12; "file:///")
					: ([QQQMessage:137]BodyText:37#"")
						WA SET PAGE CONTENT:C1037(myWebArea; [QQQMessage:137]BodyText:37; "file:///")
				End case 
				// do this on loading the form (viDoTinymce=1)
				C_TEXT:C284($wa_htmlEditor_path_t)
				$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
				$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
				//WA OPEN URL(myWebArea;"file:///"+$wa_htmlEditor_path_t)
				
				//WA OPEN URL(myWebArea;[Message]Body)
			End if 
			
		: (iLoRecordNew)  //set in iLoProcedure only once
			
			Before_New(ptCurTable)  //last thing to do
		: (iLoRecordChange)  //set in iLoProcedure only once
			Before_New(ptCurTable)  //last thing to do
	End case 
	//
End if 