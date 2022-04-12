//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/29/08, 12:26:38
// ----------------------------------------------------
// Method: SMTP_AUTH
// Description
// 
//
//page explaining SMTP Authentication
//http://www.fehcom.de/qmail/smtpauth.html
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $serverThread; $0)
C_TEXT:C284($mailServer; $mailUserName; $mailPassword; $2; $3; $4)
$serverThread:=$1
$mailServer:=$2
$mailUserName:=$3
$mailPassword:=$4
//
vtEmailStatusMessage:=""

$sendText:="EHLO jgm."+$mailServer+Storage:C1525.char.crlf

$err:=TCP Send($serverThread; $sendText)  // log on SMTP host



vtEmailMessageLog:=vtEmailMessageLog+"\r"+"C:"+$sendText
vtEmailMessage:="C: "+$sendText


C_LONGINT:C283($timeOutTicks; $result; $delayTicks)
If (<>vlWebTimeOutDelay=0)
	<>vlWebTimeOutDelay:=10
End if 
$timeOutTicks:=Tickcount:C458+(60*<>vlWebTimeOutDelay)
$delayTicks:=Tickcount:C458+(30)
C_TEXT:C284($buff; $temp)
$buff:=Char:C90(10)
Repeat 
	$result:=TCP Receive($serverThread; $temp)
	$buff:=$buff+$temp
	Case of 
		: (Position:C15(Char:C90(10)+"2"; $buff)>0)
			$err:=2
		: (Position:C15(Char:C90(10)+"3"; $buff)>0)
			$err:=3
		: (Position:C15(Char:C90(10)+"5"; $buff)>0)
			$err:=-5
		: ($timeOutTicks<Tickcount:C458)
			$err:=-10
	End case 
	IDLE:C311
Until ((($err#0) | (<>vbWCstop)) & ($delayTicks<Tickcount:C458))



vtEmailMessageLog:=vtEmailMessageLog+"\r"+"S:"+Substring:C12($buff; 2)
vtEmailMessage:="S:"+"\r"+Substring:C12($buff; 2)


$signInMeth:=Num:C11(Position:C15("Plain"; $buff)>0)
If ($signInMeth=0)
	$signInMeth:=Num:C11(Position:C15("Login"; $buff)>0)*2
End if 
C_TEXT:C284($b64_Password; $b64_UserName)



//If (False)
C_LONGINT:C283($signInMeth)
Case of 
	: ($signInMeth=2)  //authenticate using LOGIN
		$err:=SMTP_Answer($serverThread; "AUTH LOGIN"+Storage:C1525.char.crlf)
		$b64_UserName:=Text2Base64($mailUserName)
		$b64_Password:=Text2Base64($mailPassword)
		$err:=SMTP_Answer($serverThread; $b64_UserName+Storage:C1525.char.crlf)
		$err:=SMTP_Answer($serverThread; $b64_Password+Storage:C1525.char.crlf)
	: ($signInMeth=3)
		C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
		$authString:=Text2Base64("authid"+Char:C90(0)+$mailUserName+Char:C90(0)+$mailPassword)
		$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+Storage:C1525.char.crlf)
		$err:=SMTP_Answer($serverThread; $authString+"=")  //+Storage.char.crlf
	Else 
		C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
		$myString:=(Char:C90(0)+$mailUserName+Char:C90(0)+$mailPassword)  //###_jwm_### 20080319
		$authString:=Text2Base64($myString)
		//$authString:=Text2Base64 ("authid"+Char(0)+$mailUserName+Char(0)+$mailPassword)  //+"="
		$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+$authString+Storage:C1525.char.crlf)
		If ($err=-5)
			$err:=SMTP_Answer($serverThread; "AUTH LOGIN"+Storage:C1525.char.crlf)
			$b64_UserName:=Text2Base64($mailUserName)
			$b64_Password:=Text2Base64($mailPassword)
			$err:=SMTP_Answer($serverThread; $b64_UserName+Storage:C1525.char.crlf)
			$err:=SMTP_Answer($serverThread; $b64_Password+Storage:C1525.char.crlf)
		End if 
		If ($err=-5)
			C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
			$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+Storage:C1525.char.crlf)
			$err:=SMTP_Answer($serverThread; $authString+Storage:C1525.char.crlf)  //+Storage.char.crlf
		End if 
		If (False:C215)  //Do we still need this ?
			If ($err=-5)
				C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
				$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+$authString+"="+Storage:C1525.char.crlf)  //+Storage.char.crlf
			End if 
			If ($err=-5)
				C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
				$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+Storage:C1525.char.crlf+$authString+"="+Storage:C1525.char.crlf)  //+Storage.char.crlf
			End if 
			If ($err=-5)
				C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
				$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+Storage:C1525.char.crlf+$authString+Storage:C1525.char.crlf)  //+Storage.char.crlf
			End if 
			If ($err=-5)
				C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
				$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+Storage:C1525.char.crlf)
				$err:=SMTP_Answer($serverThread; $authString+"="+Storage:C1525.char.crlf)  //+Storage.char.crlf
			End if 
			
			If ($err=-5)
				C_TEXT:C284($authString)  //: ($signInMeth=1)  //authenticate using PLAIN
				$err:=SMTP_Answer($serverThread; "AUTH PLAIN "+Storage:C1525.char.crlf)
				$err:=SMTP_Answer($serverThread; $authString+"="+Storage:C1525.char.crlf)  //+Storage.char.crlf
			End if 
		End if 
End case 

//vtEmailStatusMessage:=Replace string(Substring(vtEmailMessageLog;3;70);"\r";"")

$0:=$err



