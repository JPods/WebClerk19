//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2; $theMachine; $vRequest)
C_TEXT:C284($0)
C_LONGINT:C283($3; $theReply)
$theMachine:=$2
If (Count parameters:C259=3)
	$theReply:=$3
Else 
	$theReply:=0
End if 
//
$vRequest:=""
$vRequest:=$vRequest+"GET "+$1+" HTTP/1.1"+Storage:C1525.char.crlf
If ($theReply=0)
	$vRequest:=$vRequest+"Host: "+$2+Storage:C1525.char.crlf
End if 
$vRequest:=$vRequest+"Accept: */*"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"ACCEPT-Language: en-us"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"Connection: Keep-Alive"+Storage:C1525.char.crlf
$vRequest:=$vRequest+"Referer: http://"+Storage:C1525.default.domain+Storage:C1525.char.crlf
$vRequest:=$vRequest+"User-Agent: Mozilla/4(compatible;MSIE 5.5;Windows 98)"+Storage:C1525.char.crlf+Storage:C1525.char.crlf
//
$0:=$vRequest