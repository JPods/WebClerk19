//%attributes = {"publishedWeb":true}
//Procedure: TIOI_IsStackPop
C_BOOLEAN:C305($0)  //true: No error
C_LONGINT:C283($1)  //the index that the pop value must be > to pop
$0:=False:C215
If (iTIOIsStkHd>1)  //are there any elems on the stack
	//pop elem off stack
	iTIOIsStkHd:=iTIOIsStkHd-1  //next elem availiable
	DELETE FROM ARRAY:C228(aTIOIsStack; iTIOIsStkHd)
	$0:=True:C214
End if 