C_LONGINT:C283($i; $k; $w)
<>vLDocRec:=-1
<>vLDocFile:=(Table:C252(->[Item:4]))
$k:=Size of array:C274(aFCSelect)
ARRAY LONGINT:C221(<>aItemLines; 0)
ARRAY TEXT:C222($itemRay; 0)
For ($i; 1; $k)
	$w:=Find in array:C230($itemRay; aFCItem{aFCSelect{$i}})
	If ($w=-1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aFCItem{aFCSelect{$i}})
		INSERT IN ARRAY:C227($itemRay; 1; 1)
		$itemRay{1}:=aFCItem{aFCSelect{$i}}
		If (Record number:C243([Item:4])>-1)
			INSERT IN ARRAY:C227(<>aItemLines; 1; 1)
			<>aItemLines{1}:=Record number:C243([Item:4])
		End if 
	End if 
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