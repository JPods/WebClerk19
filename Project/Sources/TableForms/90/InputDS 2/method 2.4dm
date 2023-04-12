// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/10/12, 17:05:14
// ----------------------------------------------------
// Method: Form Method: [GenericChild1]iGenericChild1_9
// Description
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
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([GenericChild1:90]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[GenericChild1:90])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			
			//### jwm ### 20130204_0954 begin
			If ([GenericChild1:90]tableNum:55=0)
				LabelsFill(Table:C252(->[GenericChild1:90]); [GenericChild1:90]TemplateName:57)
			Else 
				LabelsFill([GenericChild1:90]tableNum:55; [GenericChild1:90]TemplateName:57)
			End if 
			//### jwm ### 20130204_0954 end
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			//### jwm ### 20120809_0002 begin
			If ([GenericChild1:90]tableNum:55=0)
				LabelsFill(Table:C252(->[GenericChild1:90]); [GenericChild1:90]TemplateName:57)
			Else 
				LabelsFill([GenericChild1:90]tableNum:55; [GenericChild1:90]TemplateName:57)
			End if 
			//### jwm ### 20120809_0002 end
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	booAccept:=([GenericChild1:90]Name:3#"")
End if 

