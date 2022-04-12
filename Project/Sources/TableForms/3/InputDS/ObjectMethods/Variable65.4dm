C_LONGINT:C283(<>vLDocRec; $i; $k; <>vLDocFile)
myCycle:=8
jAcceptButton(False:C215; False:C215)
//
<>vLDocRec:=Record number:C243(ptCurTable->)
<>vLDocFile:=Table:C252(ptCurTable)
$k:=Size of array:C274(aRayLines)
ARRAY LONGINT:C221(<>aItemLines; $k)
For ($i; 1; $k)
	<>aItemLines{$i}:=aOLineNum{aRayLines{$i}}
End for 
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