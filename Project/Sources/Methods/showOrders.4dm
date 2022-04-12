//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: showOrders
	//Date: 03/11/03
	//Who: Bill
	//Description: New Process if coming from related
End if 
C_LONGINT:C283($fileNum)
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
$fileNum:=0
//TRACE
Case of 
	: ((ptCurTable=(->[Customer:2])) & ((vHere=1) | (vHere=2)))
		RELATE MANY SELECTION:C340([Order:3]customerID:1)
	: ((ptCurTable=(->[Invoice:26])) & ((vHere=1) | (vHere=2)))
		RELATE ONE SELECTION:C349([Invoice:26]; [Order:3])
	: ((ptCurTable=(->[OrderLine:49])) & ((vHere=1) | (vHere=2)))
		RELATE ONE SELECTION:C349([OrderLine:49]; [Order:3])
	Else 
		DB_ShowByTableName("Order")
		$doJoin:=False:C215
		$fileNum:=Table:C252(->[Order:3])*Num:C11(Records in selection:C76([Order:3])>0)
		If (($fileNum>0) & ($doJoin))
			ProcessTableOpen(Table:C252($fileNum))
		End if 
End case 
If ($doJoin)
	If (vHere<2)
		UNLOAD RECORD:C212(ptCurTable->)
	End if 
	curTableNum:=Table:C252(->[Order:3])
	ProcessTableOpen
End if 