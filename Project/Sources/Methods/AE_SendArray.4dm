//%attributes = {"publishedWeb":true}
//Err:=AE_SendArray(target;object;data)
If (False:C215)
	//02/10/03.prf
	//removed plugin S7P
	//TCStrong_prf_v144
	TCStrong_prf_v144_S7P
End if 

//C_LONGINT($err;$aevt;$reply;$x)
//$err:=0
//$aevt:=0
//$reply:=0
//$x:=0
//$err:=CreateAEVT ("core";"setd";$1;$aevt)
//If ($err=0)
//$err:=PutObject ($aevt;"----";$2)
//If ($err=0)
//$err:=PutList ($aevt;"data";"";$3->)
//If ($err=0)
//$err:=SendAppleEvent ($aevt;$reply;kAEWaitReply +CanInteract ;-1)
//$x:=DisposeDesc ($reply)
//End if 
//End if 
//$x:=DisposeDesc ($aevt)
//Else 
//$x:=DisposeDesc ($2)
//End if 
//$0:=$err