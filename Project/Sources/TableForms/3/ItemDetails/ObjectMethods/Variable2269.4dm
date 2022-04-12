// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:43:44
// ----------------------------------------------------
// Method: Object Method: <>aTypeSale
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($ordTypeSale)
If (ptCurTable=(->[Order:3]))
	$ordTypeSale:=[Order:3]typeSale:22
	pPricePt:=<>aTypeSale{<>aTypeSale}
	entryEntity.typeSale:=DE_PopUpArray(Self:C308)
	TRACE:C157
	
	If ([Order:3]typeSale:22="Matrix@")
		QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]typeSale:3=[Customer:2]typeSale:18; *)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]howUsed:2=[Order:3]typeSale:22; *)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=pQtyOrd; *)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=pQtyOrd)
		If (Records in selection:C76([PriceMatrix:105])=1)
			pUnitPrice:=[PriceMatrix:105]price:6
			pComm:=[PriceMatrix:105]commissionFactor:7
			ptaxID:=[PriceMatrix:105]taxID:8
		Else 
			If (allowAlerts_boo)
				ALERT:C41("Warning: "+String:C10(Records in selection:C76([PriceMatrix:105]))+" PriceMatrix records meet parameters"+"\r"+"[Order]TypeSale: "+[Order:3]typeSale:22)  //+"\r"+"[Customer]TypeSale: "+[Customer]TypeSale
			End if 
		End if 
	Else 
		
		//DscntSetAll (<>tcbManyType;[Customer]customerID;[Order]TypeSale;->
		//[Order]DateNeeded;0)//Size of array(aoLineAction))
		//June 23, 1993    3:26 PM
		LN_PricePoint(->pPricePt; ->[Order:3]typeSale:22; ->pPartNum; ->[Order:3]dateOrdered:4; ->pUnitPrice; ->pDiscnt; ->pQtyOrd; ->pCommRep; ->pCommSales)  //;aOPQDIR{aRayLines{$i}})
		
		Copy_NewEntry(->[Customer:2]; ->[Order:3]typeSale:22; ->[Customer:2]typeSale:18)
		//// zzzqqq U_DTStampFldMod (->[Order]CommentProcess;->[Order]TypeSale)
	End if 
	[Order:3]typeSale:22:=$ordTypeSale
Else 
	Self:C308->:=1
	ALERT:C41("Order Table only")
End if 