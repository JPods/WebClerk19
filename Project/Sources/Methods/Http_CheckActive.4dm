//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/10/09, 13:47:23
// ----------------------------------------------------
// Method: Http_CheckActive
// Description
// 
//
// Parameters
// ----------------------------------------------------
//NKTCheck
C_TEXT:C284($1; $2; $host; $message; $response)
C_LONGINT:C283($isAlive; $timedOut)
$timedOut:=30  //seconds
//
$host:=$1
$message:=$2
If ($message="")
	$message:="test ping"
End if 
//
NET_Ping($1; $message; $isAlive; $timedOut)
$response:=(("OK"*Num:C11($isAlive=1))+("Failed"*Num:C11($isAlive#1)))
ALERT:C41($host+" ping  "+$response)