// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/25/12, 15:29:34
// ----------------------------------------------------
// Method: Form Method: [ItemSpec]diaSpecPict
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
			If (Is new record:C668([ItemSpec:31]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		//### jwm ### 20120125_1505 populate labels On Load
		READ ONLY:C145([Item:4])
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemSpec:31]ItemNum:1)
		LabelsFill(Table:C252(->[Item:4]); [Item:4]templateName:120)
		vPartDesc:=[Item:4]description:7  //### jwm ### 20120127_1346
		UNLOAD RECORD:C212([Item:4])
		READ WRITE:C146([Item:4])
		//BUTTON TEXT(Text5;" TEST THIS ")
		//### jwm ### 20120125_1505 end
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[ItemSpec:31])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		If ([ItemSpec:31]ImagePath:29#"")
			IE_GetPict([ItemSpec:31]ImagePath:29; ->vItemPict)
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 


