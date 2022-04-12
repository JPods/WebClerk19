//%attributes = {"publishedWeb":true}
//Procedure: Date_Century
C_DATE:C307($1; $0)
C_LONGINT:C283($year)
$year:=Year of:C25($1)
If (($year<1980) & ($1#!00-00-00!) & ($1#!1901-01-01!))
	If (<>vbDateByDDMMYY)
		$0:=Date:C102(String:C10(Day of:C23($1))+"/"+String:C10(Month of:C24($1))+"/"+String:C10(Year of:C25($1)+100))
	Else 
		$0:=Date:C102(String:C10(Month of:C24($1))+"/"+String:C10(Day of:C23($1))+"/"+String:C10(Year of:C25($1)+100))
	End if 
Else 
	$0:=$1
End if 