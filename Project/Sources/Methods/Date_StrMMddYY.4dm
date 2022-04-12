//%attributes = {"publishedWeb":true}
//Date_StrMMddYY
C_DATE:C307($1)
C_TEXT:C284($0)
$0:=String:C10(Month of:C24($1); "00")+String:C10(Day of:C23($1); "00")+Substring:C12(String:C10(Year of:C25($1)); 3)