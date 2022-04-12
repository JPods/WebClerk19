//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-31T00:00:00, 17:38:51
// ----------------------------------------------------
// Method: CreditCardParse
// Description
// Modified: 12/31/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $workingText; $clipped; $creditcard; $lastName; $firstName; $year; $month; $code)
$workingText:=$1
$0:=$1
If (False:C215)
	$workingText:="%B4644751213334320^JAMES/WILLIAM D^1511101000000000072700727000000?"+"\r"+";4644751213334320=1.51110e+19?"
End if 
C_LONGINT:C283($p; $start; $end; $k)
$p:=Position:C15("%B"; $workingText)
If ($p>0)
	$start:=$p+2
	$p:=Position:C15("^"; $workingText)
	If ($p>0)
		$creditcard:=Substring:C12($workingText; $start; $p-$start)
		$end:=$p-1
		$workingText:=Substring:C12($workingText; $p+1)
		$p:=Position:C15("/"; $workingText)
		$lastName:=Substring:C12($workingText; 1; $p-1)
		$workingText:=Substring:C12($workingText; $p+1)
		$p:=Position:C15("^"; $workingText)
		$firstName:=Substring:C12($workingText; 1; $p-1)
		$workingText:=Substring:C12($workingText; $p+1)
		$year:=Substring:C12($workingText; 1; 2)
		$month:=Substring:C12($workingText; 3; 2)
		$p:=Position:C15("?"; $workingText)
		$code:=Substring:C12($workingText; 5; $p-5)
		[Payment:28]creditCardNum:13:=$creditcard
		[Payment:28]nameOnAcct:11:=$firstName+" "+$lastName
		[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; $creditCard; ->[Payment:28]creditCardBlob:53)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
		[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum($creditCard)
		C_LONGINT:C283($ccType)
		C_TEXT:C284($cardType)
		$ccType:=CC_GetCCTypeConst($creditCard)
		$cardType:=CC_GetCCTypeString($ccType)
		C_DATE:C307($ccDate)
		$ccDate:=Date:C102($month+"/01/"+$year)
		$ccDate:=Date_ThisMon($ccDate; 1)
		[Payment:28]dateExpires:14:=$ccDate
		
	End if 
	$0:="Credit Card scan completed"
End if 