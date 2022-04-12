//%attributes = {"publishedWeb":true}
C_LONGINT:C283($0)  //return index from this end loop
$0:=-1
If (iTIORStkHd>1)  //is there any return elem on the stack
	//pop return index off stack
	iTIORStkHd:=iTIORStkHd-1  //next elem availiable
	$0:=aTIORStack{iTIORStkHd}
	DELETE FROM ARRAY:C228(aTIORStack; iTIORStkHd)
End if 