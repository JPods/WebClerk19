//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKPackageContents
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

$cntOrdLines:=Size of array:C274(aOQtyPack)
If ((Size of array:C274(aLiItemNum)>0) & ($cntOrdLines>0))
	CONFIRM:C162("Abandon current effort and display this package?")
	$myOK:=OK
Else 
	$myOK:=2
End if 
If ($myOK>0)
	If ($myOK=1)  //must restore current values to order.
		C_LONGINT:C283($cntOrdLines; $incOrdLines)
		For ($incOrdLines; 1; $cntOrdLines)
			aOQtyBL{$incOrdLines}:=aOQtyBL{$incOrdLines}+aOQtyPack{$incOrdLines}
			aOQtyPack{$incOrdLines}:=0
		End for 
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
	End if 
	$k:=Size of array:C274(aShipSel)
	iLoReal9:=0
	For ($i; 1; $k)
		iLoReal9:=iLoReal9+aPKWeightExtended{aShipSel{$i}}
	End for 
	PKContentsBox
End if 