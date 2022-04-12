C_LONGINT:C283($RecLine)
Case of 
	: (Before:C29)
		b21:=1
		vdDateBeg:=Date_ThisMon(Current date:C33; 0)
		vdDateEnd:=vdDateBeg+6
		vStdHrWk:=40
		vOTMultiple:=1.5
		viRecordsInSelection:=0
		vTimeTotal:=0
		vPayTotal:=0
		OBJECT SET ENABLED:C1123(bCancelB; False:C215)
		C_LONGINT:C283(eTimeCrdCal)
		C_DATE:C307(clickDate)
		//   CHOPPED CS_SetRange(eTimeCrdCal; vdDateBeg; !00-00-00!)
		//defaults to the current if Set Range is not called
		//   CHOPPED  CS_Options(eTimeCrdCal; 1; 1; 2; 1)
		//ARRAY DATE(aCalActDts;0)
		//array TEXT(aCalActs;0)
		//array TEXT(aFonts;0)
		//array TEXT(aStyles;0)
		//array TEXT(aColors;0)
		//array TEXT(aSizes;0)
		//CS_SetArray (eTimeCrdCal;"aCalActDts";"aCalActs";"aFonts";"aSizes";
		//"aStyles";"aColors")
		//CS_SetArray (eTimeCrdCal;"";"";"";"";"";"")
		doSearch:=0
		TC_FillArrays(0)
		//
		TC_ALDefine(eTimeList; 1)
		//
		QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6=!00-00-00!; *)
		QUERY:C277([Order:3];  | [Order:3]dateInvoiceComp:6=!1901-01-01!)
		SELECTION TO ARRAY:C260([Order:3]idNum:2; <>aActiveWOs)
		REDUCE SELECTION:C351([Order:3]; 0)
		ARRAY LONGINT:C221(aTCSelLns; 0)
	Else 
		
		If (doSearch>0)
			Case of 
				: (doSearch=1)
					//  --  CHOPPED  AL_UpdateArrays(eTimeList; -2)
				: (doSearch=3)  //change rates or rate factor        
				: (doSearch=5)  //add record to list
					//  CHOPPED  AL_GetScroll(eTimeList; viVert; viHorz)
					//  --  CHOPPED  AL_UpdateArrays(eTimeList; -2)
					// -- AL_SetSelect(eTimeList; aTCSelLns)
					// -- AL_SetScroll(eTimeList; viVert; viHorz)
					TC_SetReviewCal
				: (doSearch=6)  //new selection
					viRecordsInSelection:=Size of array:C274(aTCTimeRecs)
					C_LONGINT:C283($error)
					//  CHOPPED  $error:=AL_GetSelect(eTimeList; aTCSelLns)
					//  CHOPPED  AL_GetScroll(eTimeList; viVert; viHorz)
					//  --  CHOPPED  AL_UpdateArrays(eTimeList; -2)
					// -- AL_SetSelect(eTimeList; aTCSelLns)
					// -- AL_SetScroll(eTimeList; viVert; viHorz)
					TC_SetReviewCal
			End case 
			doSearch:=0
		End if 
End case 