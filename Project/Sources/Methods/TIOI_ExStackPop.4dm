//%attributes = {"publishedWeb":true}
//Procedure: TIOI_ExStackPop
C_LONGINT:C283($0)  //return index of each Exit Loop
C_LONGINT:C283($1)  //the index that the pop value must be > to pop
$0:=-1
If (iTIOExStkHd>1)  //is there any return elem on the stack
	If (aTIOExStack{iTIOExStkHd-1}>$1)
		//pop return index off stack
		iTIOExStkHd:=iTIOExStkHd-1  //next elem availiable
		$0:=aTIOExStack{iTIOExStkHd}
		DELETE FROM ARRAY:C228(aTIOExStack; iTIOExStkHd)
	End if 
End if 