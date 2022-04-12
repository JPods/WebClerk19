//%attributes = {"publishedWeb":true}
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aWsActive; 0)
		ARRAY TEXT:C222(aWsDescpt; 0)
		ARRAY REAL:C219(aWsRate; 0)
		ARRAY REAL:C219(aWsDura; 0)
		ARRAY LONGINT:C221(aWsNature; 0)
		ARRAY TEXT:C222(aWsBillTp; 0)
		ARRAY TEXT:C222(aWsWho; 0)
		ARRAY LONGINT:C221(aWsRecNum; 0)
		ARRAY LONGINT:C221(aWsSeq; 0)
		ARRAY LONGINT:C221(aWsPublish; 0)
		ARRAY LONGINT:C221(aWsUniqueID; 0)
		//
		ARRAY LONGINT:C221(aWoStepLns; 0)
	: ($1>0)
		KeyModifierCurrent
		SELECTION TO ARRAY:C260([WOTemplate:69]idNum:13; aWsUniqueID; [WOTemplate:69]; aWsRecNum; [WOTemplate:69]activity:2; aWsActive; [WOTemplate:69]description:3; aWsDescpt; [WOTemplate:69]actionBy:10; aWsWho; [WOTemplate:69]rate:5; aWsRate; [WOTemplate:69]duration:6; aWsDura; [WOTemplate:69]codeID:7; aWsNature; [WOTemplate:69]billingType:8; aWsBillTp; [WOTemplate:69]seq:11; aWsSeq; [WOTemplate:69]publish:12; aWsPublish)
		$doTest:=False:C215
		If ((vi1<=Get last table number:C254) & (vi1>0))
			If ((vi2<Get last field number:C255(vi1)) & (vi2>0))
				$k:=Size of array:C274(aWsRecNum)
				For ($i; 1; $k)
					aWsActive{$i}:=Field:C253(vi1; vi2)->
				End for 
			Else 
				$doTest:=True:C214
			End if 
		Else 
			$doTest:=True:C214
		End if 
		If (($doTest) & (v1#""))
			C_LONGINT:C283($i; $k)
			$k:=Size of array:C274(aWsRecNum)
			For ($i; 1; $k)
				aWsActive{$i}:=v1
			End for 
		End if 
		SORT ARRAY:C229(aWsSeq; aWsRecNum; aWsWho; aWsBillTp; aWsNature; aWsDura; aWsRate; aWsDescpt; aWsActive; aWsPublish; aWsUniqueID)
	: ($1=-5)  //rray to selection
	: ($1=-3)  //new line
	: ($1=-6)  //sort array   
		SORT ARRAY:C229(aWsSeq; aWsRecNum; aWsWho; aWsBillTp; aWsNature; aWsDura; aWsRate; aWsDescpt; aWsActive; aWsPublish; aWsUniqueID)
End case 