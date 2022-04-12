//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/21/06, 19:18:54
// ----------------------------------------------------
// Method: Date_RFC2iCal
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0)
//Wed, 26 Jul 2006 22:05:00 GMT
//20060721T154904Z
$strDay:=Substring:C12($1; 6; 2)
$strMon:=Substring:C12($1; 9; 3)+"@"
$strYear:=Substring:C12($1; 13; 4)
$strTime:=Substring:C12($1; 18; 8)
C_LONGINT:C283($numMon)
$numMon:=Find in array:C230(<>arrMonth; $strMon)

$0:=$strYear+String:C10($numMon; "00")+String:C10(Num:C11($strDay); "00")+"T"+String:C10(Num:C11(Substring:C12($strTime; 1; 2)); "00")+Substring:C12($strTime; 4; 2)+Substring:C12($strTime; 7; 2)+"Z"

