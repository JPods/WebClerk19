//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/16/08, 14:11:54
// ----------------------------------------------------
// Method: OpenPayments
// Description
// 
//
// Parameters
// ----------------------------------------------------
Case of 
	: (vHere=0)
		QUERY:C277([Payment:28]; [Payment:28]amountAvailable:19#0)
		ProcessTableOpen(Table:C252(->[Payment:28])*-1)
	: (vHere=1)
		$doRelate:=False:C215
		Case of 
			: (ptCurTable=(->[Customer:2]))
				$ptPayField:=(->[Payment:28]customerID:4)
				$ptFld:=(->[Customer:2]customerID:1)
				$doRelate:=True:C214
			: (ptCurTable=(->[Order:3]))
				$ptPayField:=(->[Payment:28]orderNum:2)
				$ptFld:=(->[Order:3]orderNum:2)
				$doRelate:=True:C214
			: (ptCurTable=(->[Invoice:26]))
				$ptPayField:=(->[Payment:28]invoiceNum:3)
				$ptFld:=(->[Invoice:26]invoiceNum:2)
				$doRelate:=True:C214
		End case 
		If ($doRelate)
			CREATE EMPTY SET:C140([Payment:28]; "<>curSelSet")
			$k:=Records in selection:C76(ptCurTable->)
			FIRST RECORD:C50(ptCurTable->)
			For ($i; 1; $k)
				QUERY:C277([Payment:28]; $ptPayField->=$ptFld->)
				CREATE SET:C116([Payment:28]; "Current")
				UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
				CLEAR SET:C117("Current")
				NEXT RECORD:C51(ptCurTable->)
			End for 
			USE SET:C118("<>curSelSet")
			CLEAR SET:C117("<>curSelSet")
		Else 
			QUERY:C277([Payment:28]; [Payment:28]amountAvailable:19#0)
		End if 
		ProcessTableOpen(Table:C252(->[Payment:28])*-1)
	Else 
		$doRelate:=False:C215
		Case of 
			: (ptCurTable=(->[Customer:2]))
				$ptPayField:=(->[Payment:28]customerID:4)
				$ptFld:=(->[Customer:2]customerID:1)
				$doRelate:=True:C214
			: (ptCurTable=(->[Order:3]))
				$ptPayField:=(->[Payment:28]orderNum:2)
				$ptFld:=(->[Order:3]orderNum:2)
				$doRelate:=True:C214
			: (ptCurTable=(->[Invoice:26]))
				$ptPayField:=(->[Payment:28]invoiceNum:3)
				$ptFld:=(->[Invoice:26]invoiceNum:2)
				$doRelate:=True:C214
		End case 
		If ($doRelate)
			QUERY:C277([Payment:28]; $ptPayField->=$ptFld->)
		End if 
		ProcessTableOpen(Table:C252(->[Payment:28])*-1)
		
End case 


