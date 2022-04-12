//array TEXT(<>aWoTypes;0)
If (<>aWoTypes>1)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85)
	If (Records in selection:C76([WorkOrder:66])=0)
		[Order:3]workOrderClass:110:=<>aWoTypes{<>aWoTypes}
		QUERY:C277([WOTemplate:69]; [WOTemplate:69]typeWO:9=<>aWoTypes{<>aWoTypes})
		WO_FillStepRays(Records in selection:C76([WOTemplate:69]))
		$k:=Size of array:C274(aWsRecNum)
		If ($k>0)
			ARRAY LONGINT:C221(aWoStepLns; $k)
			For ($i; 1; $k)
				aWoStepLns{$i}:=$i
			End for 
			WO_BuildFromTemplate
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
				//  --  CHOPPED  AL_UpdateArrays(eOrdWos; -2)
				vMod:=True:C214
			End if 
			WO_FillStepRays(0)
		End if 
	Else 
		ALERT:C41("There are existing workorders.")
	End if 
End if 
<>aWoTypes:=1