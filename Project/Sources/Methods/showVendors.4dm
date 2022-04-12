//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fileNum)
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
$fileNum:=0
Case of 
	: (vHere=0)
		DB_ShowByTableName("Vendor")
		$doJoin:=False:C215
	: (vHere=1)
		Case of 
			: (ptCurTable=(->[POLine:40]))
				RELATE ONE SELECTION:C349([POLine:40]; [Vendor:38])
			: (ptCurTable=(->[PO:39]))
				RELATE ONE SELECTION:C349([PO:39]; [Vendor:38])
			Else 
				$doJoin:=False:C215
				DB_ShowByTableName("Vendor")
		End case 
		$fileNum:=Table:C252(->[Vendor:38])*Num:C11(Records in selection:C76([Vendor:38])>0)
		If (($fileNum>0) & ($doJoin))
			ProcessTableOpen(Table:C252($fileNum))
		End if 
	Else 
		jAlertMessage(10100)
End case 