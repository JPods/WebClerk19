//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/16/08, 13:52:13
// ----------------------------------------------------
// Method: ShowPayments
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($fileNum)
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
$fileNum:=0
//TRACE
Case of 
	: ((ptCurTable=(->[Customer:2])) & (vHere>1))
		QUERY:C277([Payment:28]; [Payment:28]customerID:4=[Customer:2]customerID:1)
	: ((ptCurTable=(->[Invoice:26])) & (vHere>1))
		QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
	: ((ptCurTable=(->[Order:3])) & (vHere>1))
		QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
	: ((ptCurTable=(->[Customer:2])) & (vHere=1))
		RELATE MANY SELECTION:C340([Payment:28]customerID:4)
	: ((ptCurTable=(->[Invoice:26])) & (vHere=1))
		RELATE MANY SELECTION:C340([Payment:28]invoiceNum:3)
	: ((ptCurTable=(->[Order:3])) & (vHere=1))
		RELATE MANY SELECTION:C340([Payment:28]orderNum:2)
	Else 
		DB_ShowByTableName("Payment")
		$doJoin:=False:C215
		$fileNum:=Table:C252(->[Payment:28])*Num:C11(Records in selection:C76([Payment:28])>0)
		If (($fileNum>0) & ($doJoin))
			ProcessTableOpen(Table:C252($fileNum))
		End if 
End case 
If ($doJoin)
	If (vHere<2)
		UNLOAD RECORD:C212(ptCurTable->)
	End if 
	ProcessTableOpen(Table:C252(->[Payment:28])*-1)
End if 