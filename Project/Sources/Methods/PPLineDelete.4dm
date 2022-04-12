//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-06T00:00:00, 15:34:47
// ----------------------------------------------------
// Method: PPLineDelete
// Description
// Modified: 10/06/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305(dummy)
C_LONGINT:C283($k)
$k:=Size of array:C274(aPPLnSelect)
If ($k>0)  //is there an item selected    
	For ($i; $k; 1; -1)
		If (aPUniqueID{aPPLnSelect{$i}}>-1)
			APPEND TO ARRAY:C911(aPpDeleteLines; aPUniqueID{aPPLnSelect{$i}})
		End if 
		PpLn_RaySize(-1; aPPLnSelect{$i}; 1)  //aiLineAction;1)//
	End for 
	ARRAY LONGINT:C221(aPPLnSelect; 0)
	//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
	If (Size of array:C274(aPUniqueID)>0)
		aPLineAction:=1
	Else 
		aPLineAction:=0
	End if 
	Ln_FillVar(aPLineAction; ->aPItemNum; ->aPDescpt; Num:C11(aPUse{aPLineAction}#""); aPQtyOrder{aPLineAction}; 0; aPUnitPrice{aPLineAction}; aPDiscnt{aPLineAction}; aPExtPrice{aPLineAction}; aPPricePt{aPLineAction})
	vLineMod:=True:C214
	ItemSetButtons((Size of array:C274(aPLineAction)>0); True:C214)  //activate item control buttons
	vMod:=True:C214
End if 
HIGHLIGHT TEXT:C210(pPartNum; 1; 255)