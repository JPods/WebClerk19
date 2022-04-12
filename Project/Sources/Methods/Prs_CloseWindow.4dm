//%attributes = {"publishedWeb":true}
//Method: Prs_CloseWindow
C_LONGINT:C283($found; <>vlQuitOne)
$found:=Prs_CheckRunnin("Processes")
If ($found>0)
	<>vlQuitOne:=$found
	POST OUTSIDE CALL:C329(<>vlQuitOne)
End if 