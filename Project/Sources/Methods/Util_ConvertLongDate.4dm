//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  Util_ConvertLongDate
	//Desc.:  
	//NB:      
	//CB:      V_ImportStart
	//New:   04-11-03.dmb
End if 

//takes string formated as  "Fri Mar 07 08:13:09 2003" (24 characters) and returns
//a 4D date

C_TEXT:C284($1; $longDate)
$longDate:=$1
C_DATE:C307($0)

ARRAY TEXT:C222($monthArray; 12)
$monthArray{1}:="Jan"
$monthArray{2}:="Feb"
$monthArray{3}:="Mar"
$monthArray{4}:="Apr"
$monthArray{5}:="May"
$monthArray{6}:="Jun"
$monthArray{7}:="Jul"
$monthArray{8}:="Aug"
$monthArray{9}:="Sep"
$monthArray{10}:="Oct"
$monthArray{11}:="Nov"
$monthArray{12}:="Dec"

C_LONGINT:C283($mon)
C_TEXT:C284($day)
C_TEXT:C284($year)
$mon:=Find in array:C230($monthArray; Substring:C12($longDate; 5; 3))
$day:=Substring:C12($longDate; 9; 2)
$year:=Substring:C12($longDate; 21; 4)
$0:=Date:C102(String:C10($mon)+"/"+$day+"/"+$year)