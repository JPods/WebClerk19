//%attributes = {"publishedWeb":true}
//Procedure: TR_PrintPoint
C_TEXT:C284($WandID)
C_TEXT:C284(vLF)
C_TEXT:C284($StrIn; $ScanStr)
C_LONGINT:C283($index; $myOK; $i)
C_BOOLEAN:C305($ItemFlag; $doEnd)
ARRAY REAL:C219($aQty; 3)
ARRAY REAL:C219($aPrice; 3)
ARRAY TEXT:C222($aItemDesc; 3)
CLOSE DOCUMENT:C267(myDoc)
myDoc:=Open document:C264(myDocName)
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")  //PrintPoint
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
pPartNum:=$StrIn
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
$aItemDesc{1}:=$StrIn+" of "+pPartNum
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
$aItemDesc{2}:=$StrIn+" of "+pPartNum
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
$aItemDesc{3}:=$StrIn+" of "+pPartNum
//
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
$aPrice{1}:=Num:C11($StrIn)
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
$aPrice{2}:=Num:C11($StrIn)
RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
$aPrice{3}:=Num:C11($StrIn)
QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
C_LONGINT:C283($i)
For ($i; 1; 3)
	listItemsFill(ptCurTable; True:C214)
	pQtyOrd:=1
	pUnitPrice:=$aPrice{$i}
	pDescript:=$aItemDesc{$i}
	Case of 
		: (ptCurTable=(->[Order:3]))
			aOItemNum{aoLineAction}:=pPartNum
			aOQtyOrder{aoLineAction}:=1
			aOUnitMeas{aoLineAction}:=""
			aOTaxable{aoLineAction}:=""
			aODescpt{aoLineAction}:=pDescript
			aOUnitPrice{aoLineAction}:=pUnitPrice
			aODiscnt{aoLineAction}:=pDiscnt
			OrdLnExtend(aoLineAction)
		: (ptCurTable=(->[Invoice:26]))
			//IvcLnAdd ((Size of array(aiLineAction)+1);1;$2)
		: (ptCurTable=(->[PO:39]))
			//POLnAdd ((Size of array(aPOLineAction)+1);1;$2)
		: (ptCurTable=(->[Proposal:42]))
			aPItemNum{aPLineAction}:=pPartNum
			aPQtyOrder{aPLineAction}:=1
			aPUnitMeas{aPLineAction}:=""
			aPTaxable{aPLineAction}:=[Item:4]taxID:17
			aPDescpt{aPLineAction}:=pDescript
			aPUnitPrice{aPLineAction}:=pUnitPrice
			aPDiscnt{aPLineAction}:=pDiscnt
			PpLnExtend(aPLineAction)
			pUse:=1
	End case 
	vLineMod:=True:C214
End for 
vLineMod:=True:C214