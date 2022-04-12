//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
Case of 
	: (vHere=0)
		DB_ShowByTableName("POReceipt")
		$doJoin:=False:C215
	: (vHere=1)
		Case of 
			: (ptCurTable=(->[InventoryStack:29]))
				RELATE ONE SELECTION:C349([InventoryStack:29]; [POReceipt:95])
			Else 
				DB_ShowByTableName("POReceipt")
				$doJoin:=False:C215
		End case 
		If ($doJoin)
			If (Records in selection:C76([POReceipt:95])>0)
				ProcessTableOpen(->[POReceipt:95])
			End if 
		End if 
	Else 
		jAlertMessage(10100)
End case 