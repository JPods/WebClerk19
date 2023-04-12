// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/09/12, 13:45:21
// ----------------------------------------------------
// Method: Form Method: [GenericChild2]iGenericChild2_9
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
			If (Is new record:C668([GenericChild2:91]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[GenericChild2:91])
	
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			
			//### jwm ### 20120809_0002 begin
			If ([GenericChild2:91]tableNum:42=0)
				LabelsFill(Table:C252(->[GenericChild2:91]); [GenericChild2:91]TemplateName:44)
			Else 
				LabelsFill([GenericChild2:91]tableNum:42; [GenericChild2:91]TemplateName:44)
			End if 
			//### jwm ### 20120809_0002 end
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			//### jwm ### 20120809_0002 begin
			If ([GenericChild2:91]tableNum:42=0)
				LabelsFill(Table:C252(->[GenericChild2:91]); [GenericChild2:91]TemplateName:44)
			Else 
				LabelsFill([GenericChild2:91]tableNum:42; [GenericChild2:91]TemplateName:44)
			End if 
			//### jwm ### 20120809_0002 end
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	booAccept:=([GenericChild2:91]Name:3#"")
End if 
