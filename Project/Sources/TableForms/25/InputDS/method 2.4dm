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
			If (Is new record:C668([Territory:25]))
				Case of 
					: (([Territory:25]territoryid:3="") & (ptCurTable=(->[TaxJurisdiction:14])))
						[Territory:25]territoryid:3:=[TaxJurisdiction:14]taxJurisdiction:1
						[Territory:25]purpose:6:=1
					: (([Territory:25]repID:2="") & (ptCurTable=(->[Rep:8])))
						[Territory:25]repID:2:=[Rep:8]repID:1
					: (([Territory:25]salesNameID:1="") & (ptCurTable=(->[Employee:19])))
						[Territory:25]salesNameID:1:=[Employee:19]nameID:1
				End case 
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Territory:25])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 

