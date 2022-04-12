//%attributes = {"publishedWeb":true}
//Method: SetPricePoint
C_TEXT:C284($1)
C_LONGINT:C283($0)

//TRACE
$booClearSpecial:=False:C215
$w:=Find in array:C230(<>aTypeSale; $1; 2)
Case of 
	: (($1=<>tcPriceLvlA) | ($1=""))  //(Ascii([Invoice]TypeSale)=Ascii(ALevelPrice))
		$0:=2
		$booClearSpecial:=True:C214
	: ($1=<>tcPriceLvlB)
		$0:=3
		$booClearSpecial:=True:C214
	: ($1=<>tcPriceLvlC)
		$0:=4
		$booClearSpecial:=True:C214
	: ($1=<>tcPriceLvlD)
		$0:=5
		$booClearSpecial:=True:C214
	: ($w>0)
		C_LONGINT:C283($w)
		If ($w>0)
			$0:=<>aTypeSaleNum{$w}
			vSpclDscn:=0
			If (<>aTypeSaleRecordNum{$w}>-1)
				GOTO RECORD:C242([SpecialDiscount:44]; <>aTypeSaleRecordNum{$w})
				If ([SpecialDiscount:44]PerCent:5)
					vSpclDscn:=[SpecialDiscount:44]PerCentDiscount:6
				Else 
					//  Must apply to to specific items 
					
				End if 
				REDUCE SELECTION:C351([SpecialDiscount:44]; 0)
			End if 
		Else 
			$0:=2
		End if 
	Else 
		$0:=2
End case 
If (($0<2) | ($0>5))
	$0:=2
End if 
If ($booClearSpecial)
	DscntSpecialClr  //no parameter to clear array
End if 
