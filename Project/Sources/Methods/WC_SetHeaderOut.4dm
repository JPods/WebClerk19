//%attributes = {}

// (PM) WC_SetHeaderOut
// Sets the value for the HTTP header (response)
// $1 = Name
// $2 = Value

C_TEXT:C284($1; $2; $name; $value)
C_LONGINT:C283($index)

$name:=$1
$value:=$2

If ($value="---")
	$index:=Find in array:C230(aHeaderNameOut; $name)
	If ($index#-1)
		DELETE FROM ARRAY:C228(aHeaderNameOut; $index)
		DELETE FROM ARRAY:C228(aHeaderValueOut; $index)
	End if 
Else 
	$index:=Find in array:C230(aHeaderNameOut; $name)
	If ($index#-1)
		// ### AZM 2018-03-19 ### TO SET MULTIPLE COOKIES, SERVERS MUST SEND THE "Set-Cookie" HTTP HEADER MULTIPLE TIMES
		If (aHeaderNameOut{$index}="Set-Cookie")
			APPEND TO ARRAY:C911(aHeaderNameOut; $name)
			APPEND TO ARRAY:C911(aHeaderValueOut; $value)
		Else 
			aHeaderValueOut{$index}:=$value
		End if 
	Else 
		APPEND TO ARRAY:C911(aHeaderNameOut; $name)
		APPEND TO ARRAY:C911(aHeaderValueOut; $value)
	End if 
End if 
