//%attributes = {"publishedWeb":true}
//Procedure: TIOI_ExStackPsh
C_LONGINT:C283($1)  //Index of this Exit Loop
//push Exit Index to stack
INSERT IN ARRAY:C227(aTIOExStack; iTIOExStkHd)
aTIOExStack{iTIOExStkHd}:=$1
iTIOExStkHd:=iTIOExStkHd+1  //next elem availiable