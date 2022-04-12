If (False:C215)
	//Date: 03/14/02
	//Who: Dan Bentson, Arkware
	//Description: Added base quantity, tally
	VERSION_960
End if 

FC_FillRay(-8)  // sort arrays

C_LONGINT:C283($k; $i; $overWriter; $steppee; $lastMark)
C_DATE:C307($cutDate)
$cutDate:=Date:C102(Request:C163("Consolidate need as of this date:"; String:C10(Current date:C33+30)))
If ((OK=1) & ($cutDate>=Current date:C33))
	$i:=1
	$k:=Size of array:C274(aFCRecNum)
	$viProgressID:=Progress New
	$steppee:=1
	$lastMark:=1
	TRACE:C157
	While ($i<$k)
		// ### jwm ### 20180718_1018
		ProgressUpdate($viProgressID; $i; $k; "Processing:")
		$i:=$i+1
		If ((aFCItem{$lastMark}#aFCItem{$i}) | (aFCActionDt{$i}>=$cutDate))
			$lastMark:=$i
			$overWriter:=$i-1
			If ($overWriter#$steppee)
				aFCItem{$steppee}:=aFCItem{$overWriter}
				aFCBomCnt{$steppee}:=aFCBomCnt{$overWriter}
				aFCActionDt{$steppee}:=aFCActionDt{$overWriter}
				aFCBomLevel{$steppee}:=""
				aFCParent{$steppee}:=""
				aFCTypeTran{$steppee}:="Ed"
				aFCDocID{$steppee}:=0
				aFCDesc{$steppee}:=aFCDesc{$overWriter}
				aFCRunQty{$steppee}:=aFCRunQty{$overWriter}
				aFCWho{$steppee}:=aFCWho{$overWriter}
				aFCRecNum{$steppee}:=-1
				aFCTallyYTD{$steppee}:=aFCTallyYTD{$overWriter}
				aFCTallyLess1Year{$steppee}:=aFCTallyLess1Year{$overWriter}
				aFCTallyLess2Year{$steppee}:=aFCTallyLess2Year{$overWriter}
				aFCBaseQty{$steppee}:=aFCBaseQty{$overWriter}
			End if 
			$steppee:=$steppee+1
			If (($i<$k) & (aFCItem{$overWriter}=aFCItem{$i}))
				$i:=$i+1
				While ((aFCItem{$overWriter}=aFCItem{$i}) & ($i<$k))
					$i:=$i+1
				End while 
				$lastMark:=$i
			End if 
		End if 
	End while 
	// ### jwm ### 20180718_1521
	Progress QUIT($viProgressID)
	
	$overWriter:=$k
	aFCItem{$steppee}:=aFCItem{$overWriter}
	aFCBomCnt{$steppee}:=aFCBomCnt{$overWriter}
	aFCActionDt{$steppee}:=aFCActionDt{$overWriter}
	aFCBomLevel{$steppee}:=""
	aFCParent{$steppee}:=""
	aFCTypeTran{$steppee}:="Ed"
	aFCDocID{$steppee}:=0
	aFCDesc{$steppee}:=aFCDesc{$overWriter}
	aFCRunQty{$steppee}:=aFCRunQty{$overWriter}
	aFCWho{$steppee}:=aFCWho{$overWriter}
	aFCRecNum{$steppee}:=-1
	
	If (False:C215)
		//Arrays displayed in area list
		//$error:=// -- AL_SetArraysNam (eForeCast;1;8;"aFCItem";"aFCDesc";"aFCActionDt";"aFCBomCnt";"aFCRunQty";"aFCBaseQty";"aFCTallyYTD";"aFCTallyLess1Year")
		//$error:=// -- AL_SetArraysNam (eForeCast;9;8;"aFCTallyLess2Year";"aFCBomLevel";"aFCParent";"aFCTypeTran";"aFCDocID";"aFCWho";"aFCtypeID";"aFCRecNum")
		
	End if 
	
	
	FC_FillRay($steppee)
	
	FC_CalcUsage
	
	If (Size of array:C274(aFCItem)<=<>alpArrayMax)
		//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
	Else 
		ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
	End if 
	viRecordsInSelection:=Size of array:C274(aFCItem)
End if 