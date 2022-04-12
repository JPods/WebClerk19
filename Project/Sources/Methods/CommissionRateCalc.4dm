//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/07, 11:50:30
// ----------------------------------------------------
// Method: CommissionRateCalc
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $commissionMethod)
C_REAL:C285($0; $2; $3; $commissionRate; $amount; $commission)
Case of 
	: (Count parameters:C259#3)
		$commissionRate:=0
	Else 
		$amount:=$2
		$commission:=$3
		
		$amount:=[Invoice:26]amount:14  //
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
			$commission:=[Invoice:26]repCommission:28*$factor
		Else 
			$commission:=[Invoice:26]salesCommission:36*$factor
		End if 
		If (<>tcSaleMar=1)  //"Based on Sales"
			If ($amount#0)
				$commissionRate:=Round:C94(100*$commission/($amount*$factor); 1)
			Else 
				$commissionRate:=0
			End if 
		Else 
			$grossMar:=$amount-[Invoice:26]totalCost:37
			If ($grossMar#0)
				$commissionRate:=Round:C94(100*$commission/$grossMar; 1)
			Else 
				$commissionRate:=0
			End if 
		End if 
		$0:=$commissionRate
		
End case 




