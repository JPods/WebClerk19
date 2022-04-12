C_LONGINT:C283($k; $i; $w)  //
PUSH RECORD:C176([Invoice:26])
READ ONLY:C145([Invoice:26])
KeyModifierCurrent
If (OptKey=1)
	QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1)
Else 
	QUERY:C277([Invoice:26]; [Invoice:26]balanceDue:44#0; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]customerid:3=[Customer:2]customerID:1)
End if 
$k:=Records in selection:C76([Invoice:26])
ARRAY LONGINT:C221(aInvoices; $k)
ARRAY TEXT:C222(aInvTerms; $k)
ARRAY REAL:C219(aAmtPaid; $k)
ARRAY REAL:C219(aInvTotals; $k)
ARRAY REAL:C219(aInvDiscountAmounts; $k)
//jArrayTerms 
For ($i; 1; $k)
	aInvoices{$i}:=[Invoice:26]invoiceNum:2
	aInvTerms{$i}:=[Invoice:26]terms:24
	$w:=Find in array:C230(<>aTerms; [Invoice:26]terms:24)
	If ($w>0)
		//  aDscntDays{$i}:=[Invoice]DateShipped+eLTDscDays{$w}
		aInvDiscountAmounts{$i}:=Round:C94(([Invoice:26]amount:14*(1-([Term:37]discountRate:4*0.01)))+[Invoice:26]salesTax:19+[Invoice:26]shipTotal:20; <>tcDecimalTt)
	Else 
		//    aDscntDays{$i}:=!00/00/00!
		aInvDiscountAmounts{$i}:=Round:C94([Invoice:26]total:18; <>tcDecimalTt)
	End if 
	aAmtPaid{$i}:=Round:C94([Invoice:26]total:18-[Invoice:26]balanceDue:44; <>tcDecimalTt)
	aInvTotals{$i}:=Round:C94([Invoice:26]total:18; <>tcDecimalTt)
	NEXT RECORD:C51([Invoice:26])
End for 
UNLOAD RECORD:C212([Invoice:26])
//jArrayTrmClr 
READ WRITE:C146([Invoice:26])
POP RECORD:C177([Invoice:26])