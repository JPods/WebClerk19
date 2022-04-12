//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-06T00:00:00, 15:38:41
// ----------------------------------------------------
// Method: POLineDelete
// Description
// Modified: 10/06/16
// 
// 
//
// Parameters
// ----------------------------------------------------



C_BOOLEAN:C305(dummy)
If (aPOLineAction>0)  //is there an item selected    
	For ($i; Size of array:C274(aRayLines); 1; -1)
		If (aPoUniqueID{aRayLines{$i}}>-1)
			APPEND TO ARRAY:C911(aPoDelete; aPoUniqueID{aRayLines{$i}})
		End if 
		If (<>vbDoSrlNums)
			Srl_DelPOLine(aRayLines{$i})  //Srl_DelPOLine (aPOLineAction)
		End if 
		POLn_RaySize(-1; aRayLines{$i}; 1)  //aiLineAction;1)//
	End for 
	ARRAY LONGINT:C221(aRayLines; 0)
	
	//  POLn_RaySize (-1;aPOLineAction;1)
	curLines:=Size of array:C274(aPOLineAction)
	aPOLineAction:=Ray_ReturnElem(->aPOLineAction)  //jump to line 1 after a delete
	PoLnFillVar(aPOLineAction)
	vLineMod:=True:C214
	ItemSetButtons((Size of array:C274(aPOLineAction)>0); True:C214)  //activate item control buttons
	vMod:=True:C214
	//  --  CHOPPED  AL_UpdateArrays(ePOList; -2)
	
End if 
HIGHLIGHT TEXT:C210(pPartNum; 1; 255)