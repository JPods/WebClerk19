C_LONGINT:C283(<>processAlt; $i; $k; $w)
C_POINTER:C301(<>ptCurTable)
ARRAY TEXT:C222(<>aPartNum; 0)
ARRAY REAL:C219(<>aReal1; 0)
$i:=0
$k:=Size of array:C274(aFCSelect)
READ ONLY:C145([Item:4])
If (($k>0) & (Size of array:C274(aFCItem)>0))
	CREATE EMPTY SET:C140([Item:4]; "<>curSelSet")
	For ($i; 1; $k)
		$w:=Find in array:C230(<>aPartNum; aFCItem{aFCSelect{$i}})
		If ($w=-1)
			INSERT IN ARRAY:C227(<>aPartNum; 1; 1)
			INSERT IN ARRAY:C227(<>aReal1; 1; 1)
			<>aPartNum{1}:=aFCItem{aFCSelect{$i}}
			<>aReal1{1}:=aFCRunQty{aFCSelect{$i}}
			QUERY:C277([Item:4]; [Item:4]itemNum:1=<>aPartNum{1})
			ADD TO SET:C119([Item:4]; "<>curSelSet")
		End if 
	End for 
	READ WRITE:C146([Item:4])
	<>ptCurTable:=(->[Control:1])
	<>prcControl:=1  //needed to trip new process variables & window
	<>processAlt:=New process:C317("IVT_VndLowItems"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+"Low Items")
	Prs_ListActive
Else 
	BEEP:C151
End if 