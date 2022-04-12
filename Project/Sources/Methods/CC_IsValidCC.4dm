//%attributes = {"publishedWeb":true}
//Dan; Arkware (10/25/01)
// performs a mod10 check to verify the credit card
// using the credit card number passed in

C_BOOLEAN:C305($0)
C_TEXT:C284($1; $ccnum)
$ccnum:=$1

C_LONGINT:C283($cardLength)
$cardLength:=Length:C16($ccnum)

// mod10 check
C_LONGINT:C283($location; $checksum; $digit)
$checksum:=0

For ($location; 1-($cardLength%2); $cardLength; 2)
	$checksum:=$checksum+Num:C11(Substring:C12($ccnum; $location+1; 1))
End for 

For ($location; ($cardLength%2); $cardLength; 2)
	$digit:=Num:C11(Substring:C12($ccnum; $location+1; 1))*2
	If ($digit<10)
		$checksum:=$checksum+$digit
	Else 
		$checksum:=$checksum+$digit-9
	End if 
End for 

If (($checksum%10)=0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
