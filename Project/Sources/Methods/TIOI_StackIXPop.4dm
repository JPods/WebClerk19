//%attributes = {"publishedWeb":true}
//Procedure: TIOI_StackIXPop
C_LONGINT:C283($0)  //return index of each Is List Exit Cmd
C_LONGINT:C283($1)  //the index that the pop value must be > to pop
$0:=-1
If (iTIOIXStkHd>1)  //is there any return elem on the stack
	If (aTIOIXStack{iTIOIXStkHd-1}>$1)
		//pop return index off stack
		iTIOIXStkHd:=iTIOIXStkHd-1  //next elem availiable
		$0:=aTIOIXStack{iTIOIXStkHd}
		DELETE FROM ARRAY:C228(aTIOIXStack; iTIOIXStkHd)
	End if 
End if 