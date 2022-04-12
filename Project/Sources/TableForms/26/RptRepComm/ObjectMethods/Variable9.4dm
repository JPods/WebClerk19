C_REAL:C285(vShipAmt; $grossMar; $factor)
C_LONGINT:C283($i; $k)
//TRACE
// ### bj ### 20191005_1801 TESTTHIS
vShipAmt:=[Invoice:26]amount:14  //
If ([Invoice:26]appliedAmount:46#[Invoice:26]total:18)
	$expectedAmt:=[Invoice:26]appliedAmount:46-[Invoice:26]salesTax:19-[Invoice:26]shipTotal:20
	If (($expectedAmt<[Invoice:26]amount:14) & ([Invoice:26]amount:14#0))
		$factor:=$expectedAmt/[Invoice:26]amount:14
	Else 
		$factor:=1
	End if 
Else 
	$factor:=1
End if 
If (vi1=0)
	vComAmount:=[Invoice:26]repCommission:28*$factor
Else 
	vComAmount:=[Invoice:26]salesCommission:36*$factor
End if 
If (<>tcSaleMar=1)  //"Based on Sales"
	
	
	
	
	If (vShipAmt#0)
		vComRate:=Round:C94(100*vComAmount/(vShipAmt*$factor); 1)
	Else 
		vComRate:=0
	End if 
Else 
	$grossMar:=vShipAmt-[Invoice:26]totalCost:37
	If ($grossMar#0)
		vComRate:=Round:C94(100*vComAmount/$grossMar; 1)
	Else 
		vComRate:=0
	End if 
End if 
