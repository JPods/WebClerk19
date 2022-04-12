//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:33:10
// ----------------------------------------------------
// Method: J_PrntQuickRpt
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("EditReportScript"))
	C_LONGINT:C283($recNum)
	C_BOOLEAN:C305($doReport; $doCurFile)
	C_TEXT:C284($1)
	MESSAGES OFF:C175
	$doCurFile:=True:C214
	If (vHere>1)
		$doCurFile:=(RecordAcceptTest(booAccept; ptCurTable))  //jStartup0  
	End if 
	If ($doCurFile)
		$doCurFile:=False:C215
		Case of 
			: (vHere=0)
				File_Select("Select the file for which you wish to create a Report.")
				$doReport:=(OK=1)
			: (ptPrintFile#(->[Control:1]))
				$doCurFile:=True:C214
				ptCurTable:=ptPrintFile
				$doReport:=True:C214
			: ((ptCurTable=(->[Control:1])) & (ptPrintFile=(->[Control:1])))
				$doCurFile:=True:C214
				myOK:=5000
				//    jdiaDefaultFile ("Select the file for which you wish to create a Report.")
				File_Select("Select the file for which you wish to create a Report.")
				If (myOK=1)
					ptCurTable:=Table:C252(curTableNum)
				End if 
				$doReport:=(OK=1)
			: (vHere=1)
				$doReport:=True:C214
			Else 
				$doReport:=jConfirmSave(True:C214; True:C214)
				If ($doReport)
					AcceptPrint
					$recNum:=Record number:C243(ptCurTable->)
					ONE RECORD SELECT:C189(ptCurTable->)
				End if 
		End case 
		If ($doReport)
			
			
			Path_Set(Storage:C1525.folder.jitQRsF)
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			
			If (HFS_Exists(Storage:C1525.folder.jitF+"awewefsehege")=1)
				$error:=HFS_Delete(Storage:C1525.folder.jitF+"awewefsehege")
			End if 
			QR REPORT:C197(ptCurTable->; Storage:C1525.folder.jitF+"awewefsehege")  //non-existence file        
			
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			If (vHere>1)
				GOTO RECORD:C242(ptCurTable->; $recNum)
				SET WINDOW TITLE:C213(Table name:C256(ptCurTable)+" - "+aPages{1}+" - "+String:C10(1))
				jNxPvButtonSet
			End if 
		End if 
		If ($doCurFile)
			If (vHere=2)
				vHere:=3
			End if 
			//   ptCurFile:=([Control])
			// iLoPagePopUpMenuBar ([Control])
		End if 
		MESSAGES ON:C181
	End if 
End if 