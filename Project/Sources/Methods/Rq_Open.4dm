//%attributes = {"publishedWeb":true}

<>vLDocRec:=0
<>vLDocFile:=0
ARRAY LONGINT:C221(<>aItemLines; 0)
//Procedure: Test 
C_LONGINT:C283($found; $theProc)
$found:=Prs_CheckRunnin("Requisitions")
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
	$theProc:=<>aPrsNum{$found}
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("Rq_Window"; <>tcPrsMemory; "Requisitions")
	$theProc:=<>processAlt
End if 
POST OUTSIDE CALL:C329($theProc)