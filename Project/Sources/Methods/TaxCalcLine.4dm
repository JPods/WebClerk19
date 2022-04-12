//%attributes = {}
If (False:C215)
	Version_0602
	TaxCalcLine
End if 
C_BOOLEAN:C305($0)
C_POINTER:C301($1; $ptTable; $8; $9)
C_TEXT:C284($2; $3)
C_REAL:C285($4; $5)
C_LONGINT:C283($6; $7; $thePrec; viTaxThisItem)
//->[Order]TaxJuris;[Customer]TaxExemptID;aOTaxable{$6}; aOExtPrice{$6}; aOExtCost{$6}
$8->:=0
$9->:=0
C_LONGINT:C283($findTax)
$findTax:=Find in array:C230(<>aTaxJuris; $1->)
If ($findTax>0)
	$thePrec:=$7
	$notTaxExempt:=Num:C11(($2="") | ($3="DoTax"))
	sTaxRate:=<>aTaxRateSales{$findTax}*0.01
	vTaxRateCost:=<>aTaxRateCost{$findTax}*0.01
	
	viTaxThisItem:=Num:C11(Not:C34(($3="NoTax") | ($3="No Tax")))
	Case of 
		: (<>aTaxService{$findTax}="StandardSalesTax")
			$8->:=Round:C94(viTaxThisItem*$notTaxExempt*$4*sTaxRate; $thePrec)  //unit of measur in ext price
			//aOSaleTax{$6}:=Round(Num(aOTaxable{$6}#"NoTax")*aOExtPrice{$6}*sTaxRate;$thePrec)//unit of measur in ext price
			
		: (<>aTaxService{$findTax}="ByCost")
			$9->:=Round:C94(viTaxThisItem*$notTaxExempt*$5*vTaxRateCost; $thePrec)  //unit of measur in ext price
			//aOSaleTax{$6}:=Round(Num(aOTaxable{$6}#"NoTax")*$notTaxExempt*aOExtCost{$6}*sTaxRate;$thePrec)//unit of measur in ext price
			
		: (<>aTaxService{$findTax}="WebBased")
			$ptTable:=Table:C252(Table:C252($1))
			Case of 
				: (viTaxThisItem=1)  // (($3="NoTax")|($3="No Tax"))
					$8->:=0
				: ($ptTable=(->[Order:3]))
					ptaxID:=$3
					Case of 
						: ([Order:3]country:21="USA")
							pvCountry:="US"
						: ([Order:3]country:21="")
							pvCountry:="US"
						Else 
							pvCountry:=[Order:3]country:21
					End case 
					ptaxID:=aOTaxable{$6}
					pvTransDate:=String:C10(Month of:C24(Current date:C33))+"/"+String:C10(Year of:C25(Current date:C33))
					pvTransDateTime:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")+"T"+String:C10(Current time:C178; 1)+".981Z"
					
					TaxWebService
					aoProfile1{$6}:=pvLnProfile1
					aoProfile2{$6}:=pvLnProfile2
					aoProfile3{$6}:=pvTaxRate
					//aOSaleTax{$6}:=Num(pvTax)
					$8->:=Num:C11(pvTax)
					$9->:=Num:C11(pvrTaxCost)
				: ($ptTable=(->[Proposal:42]))
					ptaxID:=$3
					Case of 
						: ([Proposal:42]country:17="USA")
							pvCountry:="US"
						: ([Proposal:42]country:17="")
							pvCountry:="US"
						Else 
							pvCountry:=[Proposal:42]country:17
					End case 
					ptaxID:=aOTaxable{$6}
					pvTransDate:=String:C10(Month of:C24(Current date:C33))+"/"+String:C10(Year of:C25(Current date:C33))
					pvTransDateTime:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")+"T"+String:C10(Current time:C178; 1)+".981Z"
					
					TaxWebService
					aPProfile1{$6}:=pvLnProfile1
					aPProfile2{$6}:=pvLnProfile2
					aPProfile3{$6}:=pvTaxRate
					//aOSaleTax{$6}:=Num(pvTax)
					$8->:=Num:C11(pvTax)
					$9->:=Num:C11(pvrTaxCost)
				: ($ptTable=(->[Invoice:26]))
					ptaxID:=$3
					Case of 
						: ([Invoice:26]country:13="USA")
							pvCountry:="US"
						: ([Invoice:26]country:13="")
							pvCountry:="US"
						Else 
							pvCountry:=[Invoice:26]country:13
					End case 
					ptaxID:=aOTaxable{$6}
					pvTransDate:=String:C10(Month of:C24(Current date:C33))+"/"+String:C10(Year of:C25(Current date:C33))
					pvTransDateTime:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")+"T"+String:C10(Current time:C178; 1)+".981Z"
					
					TaxWebService
					aiProfile1{$6}:=pvLnProfile1
					aiProfile2{$6}:=pvLnProfile2
					aiProfile3{$6}:=pvTaxRate
					$8->:=Num:C11(pvTax)
					$9->:=Num:C11(pvrTaxCost)
			End case 
		Else 
			//aOSaleTax{$6}:=Round(Num(aOTaxable{$6}#"NoTax")*aOExtPrice{$6}*sTaxRate;$thePrec)//unit of measur in ext price
			$8->:=0
			$9->:=0
			If (<>aTaxScriptSales{$findTax}#"")
				C_REAL:C285(vrTaxSales; vrTaxCost)
				vrTaxSales:=0
				ExecuteText(0; <>aTaxScriptSales{$findTax})
				//aOSaleTax{$6}:=vR1
				$8->:=vrTaxSales
			Else 
				If (<>aTaxRateSales{$findTax}#0)
					$8->:=Round:C94(viTaxThisItem*$notTaxExempt*$4*sTaxRate; $thePrec)  //unit of measur in ext price
				End if 
			End if 
			If (<>aTaxScriptCost{$findTax}#"")
				C_REAL:C285(vrTaxSales; vrTaxCost)
				vrTaxCost:=0
				ExecuteText(0; <>aTaxScriptCost{$findTax})
				//aOSaleTax{$6}:=vR1
				$9->:=vrTaxCost
			Else 
				If (<>aTaxRateCost{$findTax}#0)
					$9->:=Round:C94(viTaxThisItem*$notTaxExempt*$5*vTaxRateCost; $thePrec)
				End if 
			End if 
	End case 
End if 