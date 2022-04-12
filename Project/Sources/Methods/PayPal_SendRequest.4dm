//%attributes = {}
If (False:C215)
	//KennyBCookies_mb_v100
	//02/08/2008. new
End if 

//***************************************************
C_LONGINT:C283($0)
$0:=-77


C_LONGINT:C283($stream; $statusRcv; $statusConn; $statusSend; $result; $err; $timeout)
$timeout:=20  //20 seconds to wait

C_LONGINT:C283($stream; $result)
C_TEXT:C284($requestString; $header; $body)
C_TEXT:C284($card_num; $cvv2; $expire; $amount; $fname; $lname; $addr; $city; $state; $zip; $country; $order_num)
C_TEXT:C284($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18)
$card_num:=$1
$expire:=$2
$amount:=$3
$fname:=$4
$lname:=$5
$addr:=$6
$city:=$7
$state:=$8
$zip:=$9
$order_num:=$10



C_TEXT:C284($content; $content2)
$content2:=""
$content:=""

$body:="TRXTYPE=A"
$body:=$body+"&USER="+<>PayflowUserId+"&VENDOR="+<>PayflowUserId+"&PARTNER="+<>PayflowVendorId+"&PWD="+<>PayflowPassword+"&TENDER=C"  //C means direct payment
$body:=$body+"&ACCT="+$card_num+"&CVV2="+$cvv2+"&EXPDATE="+$expire+"&AMT="+$amount
$body:=$body+"&FIRSTNAME="+$fname+"&LASTNAME="+$lname+"&STREET="+$addr+"&ZIP="+$zip


//-------------------------------------- HEADER ---------------------------------------
$header:="POST /"+" HTTP/1.1"+Storage:C1525.char.crlf
$header:=$header+"Host: "+<>PayflowURL+Storage:C1525.char.crlf
$header:=$header+"X-VPS-Timeout: 45"+Storage:C1525.char.crlf
$header:=$header+"X-VPS-Request-ID: "+$order_num+Storage:C1525.char.crlf
$header:=$header+"Content-Type: text/namevalue"+Storage:C1525.char.crlf
$header:=$header+"Content-Length: "+String:C10(Length:C16($body))+Storage:C1525.char.crlf+Storage:C1525.char.crlf
//---------------------------------------------------------------------------------------------
$requestString:=$header+$body
C_TEXT:C284($response)
WC_Request($requestString)

//  process

SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
// ////////////////////////////////////








