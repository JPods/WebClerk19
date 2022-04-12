If (Size of array:C274(aSrvLines)>0)
	Case of 
		: (aServiceTableName{aSrvLines{1}}="S")
			BEEP:C151
		: (aServiceTableName{aSrvLines{1}}="C")
			C_LONGINT:C283(vlCalc)
			QUERY:C277([TallyResult:73]; [TallyResult:73]tableNum:3=2; *)
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2=[Customer:2]customerID:1)
			//Case of 
			//: (Records in selection([TallyResult])=1)
			//SP AREA TO FIELD (<>vlCalc;Table(->[TallyResult]);Field(->
			//[TallyResult]PictBlk1))
			//SAVE RECORD([TallyResult])
			//: (Records in selection([TallyResult])=0)
			//CREATE RECORD([TallyResult])
			// 
			//[TallyResult]TableNum:=2
			//[TallyResult]Purpose:=[Customer]customerID
			//SP AREA TO FIELD (<>vlCalc;Table(->[TallyResult]);Field(->
			//[TallyResult]PictBlk1))
			//SAVE RECORD([TallyResult])
			//End case 
		: (aServiceTableName{aSrvLines{1}}="ct")
			GOTO RECORD:C242([Contact:13]; aServiceRecs{aSrvLines{1}})
		: (aServiceTableName{aSrvLines{1}}="L")
			GOTO RECORD:C242([Lead:48]; aServiceRecs{aSrvLines{1}})
		: (aServiceTableName{aSrvLines{1}}="Pp")
			BEEP:C151
		: (aServiceTableName{aSrvLines{1}}="Po")
			BEEP:C151
		: (aServiceTableName{aSrvLines{1}}="Wo")
			BEEP:C151
		: (aServiceTableName{aSrvLines{1}}="Or")
			BEEP:C151
	End case 
End if 