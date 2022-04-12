$sizeRay:=Size of array:C274(aWoActivity)
jCenterWindow(440; 335; -724; "Steps")
DIALOG:C40([WOTemplate:69]; "diaAddWoSteps")
CLOSE WINDOW:C154
C_LONGINT:C283($i; $sizeRay)
C_TEXT:C284($codeSeq)
If ($sizeRay#Size of array:C274(aWoActivity))
	$sizeRay:=Size of array:C274(aWoActivity)
	For ($i; 1; $sizeRay)
		aWoSeq{$i}:=$i
		If (aWoNature{$i}#0)
			$codeSeq:=$codeSeq+String:C10(aWoNature{$i})+(","*Num:C11($i#$sizeRay))
		End if 
	End for 
	For ($i; 1; Size of array:C274(aWoSeq))
		aWoCodeSeq{$i}:=$codeSeq
	End for 
	WO_FillArrays(-15)
	C_LONGINT:C283(eOrdWos; ePPWos)
	Case of 
		: (eOrdWos>0)  //&(ptCurTable=(->[Order])))
			//  --  CHOPPED  AL_UpdateArrays(eOrdWos; -2)
		: (ePPWos>0)  //&(ptCurTable=(->[Proposal])))
			//  --  CHOPPED  AL_UpdateArrays(ePPWos; -2)
	End case 
	vMod:=True:C214
End if 
WO_FillStepRays(0)