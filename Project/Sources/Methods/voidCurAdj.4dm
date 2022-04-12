//%attributes = {"publishedWeb":true}
LOAD RECORD:C52([InventoryStack:29])
If (Not:C34(Locked:C147([InventoryStack:29])))
	//READ WRITE([POLine])
	//SEARCH([POLine];[POLine]POLineKey=[InvStack]PONum;*)
	//SEARCH([POLine];[POLine]LineNum=[InvStack]LineNo)
	//If (Records in selection([POLine])=1)
	//LOAD RECORD([POLine])
	//If (Not(Locked))
	//[POLine]QtyReceived:=[InvStack]QtyChange-[InvStack]QtyChange
	//[POLine]QtyBackLogged:=[POLine]QtyBackLogged+[InvStack]QtyChange
	//InventChngAdj ([InvStack];[InvStack]ItemNum;[InvStacks
	//]QtyChange;[InvStack]ChangeReason;"Void")
	//[InvStack]Note:=[InvStack]Note+vCR+vCR+"*///////////  VOID  //////
	//////////*"+vCR+String([InvStack]QtyAvailable)+" available at void."
	//[InvStack]ChangeReason:="Void"
	//[InvStack]QtyAvailable:=0
	//[InvStack]CurrentValue:=0
	//[InvStack]Approval:=Current user
	//SAVE RECORD([POLine])
	//UNLOAD RECORD([POLine])
	//SAVE RECORD([InvStack])
	//UNLOAD RECORD([InvStack])
	//Else 
	//ALERT("Record is locked by another.")
	//End if 
	//End if 
	DELETE RECORD:C58([InventoryStack:29])
Else 
	ALERT:C41("Record is locked by another.")
End if 