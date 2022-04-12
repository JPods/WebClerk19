//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 13:01:13
// ----------------------------------------------------
// Method: Method: PopMessageListInfo
// Description
// 
//
//Parameter	       Type	       	       Description
//pop3_ID	       Longint	       	       Reference to a POP3 login
//start	       Longint	       	       Start message number
//end	       Longint	       	       End message number
//hdrArray	       Str | Txt Array	       	       Array of Headers to retrieve
//msgNumArray	       Longint Array	       	       Array of message numbers
//idArray	       String Array	       	       String array of Unique ID's
//valueArray	       2D Str|Txt Array	       	       2D Array of header values
//Function result	       Integer	       	       Error Code

// ----------------------------------------------------

//

C_LONGINT:C283($pop3_ID; $1)
C_LONGINT:C283($startMsg; $2)
C_LONGINT:C283($endMsg; $3)
ARRAY LONGINT:C221($sizeArray; 0)
ARRAY LONGINT:C221($msgNumArray; 0)
ARRAY TEXT:C222($idArray; 0)
C_LONGINT:C283($error)
//
$pop3_ID:=$1
$startMsg:=$2
$endMsg:=$3
//
$error:=POP3_MsgLstInfo($pop3_ID; $startMsg; $endMsg; $sizeArray; $msgNumArray; $idArray)

