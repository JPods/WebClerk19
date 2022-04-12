C_LONGINT:C283($i; $incSr; $cntSr)
If (Size of array:C274(aRayLines)>0)
	KeyModifierCurrent
	If (OptKey=0)
		For ($i; 1; Size of array:C274(aRayLines))
			aiDiscnt{aRayLines{$i}}:=pDiscnt
			aiPricePt{aRayLines{$i}}:="*"
			IvcLnExtend(aRayLines{$i})
			If (aiSerialRc{aRayLines{$i}}#<>ciSRNotSerialized)
				QUERY:C277([ItemSerial:47]; [ItemSerial:47]SalesLnRefID:11=aiSerialRc{aiLineAction})
				READ WRITE:C146([ItemSerial:47])
				FIRST RECORD:C50([ItemSerial:47])
				$cntSr:=Records in selection:C76([ItemSerial:47])
				For ($incSr; 1; $cntSr)
					[ItemSerial:47]Price:26:=aiUnitPriceDiscounted{aRayLines{$i}}
					SAVE RECORD:C53([ItemSerial:47])
					NEXT RECORD:C51([ItemSerial:47])
				End for 
				READ ONLY:C145([ItemSerial:47])
			End if 
		End for 
	Else 
		CONFIRM:C162("Decrease(+)/Increase(-) base price by "+String:C10(pDiscnt; "###.0000")+"%.")
		If (OK=1)
			For ($i; 1; Size of array:C274(aRayLines))
				aiUnitPrice{aRayLines{$i}}:=DiscountApply(aiUnitPrice{aRayLines{$i}}; pDiscnt; <>tcDecimalUP)
				aiDiscnt{aRayLines{$i}}:=0
				aiPricePt{aRayLines{$i}}:="*"
				IvcLnExtend(aRayLines{$i})
				If (aiSerialRc{aRayLines{$i}}#<>ciSRNotSerialized)
					QUERY:C277([ItemSerial:47]; [ItemSerial:47]SalesLnRefID:11=aiSerialRc{aiLineAction})
					READ WRITE:C146([ItemSerial:47])
					FIRST RECORD:C50([ItemSerial:47])
					$cntSr:=Records in selection:C76([ItemSerial:47])
					For ($incSr; 1; $cntSr)
						[ItemSerial:47]Price:26:=aiUnitPriceDiscounted{aRayLines{$i}}
						SAVE RECORD:C53([ItemSerial:47])
						NEXT RECORD:C51([ItemSerial:47])
					End for 
					READ ONLY:C145([ItemSerial:47])
				End if 
			End for 
			pDiscnt:=0
		End if 
	End if 
	pPricePt:="*"
	vLineMod:=True:C214
End if 