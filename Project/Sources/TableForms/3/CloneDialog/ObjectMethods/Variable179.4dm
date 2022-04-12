If (<>aOrdersProfile2>1)
	ARRAY LONGINT:C221($aLineCount; 0)
	ARRAY REAL:C219($aAmount; 0)
	Case of 
		: (ptCurTable=(->[Order:3]))
			PUSH RECORD:C176([Order:3])
			QUERY:C277([Order:3]; [Order:3]salesNameID:10="CloneAllowed"; *)
			QUERY:C277([Order:3];  & ; [Order:3]profile2:62=<>aOrdersProfile2{<>aOrdersProfile2})
			SELECTION TO ARRAY:C260([Order:3]idNum:2; aTmpLong1; [Order:3]status:59; aTmp20Str1; [Order:3]comment:33; aTmpText1; [Order:3]lineCount:35; $aLineCount; [Order:3]amount:24; $aAmount)
			REDUCE SELECTION:C351([Order:3]; 0)
			POP RECORD:C177([Order:3])
		: (ptCurTable=(->[Proposal:42]))
			PUSH RECORD:C176([Proposal:42])
			QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed"; *)
			QUERY:C277([Proposal:42];  & ; [Proposal:42]profile2:52=<>aOrdersProfile2{<>aOrdersProfile2})
			SELECTION TO ARRAY:C260([Proposal:42]idNum:5; aTmpLong1; [Proposal:42]status:2; aTmp20Str1; [Proposal:42]comment:36; aTmpText1; [Proposal:42]lineCount:48; $aLineCount; [Proposal:42]amount:26; $aAmount)
			SORT ARRAY:C229(aTmp20Str1; aTmpLong1; aTmpText1)
			REDUCE SELECTION:C351([Proposal:42]; 0)
			POP RECORD:C177([Proposal:42])
	End case 
	
	C_LONGINT:C283($inc; $cnt)
	$cnt:=Size of array:C274(aTmp20Str1)
	For ($inc; 1; $cnt)
		//<>aClonePpComment{$inc}:="lc: "+String($aLineCount{$inc})+"  "+"\r"+"$: "+String($aAmount{$inc})+"  "+"\r"+<>aClonePpComment{$inc}
		aTmpText1{$inc}:="$: "+String:C10($aAmount{$inc})+"  "+"\r"+aTmpText1{$inc}
	End for 
	SORT ARRAY:C229(aTmp20Str1; aTmpLong1; aTmpText1)
	//  --  CHOPPED  AL_UpdateArrays(eCloneList; -2)
End if 

