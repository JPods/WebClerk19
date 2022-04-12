//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_TEXT:C284($acct; $name; $comp; $zip; $phone)
$acct:=srZip
$name:=srName
$comp:=srCustomer
$zip:=srZip
$phone:=srPhone
myOK:=0
jCenterWindow(472; 350; 1)
DIALOG:C40([Rep:8]; "diaRepFind")
CLOSE WINDOW:C154
If (myOK=1)
	GOTO RECORD:C242([Rep:8]; aRecNum{aRecNum})
	$1->:=[Rep:8]repId:1
	
End if 
UNLOAD RECORD:C212([Rep:8])
srZip:=$acct
srName:=$name
srCustomer:=$comp
srZip:=$zip
srPhone:=$phone