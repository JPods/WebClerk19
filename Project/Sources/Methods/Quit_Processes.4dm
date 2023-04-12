//%attributes = {"publishedWeb":true}
//Procedure: Quit_Processes
If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Base:1])
End if 
If (booAccept)
	jAcceptButton(True:C214; False:C215)
End if 
//If (vHere<=0)   //should we try this???
//vHere:=5
//End if 
If (vHere>0)
	C_LONGINT:C283($i; $k)
	$k:=vHere
	For ($i; 1; $k)
		POST KEY:C465(Character code:C91("."); 256)
	End for 
	jsplashCancel
	mySpecCan:=True:C214
End if 
