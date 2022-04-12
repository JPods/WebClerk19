//%attributes = {"publishedWeb":true}
//Procedure: Date_strYrMmDd
C_TEXT:C284($0)
C_DATE:C307($1; $theDate)
C_LONGINT:C283($2)
C_LONGINT:C283(<>DateFormat)


$dateOpt:=<>DateFormat
If (Count parameters:C259>0)
	$theDate:=$1
	If (Count parameters:C259=2)
		$dateOpt:=$2
	End if 
Else 
	$theDate:=Current date:C33
End if 
Case of 
	: ($dateOpt=0)
		$0:=String:C10(Year of:C25($theDate); "0000")+String:C10(Month of:C24($theDate); "00")+String:C10(Day of:C23($theDate); "00")
	: ($dateOpt=1)
		$0:=Substring:C12(String:C10(Year of:C25($theDate); "0000"); 3; 2)+String:C10(Month of:C24($theDate); "00")+String:C10(Day of:C23($theDate); "00")
	Else 
		$0:=String:C10(Month of:C24($theDate); "00")+String:C10(Day of:C23($theDate); "00")+Substring:C12(String:C10(Year of:C25($theDate); "0000"); 3; 2)
End case 