//%attributes = {"publishedWeb":true}
//Procedure: TIO_RStackPush
C_LONGINT:C283($1)  //Index where this loop begins
//push return index to stack
INSERT IN ARRAY:C227(aTIORStack; iTIORStkHd)
aTIORStack{iTIORStkHd}:=$1
iTIORStkHd:=iTIORStkHd+1  //next elem availiable