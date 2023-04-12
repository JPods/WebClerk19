// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/10/09, 16:20:46
// ----------------------------------------------------
// Method: Form Method: TechNote
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($formEvent)
C_TEXT:C284($myURL; WebTech_URL)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: ($formEvent=On Deactivate:K2:10)
		
	: ($formEvent=On Load:K2:1)
		jsetBefore(->[Control:1])
		
		C_LONGINT:C283($error)
		C_LONGINT:C283($1; $2)
		//
		C_BOOLEAN:C305(<>vbDoQuit)
		<>aTechNoteNames:=1
		
		vtTNPathSystem:=""
		// redundant to iLo procedure for Web Area
		//
		ARRAY LONGINT:C221(aTNRecSel; 0)
		aTNRecSel:=0
		TN_LastVisitArray(0)  //
		
		
		doSearch:=0
		//
		OBJECT SET ENABLED:C1123(b3; True:C214)
		OBJECT SET ENABLED:C1123(b2; True:C214)
		//
		
		// ### bj ### 20191216_1915
		// loading from an outside call
		Case of 
			: (<>vTN_OutSide#"")  // if this variable is sent find associated technotes and load it
				// the techNote window is opening
				READ ONLY:C145([TechNote:58])
				ALL RECORDS:C47([TechNote:58])
				KeyWordByAlpha(Table:C252(->[TechNote:58]); <>vTN_OutSide)
				TechNotePopulateList
				<>vTN_OutSide:=""
				TNToWebAreaBody("WebArea")
				// do this in the web area
			Else   // fill in the table of contents as a default
				C_LONGINT:C283($myProgress)
				QUERY:C277([TechNote:58]; [TechNote:58]name:2="TableOfContents"; *)
				QUERY:C277([TechNote:58];  | ; [TechNote:58]subject:6="startup@")
				SELECTION TO ARRAY:C260([TechNote:58]name:2; aTNName; [TechNote:58]subject:6; aTNSub; [TechNote:58]; aTNRec; [TechNote:58]chapter:14; aTNChap; [TechNote:58]section:15; aTNSect)
				// MULTI SORT ARRAY(aTNChap;>;aTNSect;>;aTNName;aTNSub;aTNRec)
				SORT ARRAY:C229(aTNChap; aTNSect; aTNName; aTNSub; aTNRec)
				QUERY:C277([TechNote:58]; [TechNote:58]name:2="TableOfContents")
				FIRST RECORD:C50([TechNote:58])
				
				
				// when an outside call, fill in the webarea
				TNToWebAreaBody("WebArea")
				
				//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)
		End case 
		
		// TNToWebAreaTinymce 
		
		
	: ($formEvent=On Outside Call:K2:11)
		Case of 
			: (<>vTN_OutSide#"")  //call TN from anywhere for any keyword
				READ ONLY:C145([TechNote:58])
				ALL RECORDS:C47([TechNote:58])
				KeyWordByAlpha(Table:C252(->[TechNote:58]); <>vTN_OutSide)
				TechNotePopulateList
				TNToWebAreaBody("WebArea")
				
				<>vTN_OutSide:=""
			: (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
				Quit_Processes
			Else 
				FORM NEXT PAGE:C248
				FORM PREVIOUS PAGE:C249
				//vi3:=<>vlRecNum
				//viVert:=<>viSelectBeg
				<>viSelectBeg:=0
				<>vlRecNum:=0
				//**WR REDRAW (eTechNote)
				REDRAW:C174(srTNName)
				REDRAW:C174(srTNSubject)
				REDRAW:C174([TechNote:58]summary:3)
				REDRAW:C174([TechNote:58]docType:7)
				REDRAW:C174([TechNote:58]docReference:8)
				TNToWebAreaBody("WebArea")
		End case 
		//REDRAW([TechNote]Author)
		<>aTableNames:=Find in array:C230(<>aTableNums; [TechNote:58]tableNum:12)
		
	Else 
		If (doSearch>0)
			If (Records in selection:C76([TechNote:58])=0)
				ConsoleLog("No TechNote Records returned.")
			Else 
				TechNotePopulateList
				
				
				TNToWebAreaBody("WebArea")
				// TNToWebAreaTinymce 
				
				
				doSearch:=0
				//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)
				viHorz:=1
				viVert:=1
				// // -- AL_SetSelect (eTNList;aTNRecSel)
				// // -- AL_SetScroll (eTNList;viVert;viHorz)
			End if 
		End if 
End case 


If (False:C215)
	
	If (<>vTN_OutSide="")
		QUERY:C277([TechNote:58]; [TechNote:58]subject:6="Startup@")
		If (Records in selection:C76([TechNote:58])>0)
			TechNotePopulateList
			
			
			
			ARRAY LONGINT:C221(aTNRecSel; 0)
		Else 
			READ ONLY:C145([TechNote:58])
			ALL RECORDS:C47([TechNote:58])
			KeyWordByAlpha(Table:C252(->[TechNote:58]); <>vTN_OutSide)
			TechNotePopulateList
			//ARRAY LONGINT(aTNRecSel;1)
			//aTNRecSel{1}:=1
		End if 
	End if 
	
End if 