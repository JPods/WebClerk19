//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $doThis)
$doThis:=0
If (Count parameters:C259=1)
	$doThis:=$1
Else 
	$doThis:=Num:C11(vHere>0)
End if 
If ($doThis>0)
	Case of 
		: (ptCurTable=(->[QQQCustomer:2]))
			DISABLE MENU ITEM:C150(3; 14)
			DISABLE MENU ITEM:C150(3; 15)
		: (ptCurTable=(->[Invoice:26]))
			
			DISABLE MENU ITEM:C150(5; 7)
			DISABLE MENU ITEM:C150(5; 8)
			DISABLE MENU ITEM:C150(5; 10)
			DISABLE MENU ITEM:C150(5; 11)
			DISABLE MENU ITEM:C150(5; 12)
			//     ShipAddrRay_Set(0)
			IvcLnFillRays(0)
			ARRAY LONGINT:C221(aInvoices; 0)
			ARRAY TEXT:C222(aInvTerms; 0)
			ARRAY REAL:C219(aAmtPaid; 0)
			ARRAY REAL:C219(aInvTotals; 0)
			ARRAY REAL:C219(aInvDiscountAmounts; 0)
		: (ptCurTable=(->[Order:3]))
			//      ShipAddrRay_Set(0) 
			DISABLE MENU ITEM:C150(4; 10)
			DISABLE MENU ITEM:C150(4; 11)
			DISABLE MENU ITEM:C150(4; 12)
			OrdLnRays(0)
		: (ptCurTable=(->[PO:39]))
			//      jClearFile ([POLine])    //Needed when POLines is Selection to Array
			PoLnFillRays(0)
		: (ptCurTable=(->[Proposal:42]))
			DISABLE MENU ITEM:C150(4; 18)
			DISABLE MENU ITEM:C150(4; 19)
			//      ShipAddrRay_Set(0) 
			REDUCE SELECTION:C351([ProposalLine:43]; 0)
			PpLnFillRays(0)
		: (ptCurTable=(->[Item:4]))
			DISABLE MENU ITEM:C150(3; 4)
			//     clrItemArray 
			Bom_FillArray(0)
			ARRAY TEXT:C222(aItemNum; 0)
			//    : (ptCurFile=([Service]))
			//      srCustomer:=""
	End case 
End if 