C_LONGINT:C283($i; $k)
CONFIRM:C162("Post to shipping tags.")
If (OK=1)
	Ship_FillArray(0)
	$k:=Size of array:C274(aLiTagGroup)
	$i:=0
	ARRAY TEXT:C222($aTmpItem; 0)
	ARRAY REAL:C219($aTmpQty; 0)
	If ($k>0)
		$packNum:=aLiTagGroup{1}
		While ($i<$k)
			$i:=$i+1
			$w:=Find in array:C230(aiLineNum; aLiLineID{$i})
			If ($w>0)
				$lnValue:=aiUnitPriceDiscounted{$w}*aLiQty{$i}
			Else 
				$lnValue:=0
			End if 
			If ($packNum=aLiTagGroup{$i})
				$wItem:=Find in array:C230($aTmpItem; aLiItemNum{$i})
				If ($wItem>0)
					$aTmpQty{$wItem}:=$aTmpQty{$wItem}+aLiQty{$i}
				Else 
					INSERT IN ARRAY:C227($aTmpItem; 1; 1)
					INSERT IN ARRAY:C227($aTmpQty; 1; 1)
					$aTmpItem{1}:=aLiItemNum{$i}
					$aTmpQty{1}:=aLiQty{$i}
				End if 
				$theWt:=$theWt+(aLiUnitWt{$i}*aLiQty{$i})
				$doNewRec:=False:C215
				$theValue:=$theValue+$lnValue
			Else 
				If ($i>1)
					INSERT IN ARRAY:C227(aLongInt1; 1; 1)
					INSERT IN ARRAY:C227(a20Str1; 1; 1)
					INSERT IN ARRAY:C227(a20Str2; 1; 1)
					INSERT IN ARRAY:C227(a20Str3; 1; 1)
					INSERT IN ARRAY:C227(a20Str4; 1; 1)
					INSERT IN ARRAY:C227(aReal1; 1; 1)
					INSERT IN ARRAY:C227(aReal2; 1; 1)
					INSERT IN ARRAY:C227(aReal3; 1; 1)
					INSERT IN ARRAY:C227(atrackID; 1; 1)
					INSERT IN ARRAY:C227(aTrackTagID; 1; 1)
					INSERT IN ARRAY:C227(aTagContents; 1; 1)
					
					aLongInt1{1}:=$theWt
					aReal3{1}:=$theValue
					aTrackTagID{1}:=$packNum
					
					SORT ARRAY:C229($aTmpItem; $aTmpQty)
					$cntRay:=Size of array:C274($aTmpItem)
					TRACE:C157
					For ($incRay; 1; $cntRay)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$aTmpItem{$incRay})  //$aTmpItem{$incRay}
						aTagContents{1}:=aTagContents{1}+[Item:4]mfrItemNum:39+"="+String:C10($aTmpQty{$incRay})+("::"*(Num:C11($incRay<$cntRay)))
					End for 
				End if 
				ARRAY TEXT:C222($aTmpItem; 1)
				ARRAY REAL:C219($aTmpQty; 1)
				$aTmpItem{1}:=aLiItemNum{$i}
				$aTmpQty{1}:=aLiQty{$i}
				$packNum:=aLiTagGroup{$i}
				$theWt:=(aLiUnitWt{$i}*aLiQty{$i})
				$theValue:=$lnValue
			End if 
		End while 
		If (($i=$k) & ($k>0))
			INSERT IN ARRAY:C227(aLongInt1; 1; 1)
			INSERT IN ARRAY:C227(a20Str1; 1; 1)
			INSERT IN ARRAY:C227(a20Str2; 1; 1)
			INSERT IN ARRAY:C227(a20Str3; 1; 1)
			INSERT IN ARRAY:C227(a20Str4; 1; 1)
			INSERT IN ARRAY:C227(aReal1; 1; 1)
			INSERT IN ARRAY:C227(aReal2; 1; 1)
			INSERT IN ARRAY:C227(aReal3; 1; 1)
			INSERT IN ARRAY:C227(atrackID; 1; 1)
			INSERT IN ARRAY:C227(aTrackTagID; 1; 1)
			INSERT IN ARRAY:C227(aTagContents; 1; 1)
			aLongInt1{1}:=$theWt
			aReal3{1}:=$theValue
			aTrackTagID{1}:=$packNum
			SORT ARRAY:C229($aTmpItem; $aTmpQty)
			$cntRay:=Size of array:C274($aTmpItem)
			For ($incRay; 1; $cntRay)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=$aTmpItem{$incRay})  //$aTmpItem{$incRay}      
				aTagContents{1}:=aTagContents{1}+[Item:4]mfrItemNum:39+"="+String:C10($aTmpQty{$incRay})+("::"*(Num:C11($incRay<$cntRay)))
			End for 
		End if 
		ARRAY TEXT:C222($aTmpItem; 0)
		ARRAY REAL:C219($aTmpQty; 0)
	End if 
	//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
End if 