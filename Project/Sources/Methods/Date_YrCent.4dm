//%attributes = {"publishedWeb":true}
//Procedure: Date_YrCent
C_TEXT:C284($1)
C_LONGINT:C283($0; $year)
$year:=Num:C11($1)
Case of 
	: ($year<90)
		$0:=$year+2000
	: (($year>=90) & ($year<=99))
		$0:=$year+1900
	: ($year>=2000)
		$0:=$year
	: ($year<2000)
		$0:=$year
End case 