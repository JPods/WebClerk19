//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/17/07, 14:52:49
// ----------------------------------------------------
// Method: jSetFromArray
// Description: creates and returns a set depending on what it is passed
// Utility for Add to Set
//
// Parameters
// ----------------------------------------------------
//Purpose of thi

C_LONGINT:C283($i; $k)
C_POINTER:C301($1; $2; $3; $4)
MESSAGES OFF:C175
BEEP:C151  //PLAY("Sosumi")
CREATE EMPTY SET:C140($1->; "Current")
Case of 
	: (Count parameters:C259=4)  //Pass $1 Table pointer,  $2 array of field values, $3 empty, $4 Field pointer
		$k:=Size of array:C274($2->)  //aOrdRecNum)
		For ($i; 1; $k)
			QUERY:C277($1->; $4->=$2->{$i})  //searching unique field
			ADD TO SET:C119($1->; "Current")
		End for 
	: (Count parameters:C259=3)  //Pass $1 Table pointer and $2 array of record numbers, $3 an array of selected lines
		$k:=Size of array:C274($3->)  //aOrdRecNum)
		For ($i; 1; $k)
			GOTO RECORD:C242($1->; $2->{$3->{$i}})
			ADD TO SET:C119($1->; "Current")
		End for 
	Else 
		$k:=Size of array:C274($2->)  //Pass Table pointer and array of record numbers
		For ($i; 1; $k)
			GOTO RECORD:C242($1->; $2->{$i})
			ADD TO SET:C119($1->; "Current")
		End for 
End case 
USE SET:C118("Current")
CLEAR SET:C117("Current")
MESSAGES ON:C181