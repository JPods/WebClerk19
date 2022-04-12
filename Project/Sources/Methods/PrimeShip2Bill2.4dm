//%attributes = {}
If (False:C215)
	Version_0602
	PrimeShip2Bill2
End if 
C_TEXT:C284($0)
C_LONGINT:C283($1; $doArrays)
$doArrays:=0
If (Count parameters:C259=1)
	$doArrays:=$1
End if 
If ($doArrays>0)
	$0:=("Bill2"*(Num:C11(aContactsUniqueID{$doArrays}=[QQQCustomer:2]contactBillTo:92)))
	$0:=$0+(" "*Num:C11($0#""))+("Ship2"*(Num:C11(aContactsUniqueID{$doArrays}=[QQQCustomer:2]contactShipTo:93)))
Else 
	$0:=("Bill2"*(Num:C11([QQQContact:13]idUnique:28=[QQQCustomer:2]contactBillTo:92)))+(" Ship 2"*(Num:C11([QQQContact:13]idUnique:28=[QQQCustomer:2]contactShipTo:93)))+(" Ltr"*(Num:C11([QQQContact:13]LetterList:13)))
End if 