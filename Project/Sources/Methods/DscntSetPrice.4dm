//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/10/11, 18:55:50
// ----------------------------------------------------
// Method: DscntSetPrice
// Description
// 
//
// Parameters
// ----------------------------------------------------


//DscntSetPrice
C_TEXT:C284($1)
C_DATE:C307($theDate; $2)
C_BOOLEAN:C305(booSpclComm)
C_LONGINT:C283(vCommable)
// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
initSpclDisRay(0)  //  clear any existing discounts
If (Count parameters:C259=2)
	If ($2>(Current date:C33-45))
		$theDate:=$2  //-[Customer]ShippingDays
	Else 
		$theDate:=Current date:C33
	End if 
Else 
	$theDate:=Current date:C33
End if 
$booSetPrice:=False:C215
// Modified by: Bill James (2015-01-19T00:00:00 fix SpecialDiscountby%)
vSpclDscn:=0
//TRACE
Case of 
	: ($1=<>tcPriceLvlA)
		vUseBase:=2
		$booSetPrice:=True:C214
	: ($1=<>tcPriceLvlB)
		vUseBase:=3
		$booSetPrice:=True:C214
	: ($1=<>tcPriceLvlC)
		vUseBase:=4
		$booSetPrice:=True:C214
	: ($1=<>tcPriceLvlD)
		vUseBase:=5
		$booSetPrice:=True:C214
	: (<>tcbManyType=False:C215)
		vUseBase:=2
		$booSetPrice:=True:C214
	Else 
		vUseBase:=-1
		QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]typeSale:1=$1; *)
		QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]dateBegin:2<=$theDate; *)
		QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]dateEnd:3>=$theDate)
		Case of 
			: (Records in selection:C76([SpecialDiscount:44])=0)
				If (allowAlerts_boo)
					If (Not:C34((Character code:C91($1)=Character code:C91(<>tcPriceLvlA)) | (Character code:C91($1)=Character code:C91(<>tcPriceLvlB)) | (Character code:C91($1)=Character code:C91(<>tcPriceLvlC)) | (Character code:C91($1)=Character code:C91(<>tcPriceLvlD))))
						//MESSAGE("There are no Special Discounts of this name for this delivery date.")
					End if 
				End if 
				DscntSpecialClr($1)
			: (Records in selection:C76([SpecialDiscount:44])=1)
				If ([SpecialDiscount:44]perCent:5)  //universal discount
					vSpclDscn:=[SpecialDiscount:44]perCentDiscount:6
				Else 
					vSpclDscn:=0
					QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
					SELECTION TO ARRAY:C260([ItemDiscount:45]itemNum:2; aDsctItem; [ItemDiscount:45]perCentDiscount:4; aDscnPC; [ItemDiscount:45]basePrice:5; aBasePrice)
				End if 
				booSpclComm:=True:C214
				vCommable:=[SpecialDiscount:44]commission:9
				vUseBase:=[SpecialDiscount:44]priceBase:8+1
			: (Records in selection:C76([SpecialDiscount:44])>1)
				If (allowAlerts_boo)
					SELECTION TO ARRAY:C260([SpecialDiscount:44]typeSale:1; aDiscType; [SpecialDiscount:44]priceBase:8; aPriceLevel; [SpecialDiscount:44]dateBegin:2; aDateBegins; [SpecialDiscount:44]dateEnd:3; aDateEnds; [SpecialDiscount:44]perCentDiscount:6; aPerCents; [SpecialDiscount:44]note:7; aNotes)
					viRecordsInSelection:=Size of array:C274(aDiscType)
					UNLOAD RECORD:C212([SpecialDiscount:44])
					jCenterWindow(462; 220; 1)
					DIALOG:C40([SpecialDiscount:44]; "diaListDscnts")
					CLOSE WINDOW:C154
				Else 
					myOK:=1
					aNotes:=1  //assume first choice
				End if 
				If ((myOK=1) & (aNotes>0))
					GOTO SELECTED RECORD:C245([SpecialDiscount:44]; aNotes)
					If ([SpecialDiscount:44]perCent:5)
						vSpclDscn:=[SpecialDiscount:44]perCentDiscount:6
					Else 
						vSpclDscn:=0
						QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
						SELECTION TO ARRAY:C260([ItemDiscount:45]itemNum:2; aDsctItem; [ItemDiscount:45]perCentDiscount:4; aDscnPC; [ItemDiscount:45]basePrice:5; aBasePrice)
					End if 
					booSpclComm:=True:C214
					vCommable:=[SpecialDiscount:44]commission:9
					vUseBase:=[SpecialDiscount:44]priceBase:8+1
				Else 
					DscntSpecialClr($1)
					ALERT:C41("No Special Discount is being applied.")
				End if 
				initSpclDisRay(0)
		End case 
		If ((vUseBase<2) | (vUseBase>5))
			vUseBase:=2
		End if 
		REDUCE SELECTION:C351([SpecialDiscount:44]; 0)
End case 
If ($booSetPrice)
	DscntSpecialClr  //no parameter   //($1)
End if 