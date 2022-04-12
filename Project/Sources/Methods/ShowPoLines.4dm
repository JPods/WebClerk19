//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-06T00:00:00, 15:47:48
// ----------------------------------------------------
// Method: ShowPoLines
// Description
// Modified: 10/06/16
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($fileNum)
$fileNum:=0
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
Case of 
	: ((vHere>1) & (ptCurTable=(->[PO:39])))
		QUERY:C277([POLine:40]; [POLine:40]poNum:1=[PO:39]poNum:5)
		ProcessTableOpen(Table:C252(->[POLine:40]))
	: ((vHere>1) & (ptCurTable=(->[Vendor:38])))
		QUERY:C277([POLine:40]; [POLine:40]vendorID:24=[Vendor:38]vendorID:1)
		ProcessTableOpen(Table:C252(->[POLine:40]))
	: (vHere=0)
		DB_ShowByTableName("POLine")
		$doJoin:=False:C215
	: (vHere=1)
		Case of 
			: (ptCurTable=(->[Vendor:38]))
				RELATE MANY SELECTION:C340([PO:39]vendorID:1)
				RELATE MANY SELECTION:C340([POLine:40]poNum:1)
			: (ptCurTable=(->[PO:39]))
				RELATE MANY SELECTION:C340([POLine:40]poNum:1)
			Else 
				DB_ShowByTableName("POLine")
				$doJoin:=False:C215
		End case 
		$fileNum:=Table:C252(->[POLine:40])*Num:C11(Records in selection:C76([POLine:40])>0)
		If (($fileNum>0) & ($doJoin))
			ProcessTableOpen(Table:C252($fileNum))
		End if 
	Else 
		jAlertMessage(10100)
End case 