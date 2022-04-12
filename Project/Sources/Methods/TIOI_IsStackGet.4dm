//%attributes = {"publishedWeb":true}
//Procedure: TIOI_IsStackGet
C_LONGINT:C283($0)  //return index of each Exit Loop
C_LONGINT:C283($1)  //the index that the pop value must be > to pop
$0:=0  //return a valid Array element that won't hurt any thing
If (iTIOIsStkHd>1)  //is there any return elem on the stack
	If (aTIOIsStack{iTIOIsStkHd-1}>0)
		$0:=aTIOIsStack{iTIOIsStkHd-1}
	End if 
End if 