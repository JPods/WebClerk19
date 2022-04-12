//%attributes = {"publishedWeb":true}
//Procedure: TIOI_IsStackSet
C_BOOLEAN:C305($0)  //true: No error
C_LONGINT:C283($1)  //index of last Is command
$0:=False:C215
If (iTIOIsStkHd>1)  //is there any return elem on the stack
	aTIOIsStack{iTIOIsStkHd-1}:=$1
	$0:=True:C214
End if 