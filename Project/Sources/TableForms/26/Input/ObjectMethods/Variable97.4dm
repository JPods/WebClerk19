If ((Size of array:C274(aiUnitPrice)>0) & (Size of array:C274(aRayLines)>0))
	C_LONGINT:C283($i; $k; $incSrl; $cntSrl)
	$k:=Size of array:C274(aRayLines)
	For ($i; 1; $k)
		aiUnitPrice{aRayLines{$i}}:=pUnitPrice
		If (aiSerialRc{aRayLines{$i}}#<>ciSRNotSerialized)  //aRayLines{$i}
			QUERY:C277([ItemSerial:47]; [ItemSerial:47]SalesLnRefID:11=aiSerialRc{aRayLines{$i}})
			READ WRITE:C146([ItemSerial:47])
			FIRST RECORD:C50([ItemSerial:47])
			$cntSrl:=Records in selection:C76([ItemSerial:47])
			For ($incSrl; 1; $cntSrl)
				[ItemSerial:47]Price:26:=Round:C94(DiscountApply(pUnitPrice; pDiscnt; 10); <>tcDecimalUP)
				SAVE RECORD:C53([ItemSerial:47])
				NEXT RECORD:C51([ItemSerial:47])
			End for 
			READ ONLY:C145([ItemSerial:47])
		End if 
		pPricePt:="*"
		aiPricePt{aRayLines{$i}}:="*"
		vLineMod:=True:C214
		If (Size of array:C274(aExLnNum)>0)
			Exch_dPriceCost(->[Invoice:26]exchangeRate:61; ->aiLineNum{aRayLines{$i}})
		End if 
	End for 
End if 