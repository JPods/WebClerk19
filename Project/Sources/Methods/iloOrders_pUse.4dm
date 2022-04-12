//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-05T00:00:00, 14:52:31
// ----------------------------------------------------
// Method: iloOrders_pUse
// Description
// Modified: 01/05/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(pUse; $i; $k; $selectedElement)
$k:=Size of array:C274(aRayLines)
For ($i; 1; $k)
	$selectedElement:=aRayLines{$i}
	If (aoLineAction{$selectedElement}#-3)  // set line to recalc
		aoLineAction{$selectedElement}:=-3000  // set line to recalc
	End if 
	Case of 
		: (True:C214)  //  skip other choices managed in OrdLnExtend 
		: ((pUse=1) & (aOLnCmplt{$selectedElement}=""))
			// these are aligned
		: ((pUse=0) & (aOLnCmplt{$selectedElement}#""))
			// these are aligned
		: ((pUse=0) & (aOLnCmplt{$selectedElement}#""))
			// checkbox showing USE but the line showing NOT USED
			aOQtyBL{$1}:=aOQtyOrder{$1}-aOQtyShip{$1}
			aOQtyCanceled{$1}:=0
			aOLnCmplt{$1}:=""
		: ((pUse=1) & (aOLnCmplt{$selectedElement}=""))
			// checkbox showing NOT USED but the line showing USED
			aOQtyCanceled{$1}:=aOQtyBL{$1}
			aOLnCmplt{$1}:="x"
	End case 
	
	aOLnCmplt{$selectedElement}:="x"*(Num:C11(pUse=1))
	
	
	If ($i<=$k)  //do skip this in case the order is mis matched to the line selected
		OrdLnExtend($selectedElement)
	End if 
End for 
aoLineAction:=aRayLines{$k}
vLineMod:=True:C214  // must be set to have arealist update