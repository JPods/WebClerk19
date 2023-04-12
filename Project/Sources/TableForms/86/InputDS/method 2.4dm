// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/01/13, 23:53:30
// ----------------------------------------------------
// Method: Form Method: Input
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
	ARRAY TEXT:C222(iLoaText1; 0)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([DefaultSetup:86]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		
		ARRAY TEXT:C222(iLoaText1; 8)
		iLoaText1{1}:="Types"
		iLoaText1{2}:="Is Boolean"
		iLoaText1{3}:="Is Date"
		iLoaText1{4}:="Is Integer"
		iLoaText1{5}:="Is LongInt"
		iLoaText1{6}:="Is Real"
		iLoaText1{7}:="Is String Var"
		iLoaText1{8}:="Is Time"
		//[DefaultSetup]Type
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[DefaultSetup:86])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		iloLongInt1:=BLOB size:C605([DefaultSetup:86]LayoutDataBlob:6)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

