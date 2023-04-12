//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/15/16, 11:41:06
// ----------------------------------------------------
// Method: Set_Cookie
// Description
// SetCookie(vtName;vtValue;vlDuration)
//
// Parameters
// $1 = cookie name as text
// $2 = cookievalue as text
// $3 = duration time in seconds as Long Integer
// ----------------------------------------------------

C_TEXT:C284($1; $name; $2; $value)
C_LONGINT:C283($3; $duration)

$name:=$1
$value:=$2
$duration:=$3  // time in seconds
$path:="/"  // default root folder
$timeExpires:=Time:C179(Time string:C180(Current time:C178+$duration))
$dateExpires:=String:C10(Current date:C33; Date RFC 1123:K1:11; $timeExpires)  // 10 = Date RFC 1123 example Fri, 10 Sep 2010 13:07:20 GMT
$cookie:="Set-Cookie: "+$name+"="+$value+"; expires="+$dateExpires+"; path="+$path+Storage:C1525.char.crlf
// Set-Cookie: Name=content data; expires=Fri, 31-Dec-2010 23:59:59 GMT; path=/; domain=.example.net
// APPEND TO ARRAY(aSetCookie;$cookie)

// the array SetCookie is defined on startup and cleared each the HTTP header is sent in Http_SendWWWHd
//Set-Cookie: <name>=<value>[; <Max-Age>=<age>] [; expires=<date>][; domain=<domain_name>] [; path=<some_path>][; secure][; HttpOnly] 
// ### jwm ### 20180508_1130 added secure and HttpOnly flags to imporve security of cookies

If (Storage:C1525.wc.bforceSSL)
	WC_SetHeaderOut("Set-Cookie"; $name+"="+$value+"; expires="+$dateExpires+"; path="+$path+"; secure; HttpOnly")
Else 
	WC_SetHeaderOut("Set-Cookie"; $name+"="+$value+"; expires="+$dateExpires+"; path="+$path+"; HttpOnly")
End if 
