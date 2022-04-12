C_LONGINT:C283($i; $k; $w)
ARRAY LONGINT:C221($aOrdTest; 0)
CREATE EMPTY SET:C140([Order:3]; "Current")
If ([PO:39]orderNum:18#0)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[PO:39]orderNum:18)
	If (Records in selection:C76([Order:3])>0)
		INSERT IN ARRAY:C227($aOrdTest; 1; 1)
		$aOrdTest{1}:=[PO:39]orderNum:18
		ADD TO SET:C119([Order:3]; "Current")
	End if 
End if 
$k:=Size of array:C274(aPOLineAction)
For ($i; 1; $k)
	$w:=Find in array:C230($aOrdTest; aPOOrdRef{$i})
	If ($w=-1)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=aPOOrdRef{$i})
		If (Records in selection:C76([Order:3])>0)
			INSERT IN ARRAY:C227($aOrdTest; 1; 1)
			$aOrdTest{1}:=aPOOrdRef{$i}
			ADD TO SET:C119([Order:3]; "Current")
		End if 
	End if 
End for 
If (Records in set:C195("Current")>0)
	USE SET:C118("Current")
	DB_ShowCurrentSelection(->[Order:3]; ""; 1; "")
Else 
	BEEP:C151
	BEEP:C151
End if 
CLEAR SET:C117("Current")