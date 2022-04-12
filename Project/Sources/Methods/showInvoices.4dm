//%attributes = {"publishedWeb":true}
If (vHere>0)
	C_BOOLEAN:C305($doJoin)
	$doJoin:=True:C214
	Case of 
		: ((ptCurTable=(->[Customer:2])) & ((vHere=1) | (vHere=2)))
			RELATE MANY SELECTION:C340([Invoice:26]customerID:3)
		: ((ptCurTable=(->[Order:3])) & ((vHere=1) | (vHere=2)))
			RELATE MANY SELECTION:C340([Invoice:26]orderNum:1)
		: ((ptCurTable=(->[Payment:28])) & ((vHere=1) | (vHere=2)))
			RELATE ONE SELECTION:C349([Payment:28]; [Invoice:26])
		: ((ptCurTable=(->[InvoiceLine:54])) & ((vHere=1) | (vHere=2)))
			RELATE ONE SELECTION:C349([InvoiceLine:54]; [Invoice:26])
		Else 
			DB_ShowByTableName("Invoice")
			$doJoin:=False:C215
	End case 
	If ($doJoin)
		If (Records in selection:C76([Invoice:26])>0)
			ProcessTableOpen(->[Invoice:26])
		End if 
	End if 
Else 
	DB_ShowByTableName("Invoice")
End if 