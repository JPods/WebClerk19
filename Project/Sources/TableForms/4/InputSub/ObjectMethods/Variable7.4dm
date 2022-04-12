// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/13/13, 11:57:04
// ----------------------------------------------------
// Method: Object Method: [Item].iItems_9.bDateTime2
// Description: Adapted from // zzzqqq jDateTimeStamp to append comment
// 
//
// Parameters
// ----------------------------------------------------
//### jwm ### 20130513_1203 new object


C_LONGINT:C283(bDateTime2)
C_LONGINT:C283(bDateTime; $k; $k2; $k3; $where; $length)
C_TEXT:C284($tempTxt)

$length:=Length:C16([ItemSpec:31]Specification:2)
$where:=$length+1

$tempTxt:=String:C10(Current date:C33; 1)+":  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "

$tempTxt:=<>vCR+$tempTxt+"   "
$k:=Length:C16($tempTxt)+$length+1
$k2:=$k-3
$k3:=$k2+2
[ItemSpec:31]Specification:2:=Insert string:C231([ItemSpec:31]Specification:2; $tempTxt; $where)  //Append
HIGHLIGHT TEXT:C210([ItemSpec:31]Specification:2; $k2; $k3)

