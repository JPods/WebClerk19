//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-01-10T00:00:00, 09:47:39
// ----------------------------------------------------
// Method: RelateOrdersFromPOs
// Description
// Modified: 01/10/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k; $w; $1; $orderNum)
ARRAY LONGINT:C221($aOrdTest; 0)
ARRAY LONGINT:C221(<>aLongInt1; 0)
If (Count parameters:C259=1)
	If ($1>10)
		APPEND TO ARRAY:C911($aOrdTest; $1)
	End if 
Else 
	If ([PO:39]orderNum:18#0)
		APPEND TO ARRAY:C911($aOrdTest; [PO:39]orderNum:18)
	End if 
	$k:=Size of array:C274(aPOLineAction)
	For ($i; 1; $k)
		If (aPOOrdRef{$i}>10)
			$w:=Find in array:C230($aOrdTest; aPOOrdRef{$i})
			If ($w<0)
				APPEND TO ARRAY:C911($aOrdTest; aPOOrdRef{$i})
			End if 
		End if 
	End for 
End if 
If (Size of array:C274($aOrdTest)>0)
	COPY ARRAY:C226($aOrdTest; <>aLongInt1)
	C_TEXT:C284($script)
	$script:="QUERY WITH ARRAY([Order]OrderNum;<>aLongInt1)"
	$script:=$script+"\r"+"ARRAY LONGINT(<>aLongInt1;0)"
	ProcessTableOpen(Table:C252(->[Order:3]); $script; "Orders for PO "+String:C10([PO:39]poNum:5))
Else 
	BEEP:C151
	BEEP:C151
End if 