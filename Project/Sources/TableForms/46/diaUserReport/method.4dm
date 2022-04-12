
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/07/17, 21:11:29
// ----------------------------------------------------
// Method: [UserReport].diaUserReport
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170707_2109 removed Associated Menu Bar caused multiple menus

Case of 
	: (Before:C29)
		C_LONGINT:C283($i; $k; $w; $error)
		//aFiles:=curFile
		//curTableNumAlt:=curFile
		OBJECT SET ENABLED:C1123(iLoInteger15; False:C215)
		If (vHere>0)
			Case of 
				: (ptCurTable=(->[Invoice:26]))
					OBJECT SET ENABLED:C1123(iLoInteger15; True:C214)
				: (ptCurTable=(->[Order:3]))
					OBJECT SET ENABLED:C1123(iLoInteger15; True:C214)
				: (ptCurTable=(->[Proposal:42]))
					OBJECT SET ENABLED:C1123(iLoInteger15; True:C214)
				: (ptCurTable=(->[PO:39]))
					OBJECT SET ENABLED:C1123(iLoInteger15; True:C214)
			End case 
		End if 
		$k:=Records in selection:C76([UserReport:46])
		initReportArray($k)
		If ($k>0)
			SELECTION TO ARRAY:C260([UserReport:46]; aRptRecs; [UserReport:46]creator:6; aRptCreator; [UserReport:46]name:2; aRptNames; [UserReport:46]when:8; aWhens; [UserReport:46]why:9; aWhys; [UserReport:46]isPrimary:15; aTmpBoo1; [UserReport:46]tableNum:3; aRptFiles; [UserReport:46]securityLevel:24; aRptAuthLevel)
			For ($i; 1; $k)
				aWhys{$i}:=(Num:C11(aTmpBoo1{$i})*"{{Primary}}")+aWhys{$i}  //zzzz d<s
			End for 
			//FIRST RECORD([UserReport])
			//For ($i;1;$k)
			//aWhens{$i}:=[UserReport]When
			//aWhys{$i}:=(Num([UserReport]Primary)*"")+[UserReport]Why
			//aRptNames{$i}:=[UserReport]Name
			//aRptCreator{$i}:=[UserReport]Creator
			//aRptRecs{$i}:=Record number([UserReport])
			//aRptFiles{$i}:=[UserReport]FileID
			//NEXT RECORD([UserReport])
			//End for
			ARRAY BOOLEAN:C223(aTmpBoo1; 0)
			UNLOAD RECORD:C212([UserReport:46])
		End if 
		If (vHere>0)
			// Modified by: Bill James (2017-10-12T00:00:00   // removed as no longer supported.
			// Prnt_InterForms (ptCurTable)
		End if 
		//
		// -- $error:=AL_SetArraysNam(eReportList; 1; 7; "aRptCreator"; "aRptNames"; "aWhens"; "aWhys"; "aRptFiles"; "aRptAuthLevel"; "aRptRecs")
		// -- AL_SetHeaders(eReportList; 1; 7; "Creator"; "Report Names"; "When"; "Why"; "File"; "Auth Lvl"; "Rec")
		//// -- AL_SetWidths (eReportList;1;7;28;133;94;170;20;45;30)
		// -- AL_SetWidths(eReportList; 1; 7; 48; 182; 159; 169; 32; 60; 80)
		// -- AL_SetRowOpts(eReportList; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eReportList; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eReportList; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eReportList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eReportList; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eReportList; 2)  //Name
		//name;colLock;clkResponse;AreaSelect;HideHead;PostKey;CopyHid;FldDelm;RecDelm
		// -- AL_SetHdrStyle(eReportList; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eReportList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eReportList; "Gray"; "Gray"; 0; ""; ""; 0)
		
		OBJECT SET ENABLED:C1123(b21; False:C215)
		OBJECT SET ENABLED:C1123(b22; True:C214)
		OBJECT SET ENABLED:C1123(bAcceptB; True:C214)
	Else 
		Case of 
			: (Size of array:C274(aRptLines)=0)
				OBJECT SET ENABLED:C1123(b21; False:C215)
				OBJECT SET ENABLED:C1123(bAcceptB; False:C215)
			: (aRptRecs{aRptLines{1}}<0)
				OBJECT SET ENABLED:C1123(b21; False:C215)
				OBJECT SET ENABLED:C1123(bAcceptB; True:C214)
			: (aRptRecs{aRptLines{1}}>=0)
				OBJECT SET ENABLED:C1123(b21; True:C214)
				OBJECT SET ENABLED:C1123(bAcceptB; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b21; False:C215)
				OBJECT SET ENABLED:C1123(bAcceptB; False:C215)
		End case 
End case 