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
			If (Is new record:C668([InventoryStack:29]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[InventoryStack:29])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			[InventoryStack:29]DateEntered:3:=Current date:C33
			[InventoryStack:29]CreatedBy:8:=Current user:C182
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			$doMore:=True:C214
	End case 
	If ($doMore)
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	
	Case of 
		: (Modified:C32([InventoryStack:29]ExtendedCost:17))
			[InventoryStack:29]UnitCost:11:=Round:C94([InventoryStack:29]ExtendedCost:17/[InventoryStack:29]QtyOnHand:9; <>tcDecimalUC)
		: ((Modified:C32([InventoryStack:29]UnitCost:11)) | (Modified:C32([InventoryStack:29]QtyOnHand:9)))
			[InventoryStack:29]ExtendedCost:17:=Round:C94([InventoryStack:29]UnitCost:11*[InventoryStack:29]QtyOnHand:9; <>tcDecimalTt)
	End case 
	booAccept:=(Not:C34(([InventoryStack:29]idUnique:1=0) | ([InventoryStack:29]ItemNum:2="")))
End if 

