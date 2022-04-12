//%attributes = {"publishedWeb":true}
//Procedure: TIOI_StackIXPsh
C_LONGINT:C283($1)  //Index of this Is List Exit Cmd
//push Exit Index to stack
INSERT IN ARRAY:C227(aTIOIXStack; iTIOIXStkHd)
aTIOIXStack{iTIOIXStkHd}:=$1
iTIOIXStkHd:=iTIOIXStkHd+1  //next elem availiable