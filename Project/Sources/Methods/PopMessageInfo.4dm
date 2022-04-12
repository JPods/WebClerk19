//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 13:08:33
// ----------------------------------------------------
// Method: Method: PopMessageInfo
// Description
// 
//
//
//POP3_MsgInfo (pop3_ID; msgNumber; msgSize; uniqueID) Integer
//
//Parameter	      Type	      	      Description
//pop3_ID	      Longint	      	      Reference to a POP3 login
//msgNumber	      Longint	      	      Message number
//msgSize	      Longint	      	      Message size
//uniqueID	      String	      	      Unique ID of message on server
//Function result	      Integer	      	      Error Code
// ----------------------------------------------------

C_LONGINT:C283($pop3_ID; $1)
C_LONGINT:C283($msgNumber; $2)
C_LONGINT:C283($msgsize)
C_TEXT:C284($uniqueID)
C_LONGINT:C283($error)



$pop3_ID:=$1
$msgNumber:=$2

$error:=POP3_MsgInfo($pop3_ID; $msgNumber; $msgsize; $uniqueID)





