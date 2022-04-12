//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/21/06, 19:22:18
// ----------------------------------------------------
// Method: Date_iCal2RFC
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $0)
//Wed, 26 Jul 2006 22:05:00 GMT
//20060721T154904Z


//<>ysSDayNames
C_DATE:C307(vDateiCal)
C_TIME:C306(vTimeiCal)

C_LONGINT:C283($numMon; $numDay)

$strYear:=Substring:C12($1; 1; 4)
$strMon:=Substring:C12($1; 5; 2)
$strDay:=Substring:C12($1; 7; 2)
//
C_DATE:C307($theDate)
$theDate:=Date:C102($strMon+"/"+$strDay+"/"+$strYear)
vDateiCal:=$theDate

$numMon:=Num:C11($strMon)
$strMon:=Substring:C12(<>arrmonth{$numMon}; 1; 3)
$numDay:=Day number:C114($theDate)
$strDayofWeek:=<>ysSDayNames{$numDay}

$strTime:=Substring:C12($1; 10; 2)+":"+Substring:C12($1; 12; 2)+":"+Substring:C12($1; 14; 2)
vTimeiCal:=Time:C179($strTime)

$0:=$strDayofWeek+", "+$strDay+" "+$strMon+" "+$strYear+" "+$strTime+" GMT"