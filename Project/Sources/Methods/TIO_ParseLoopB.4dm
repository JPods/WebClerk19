//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a Variable/Field/Constant that controls loop iterations
C_POINTER:C301($1)  //pointer to Info from a Loop Begin Row of a TextOut Doc
C_LONGINT:C283($2)  //Index where this loop begins
$0:=TIO_ParseNumber($1)
If (Not:C34(Is nil pointer:C315($0)))
	TIO_RStackPush($2)
End if 