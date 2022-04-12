//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 11/17/13, 23:15:12
// ----------------------------------------------------
// Method: jRptUserDefined
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20140827_1536 
// Named selections preserve in memory the order of the selection and the current record of the selection.
// ### jwm ### 20170707_2109 removed Associated Menu Bar caused multiple menus

//Procedure: jRptUserDefined
//READ ONLY([UserReport])
C_LONGINT:C283(rptRecNum; $tempHere; $i; $k; $curTableNum)
C_POINTER:C301($tempFile; $changeFile; $ptThisFile)
C_BOOLEAN:C305($doReport; doCurFile; $stopLoop; $resetMenu)
MESSAGES OFF:C175
$resetMenu:=False:C215
$doReport:=True:C214
$ptThisFile:=ptCurTable

C_LONGINT:C283($AuthLevel)

$AuthLevel:=Storage:C1525.user.securityLevel
C_BOOLEAN:C305($findUserReports; $doReport)
$doReport:=True:C214
$findUserReports:=True:C214
Case of 
	: (vHere=0)  //from the splash screen
		// ### jwm ### 20190516_0820 updated query to include "ALL"
		QUERY:C277([UserReport:46]; [UserReport:46]automatic:13=True:C214; *)
		QUERY:C277([UserReport:46];  | ; [UserReport:46]allTables:16=True:C214; *)
		QUERY:C277([UserReport:46];  & ; [UserReport:46]securityLevel:24<=Storage:C1525.user.securityLevel)
		$findUserReports:=False:C215
	: (vHere>1)  // check if the current record can be saved, do report if it can be
		$doReport:=RecordAcceptTest(booAccept; ptCurTable)  //jStartup0  
		If ($doReport)
			If (vHere>1)  //in an input layout save current changes
				If ((Modified record:C314(ptCurTable->)) | (vMod))
					C_BOOLEAN:C305($saveRec)
					$saveRec:=jConfirmSave(True:C214; True:C214)
					If ($saveRec)
						AcceptPrint
					End if 
				End if 
			End if 
		End if 
		//  only increases authority level of single unit printing
		$AuthLevel:=Storage:C1525.user.securityLevel
		If (ptCurTable=(->[Invoice:26]))  //&(vHere>0))
			If ([Customer:2]badCheck:34)
				$AuthLevel:=$AuthLevel-1
			End if 
		End if 
End case 


If ($doReport)
	READ ONLY:C145([UserReport:46])
	$stopLoop:=False:C215
	vDiaCom:="Select the Report to Print"
	If ($findUserReports)
		$stopLoop:=False:C215
		vDiaCom:="Select the Report to Print"
		// ### jwm ### 20190516_0820 updated query to include "ALL"
		QUERY:C277([UserReport:46]; [UserReport:46]tableNum:3=Table:C252(ptCurTable); *)
		QUERY:C277([UserReport:46];  | ; [UserReport:46]allTables:16=True:C214; *)
		QUERY:C277([UserReport:46];  & ; [UserReport:46]active:1=True:C214; *)
		QUERY:C277([UserReport:46];  & ; [UserReport:46]securityLevel:24<=$AuthLevel)
	End if 
	jCenterWindow(630; 440; 8)
	SET WINDOW TITLE:C213("Defined Reports")
	DIALOG:C40([UserReport:46]; "diaUserReport")
	CLOSE WINDOW:C154
	vDiaCom:=""
	Case of 
		: (myOK=0)
			$stopLoop:=True:C214
			$doReport:=False:C215
			
		: (myOK=3)  // use current data in the input layout our the UserReport
			READ WRITE:C146([UserReport:46])
			curTableNum:=Table:C252(ptCurTable)
			CREATE SET:C116(ptCurTable->; "<>curSelSet")
			If (vHere>1)
				//CREATE EMPTY SET(ptCurTable->;"<>curReportSet")
				//ADD TO SET(ptCurTable->;"<>curReportSet")
				COPY NAMED SELECTION:C331(ptCurTable->; "curSelect")  // save current Selection
				ONE RECORD SELECT:C189(ptCurTable->)  // get just the current Record
				COPY NAMED SELECTION:C331(ptCurTable->; "<>curReportSet")  // save the selection for printing
				USE NAMED SELECTION:C332("curSelect")  // restore the previous selection
				CLEAR NAMED SELECTION:C333("curSelect")  // clear memory
			Else 
				// CREATE SET(ptCurTable->;"<>curReportSet")
				COPY NAMED SELECTION:C331(ptCurTable->; "<>curReportSet")
			End if 
			<>ptPrintTable:=ptCurTable
			UNLOAD RECORD:C212([UserReport:46])
			<>processAlt:=New process:C317("Prs_ShowReport"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- UserReport - "+Table name:C256(curTableNum); ptCurTable; Current process:C322; aRptRecs{aRptLines{1}})
			$stopLoop:=True:C214
			$doReport:=False:C215
			
		: (myOK=4)  //  Create a new UserReport
			CREATE SET:C116(ptCurTable->; "<>curSelSet")  //  used in input layout procedure to estable data to print
			If (vHere>1)
				//CREATE EMPTY SET(ptCurTable->;"<>curReportSet")
				//ADD TO SET(ptCurTable->;"<>curReportSet")
				COPY NAMED SELECTION:C331(ptCurTable->; "curSelect")  // save current Selection
				ONE RECORD SELECT:C189(ptCurTable->)  // get just the current Record
				COPY NAMED SELECTION:C331(ptCurTable->; "<>curReportSet")  // save the selection for printing
				USE NAMED SELECTION:C332("curSelect")  // restore the previous selection
				CLEAR NAMED SELECTION:C333("curSelect")  // clear memory
			Else 
				// CREATE SET(ptCurTable->;"<>curReportSet")
				COPY NAMED SELECTION:C331(ptCurTable->; "<>curReportSet")
			End if 
			
			<>ptPrintTable:=ptCurTable
			Process_AddRecord("UserReport")
			DELAY PROCESS:C323(Current process:C322; 60)
			$stopLoop:=True:C214
			$doReport:=False:C215
			
		: (myOK=1)
			C_LONGINT:C283($i; $k; $err; $processNum)
			$k:=Size of array:C274(aRptLines)
			C_TEXT:C284(vtEmailBody; vtEmailSubject; vtEmailPath)
			If (vHere>1)  // Create the current set
				P_vHereBegin
			End if 
			For ($i; 1; $k)
				C_POINTER:C301($ptTable)
				If (aRptRecs{aRptLines{$i}}<0)
					
				Else 
					GOTO RECORD:C242([UserReport:46]; aRptRecs{aRptLines{$i}})
					If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
						$ptTable:=Table:C252([UserReport:46]tableNum:3)
						If (vHere>1)
							C_LONGINT:C283($vHereTemp)
							$vHereTemp:=vHere
							Prnt_ReportOpts(vHere)
							vHere:=$vHereTemp
						Else 
							// CREATE SET($ptTable->;"<>curReportSet")
							// ### jwm ### 20140827_1536 
							// Named selections preserve in memory the order of the selection and the current record of the selection.
							COPY NAMED SELECTION:C331($ptTable->; "<>curReportSet")
							<>ptPrintTable:=Table:C252([UserReport:46]tableNum:3)
							$reportRecNum:=aRptRecs{aRptLines{$i}}
							$processNum:=New process:C317("Prs_PrintReport"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptPrintTable); <>ptPrintTable; Current process:C322; $reportRecNum)
							DELAY PROCESS:C323(Current process:C322; 180)
						End if 
					End if 
				End if 
			End for 
			If (vHere>1)  // restore the current set
				P_vHereEnd
			End if 
	End case 
End if 

READ WRITE:C146([UserReport:46])
MESSAGES ON:C181