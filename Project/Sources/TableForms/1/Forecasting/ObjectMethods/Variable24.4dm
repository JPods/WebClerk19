C_LONGINT:C283($i; $cutPeriod)
C_DATE:C307($theCutDate)
KeyModifierCurrent
TRACE:C157
Case of 
	: (optKey=1)
		$cutPeriod:=7
		$thePeriod:="Weekly"
	: (cmdKey=1)
		$cutPeriod:=90
		$thePeriod:="Quarterly"
	Else 
		$cutPeriod:=30
		$thePeriod:="Monthly"
End case 
CONFIRM:C162("Project cash flow based on periods of "+String:C10($cutPeriod)+" days.")
If ((OK=1) & ($cutPeriod>0) & (Size of array:C274(aFCItem)>0))
	aFCRunQty{0}:=aFCRunQty{1}
	$i:=0
	$endLoop:=2
	Repeat 
		//If ($ENDLOOP=2)
		$i:=$i+1
		$baseDate:=aFCActionDt{$i}
		// Else 
		// $baseDate:=aFCActionDt{$i}+1
		// End if 
		$endLoop:=2
		Case of 
			: ($cutPeriod=7)
				$theCutDate:=Date_ThisWeek($baseDate; 1)
			: ($cutPeriod=90)
				$theCutDate:=Date_ThisQtr($baseDate; 1)
			Else   //30
				$theCutDate:=Date_ThisMon($baseDate; 1)
		End case 
		FC_FillRay(-3; $i; 1)
		aFCItem{$i}:=$thePeriod
		aFCBomCnt{$i}:=0
		aFCActionDt{$i}:=$theCutDate
		aFCBomLevel{$i}:=""
		aFCParent{$i}:=""
		aFCTypeTran{$i}:="Sm"
		aFCDocID{$i}:=0
		aFCDesc{$i}:=""
		aFCRunQty{$i}:=aFCRunQty{$i-1}
		aFCWho{$i}:=""
		aFCRecNum{$i}:=-1
		// If ($ENDLOOP=2)
		$munch:=$i+1
		// End if 
		Case of 
			: ($munch>Size of array:C274(aFCRecNum))
				$endLoop:=0  //drop out of all
			: (aFCActionDt{$munch}>$theCutDate)
				$endLoop:=1  //drop to new end date
			Else 
				Repeat 
					aFCBomCnt{$i}:=aFCBomCnt{$i}+aFCBomCnt{$munch}
					aFCRunQty{$i}:=aFCRunQty{$i}+aFCBomCnt{$munch}
					FC_FillRay(-1; $munch; 1)
					Case of 
						: ($i=Size of array:C274(aFCRecNum))
							$endloop:=0  //drop out of all
						: (aFCActionDt{$munch}>$theCutDate)
							$endLoop:=1  //drop to new end date              
					End case 
				Until ($endLoop<2)
		End case 
	Until ($endLoop=0)
	If (Size of array:C274(aFCItem)<=<>alpArrayMax)
		//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
	Else 
		doSearch:=0
		ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
	End if 
	viRecordsInSelection:=Size of array:C274(aFCItem)
End if 