C_LONGINT:C283(<>vLDocRec; $i; $k; <>vLDocFile; bRq)
myCycle:=8
TRACE:C157
vMod:=True:C214
jAcceptButton(False:C215; False:C215)
//
<>vLDocRec:=Record number:C243(ptCurTable->)
<>vLDocFile:=Table:C252(ptCurTable)
$k:=Size of array:C274(aPPLnSelect)
ARRAY LONGINT:C221(<>aItemLnRec; $k)
TRACE:C157
For ($i; 1; $k)
	<>aItemLnRec{$i}:=aPLineAction{aPPLnSelect{$i}}
End for 
//Procedure: Test 
C_LONGINT:C283($found; $theProc)
$found:=Prs_CheckRunnin("Requisitions")
If ($found>0)
	BRING TO FRONT:C326($found)
	$theProc:=<>aPrsNum{$found}
Else 
	<>ptCurTable:=ptCurTable
	<>prcControl:=1
	<>processAlt:=New process:C317("Rq_Window"; <>tcPrsMemory; "Requisitions")
	$theProc:=<>processAlt
End if 
POST OUTSIDE CALL:C329($theProc)