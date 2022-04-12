//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-30T00:00:00, 16:20:00
// ----------------------------------------------------
// Method: jAddRelateInclu
// Description
// Modified: 08/30/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2; $3)
CREATE SET:C116($1->; "Current")
CREATE RECORD:C68($1->)
C_LONGINT:C283($protectedFieldNum)
$protectedFieldNum:=STR_GetUniqueFieldNum(Table name:C256($1))  // False returns both positive and negative numbers
If ($protectedFieldNum<0)  // positive numbers are auto assigned
	Field:C253(Table:C252($1); $protectedFieldNum)->:=CounterNew($1)
End if 
If (Count parameters:C259=3)
	$2->:=$3->
End if 
SAVE RECORD:C53($1->)
ADD TO SET:C119($1->; "Current")
USE SET:C118("Current")
CLEAR SET:C117("Current")