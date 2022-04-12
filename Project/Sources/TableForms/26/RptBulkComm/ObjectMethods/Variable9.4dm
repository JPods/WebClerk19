// Modified by: Bill James (2015-05-28T00:00:00 Subrecord eliminated)


C_REAL:C285(vShipAmt; $grossMar)
C_LONGINT:C283($i; $k; $w)

MfgName:=[Invoice:26]customerid:3
QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
FIRST RECORD:C50([InvoiceLine:54])
//$w:=Find in array(aMfgIdKey;[Invoice]LineItems'Location)
//If ($w>0)
//MfgName:=aMfg{$w}
//Else 
//vText1:=String([Invoice]LineItems'Location)
//End if 
vShipAmt:=0
$k:=Records in selection:C76([InvoiceLine:54])
For ($i; 1; $k)
	vShipAmt:=vShipAmt+[InvoiceLine:54]qtyShipped:7
	NEXT RECORD:C51([InvoiceLine:54])
End for 

If ([Invoice:26]appliedAmount:46#vShipAmt)
	$expectedAmt:=[Invoice:26]appliedAmount:46-[Invoice:26]salesTax:19-[Invoice:26]shipTotal:20
	If (($expectedAmt<vShipAmt) & (vShipAmt#0))
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
		vComRate:=Round:C94(100*vComAmount/vShipAmt; 1)
	Else 
		vComRate:=0
	End if 
Else 
	$grossMar:=vShipAmt  //-[Invoice]TotalCost          //not on Bulk
	If ($grossMar#0)
		vComRate:=Round:C94(100*vComAmount/$grossMar; 1)
	Else 
		vComRate:=0
	End if 
End if 
