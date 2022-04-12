//%attributes = {"publishedWeb":true}
//Procedure: AE_MacLaunch($theCrea;$myDocName)
If (False:C215)
	//02/10/03.prf
	//removed plugin S7P
	//TCStrong_prf_v144
	TCStrong_prf_v144_S7P
End if 
//ALERT("Method AE_MacLaunch disabled")
C_LONGINT:C283($isRunning; $err)
C_TEXT:C284($1; $2)  //$theCrea; $myDocName
//$isRunning:=IsRunning($1)
//$err:=Launch($1;$2)
//If ($err=0)
//If ($isRunning=1)
//$err:=AppToFront($1)
//End if 
//Else 
//ALERT("Error "+String($err))
//End if 
LAUNCH EXTERNAL PROCESS:C811($2)