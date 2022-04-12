//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/06/17, 14:04:06
// ----------------------------------------------------
// Method: Macro_AddComment
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Script DateTimeString 20150316

C_TEXT:C284($input_text)
C_TEXT:C284($output_text)
GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $input_text)
C_TEXT:C284($1; $0; $name)

$name:=$1

vText:=""
vText:="  // ### "+$name+" ### "
vDate1:=Current date:C33
vhNow:=Current time:C178
vText:=vText+String:C10(Year of:C25(vDate1))  // year
vText:=vText+String:C10(Month of:C24(vDate1); "00")  // month
vText:=vText+String:C10(Day of:C23(vDate1); "00")  // day
vText:=vText+"_"
vText:=vText+String:C10((vhNow\3600); "00")  // hour
vText:=vText+String:C10(((vhNow\60)%60); "00")  // minute
//vText:=vText+String( (vhNow%60); "00" )// second
//ALERT(vText)
//SET TEXT TO PASTEBOARD(vText)
//$0:=vText
SET MACRO PARAMETER:C998(Highlighted method text:K5:18; vText)

