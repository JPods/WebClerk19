//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fileNum)
C_LONGINT:C283(vHere)
$fileNum:=0
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
Case of 
	: (vHere=0)
		DB_ShowByTableName("PO")
		$doJoin:=False:C215
	: (vHere=1)
		Case of 
			: (ptCurTable=(->[Vendor:38]))
				RELATE MANY SELECTION:C340([PO:39]vendorID:1)
			: (ptCurTable=(->[POLine:40]))
				RELATE ONE SELECTION:C349([POLine:40]; [PO:39])
			Else 
				DB_ShowByTableName("PO")
				$doJoin:=False:C215
		End case 
		$fileNum:=Table:C252(->[PO:39])*Num:C11(Records in selection:C76([PO:39])>0)
		If (($fileNum>0) & ($doJoin))
			ProcessTableOpen(Table:C252($fileNum))
		End if 
	Else 
		jAlertMessage(10100)
End case 