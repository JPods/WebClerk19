//%attributes = {"publishedWeb":true}
//Dan; Arkware (10/25/01)
// figure out credit card type using the number passed in

// visa starts with 4
// mastercard starts with 51, 52, 53, 54, 55
// american express starts with 34, 37
//discover starts with 6011

C_LONGINT:C283($0)
C_TEXT:C284($1; $ccnum)
$ccnum:=$1

C_LONGINT:C283($type; $numbersLeft; $cardLength)
$numbersLeft:=Num:C11(Substring:C12($ccnum; 0; 4))
$cardLength:=Length:C16($ccnum)

$type:=<>ciCCIUnknwn

//check nums and length to get type
Case of 
	: ((Substring:C12($ccnum; 0; 4)="2131") | (Substring:C12($ccnum; 0; 4)="1800"))  // JCB
		If ($cardLength=15)
			$type:=<>ciCCIJCB
		End if 
	: ((Substring:C12($ccnum; 0; 4)="2149") | (Substring:C12($ccnum; 0; 4)="2014"))  //EnRoute
		If ($cardLength=15)
			$type:=<>ciCCIOther
		End if 
	: (Substring:C12($ccnum; 0; 4)="6011")  //Discover
		If ($cardLength=16)
			$type:=<>ciCCIDiscov
		End if 
	: (Substring:C12($ccnum; 0; 4)="5610")  //Australian BankCard
		If ($cardLength=16)
			$type:=<>ciCCIOther
		End if 
	: (((Num:C11(Substring:C12($ccnum; 0; 3))>=300) & (Num:C11(Substring:C12($ccnum; 0; 3))<=305)) | (Substring:C12($ccnum; 0; 3)="36") | (Substring:C12($ccnum; 0; 3)="38"))  //Diners club/carte blanche
		If ($cardLength=14)
			If ((Num:C11(Substring:C12($ccnum; 0; 3))>=8390) & (Num:C11(Substring:C12($ccnum; 0; 3))<=8399))  // carte blache
				$type:=<>ciCCICartBl
			Else 
				$type:=<>ciCCIDiners
			End if 
		End if 
	: ((Substring:C12($ccnum; 0; 2)="34") | (Substring:C12($ccnum; 0; 2)="37"))  //amex
		If ($cardLength=15)
			$type:=<>ciCCIAmEx
		End if 
	: ((Num:C11(Substring:C12($ccnum; 0; 2))>=51) & (Num:C11(Substring:C12($ccnum; 0; 2))<=55))  //mc
		If ($cardLength=16)
			$type:=<>ciCCIMstrCd
		End if 
	: (Substring:C12($ccnum; 0; 1)="4")  //visa
		If (($cardLength=16) | ($cardLength=13))
			$type:=<>ciCCIVisa
		End if 
	: (Substring:C12($ccnum; 0; 1)="3")  //JCB
		If ($cardLength=16)
			$type:=<>ciCCIJCB
		End if 
		
End case 

$0:=$type