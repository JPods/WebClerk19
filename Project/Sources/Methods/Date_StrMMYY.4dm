//%attributes = {"publishedWeb":true}
//Procedure: Date_StrMMYY
C_DATE:C307($1; $theDate)
C_TEXT:C284($0)
If (Count parameters:C259=1)
	$theDate:=$1
Else 
	$theDate:=Current date:C33
End if 
$0:=String:C10(Month of:C24($theDate); "00")+Substring:C12(String:C10(Year of:C25($theDate); "0000"); 3; 2)