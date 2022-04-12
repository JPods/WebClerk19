//%attributes = {"publishedWeb":true}




LT_FillArrayLoadItems(-12)  //build list of items to ship
C_LONGINT:C283($i; $k; $packNum; $w; $packID; $wItem)
C_REAL:C285($theWt; $theValue; $lnValue)
LT_FillArrayLoadItems(-7)  //sort
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
				CREATE RECORD:C68([LoadTag:88])
				
				[LoadTag:88]customerID:23:=[Invoice:26]customerID:3
				[LoadTag:88]invoiceNum:19:=[Invoice:26]invoiceNum:2
				[LoadTag:88]orderNum:29:=[Invoice:26]orderNum:1
				[LoadTag:88]customerPO:37:=[Invoice:26]customerPO:29
				
				[LoadTag:88]weightExtended:2:=$theWt
				[LoadTag:88]weightPalletContainer:35:=[LoadTag:88]weightExtended:2
				[LoadTag:88]value:24:=$theValue
				[LoadTag:88]ideSuperior:27:=$packNum
				SORT ARRAY:C229($aTmpItem; $aTmpQty)
				$cntRay:=Size of array:C274($aTmpItem)
				TRACE:C157
				For ($incRay; 1; $cntRay)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$aTmpItem{$incRay})  //$aTmpItem{$incRay}
					[LoadTag:88]instructions:21:=[LoadTag:88]instructions:21+[Item:4]mfrItemNum:39+"="+String:C10($aTmpQty{$incRay})+("_"*(Num:C11($incRay<$cntRay)))+"\r"
				End for 
			End if 
			SAVE RECORD:C53([LoadTag:88])
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
		CREATE RECORD:C68([LoadTag:88])
		
		[LoadTag:88]customerID:23:=[Invoice:26]customerID:3
		[LoadTag:88]invoiceNum:19:=[Invoice:26]invoiceNum:2
		[LoadTag:88]orderNum:29:=[Invoice:26]orderNum:1
		[LoadTag:88]customerPO:37:=[Invoice:26]customerPO:29
		[LoadTag:88]weightExtended:2:=$theWt
		[LoadTag:88]weightPalletContainer:35:=[LoadTag:88]weightExtended:2
		[LoadTag:88]value:24:=$theValue
		[LoadTag:88]ideSuperior:27:=$packNum
		
		
		SORT ARRAY:C229($aTmpItem; $aTmpQty)
		$cntRay:=Size of array:C274($aTmpItem)
		For ($incRay; 1; $cntRay)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$aTmpItem{$incRay})  //$aTmpItem{$incRay}      
			[LoadTag:88]instructions:21:=[LoadTag:88]instructions:21+[Item:4]mfrItemNum:39+"="+String:C10($aTmpQty{$incRay})+("_"*(Num:C11($incRay<$cntRay)))+"\r"
		End for 
	End if 
	SAVE RECORD:C53([LoadTag:88])
	ARRAY TEXT:C222($aTmpItem; 0)
	ARRAY REAL:C219($aTmpQty; 0)
End if 
