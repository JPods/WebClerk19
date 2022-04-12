//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/17/19, 21:19:11
// ----------------------------------------------------
// Method: UserReport_iloProcedure
// Description
// ### bj ### 20190117_2119
// Substantially reworked
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20200211_2246 Fixed the iLo Name and When were 2 pixels to wide and shifted left


C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
		
	: ($formEvent=On Load:K2:1)
		
		ARRAY TEXT:C222(aLoText2; 2)
		aLoText2{1}:="Show Print Progress"  //### jwm ### 20131028_1244 changed choice to Print progress
		aLoText2{2}:="No Print Progress"  //### jwm ### 20131028_1244 changed choice to Print progress
		
		ARRAY TEXT:C222(aLoText3; 6)
		aLoText3{1}:="Sent to Printer"
		aLoText3{2}:="Preview"
		aLoText3{3}:="Sent to PDF"
		aLoText3{4}:="Print to Disk"
		aLoText3{5}:="Ask for Setup"
		aLoText3{6}:="Debug"
		
		ARRAY TEXT:C222(aLoText4; 3)
		aLoText4{1}:="Print all lines"  // VALUE = 0
		aLoText4{2}:="Limit Line Printing"  // VALUE = 1
		aLoText4{3}:="BLQ Only"  // VALUE = 2
		
		ARRAY TEXT:C222(aURpLnType; 5)
		aURpLnType{1}:="Record Count"
		aURpLnType{2}:="Single Loop"
		aURpLnType{3}:="Custom Count"
		aURpLnType{4}:="P_Var By Line"
		aURpLnType{5}:="ScriptDriven"
		
		ARRAY TEXT:C222(aLoText5; 0)
		COPY ARRAY:C226(<>yURptTypes; aLoText5)
		
		ScriptsDrafts
		
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([ZipCode:96]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
End case 
//
$doMore:=False:C215
C_LONGINT:C283($formEvent)
$formEvent:=iLoProcedure(->[UserReport:46])
//

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		
		$doMore:=True:C214
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		
		$doMore:=True:C214
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		
		$doMore:=True:C214
End case 
If ($doMore)  //action for the form regardless of new or existing record
	
	URpt_SetTypePop
	
	If (UserInPassWordGroup("EditReportScript"))
		//FAX_GetServer  //late initialization, only the first time through
		MESSAGES OFF:C175
		C_LONGINT:C283($result; $tablePassedIn)
		doSearch:=0
		//If (Records in set("<>curReportSet")>0)  //  to preview data in report
		//USE SET("<>curReportSet")
		//CLEAR SET("<>curReportSet")
		//End if 
		// ### jwm ### 20140827_1536 
		// Named selections preserve in memory the order of the selection and the current record of the selection.
		// ???
		
		// ### jwm ### 20180223_1426 starting having the error message that the Pointer was not defined.
		// ***  test this *** there is also  protection in "RECORDS IN NAMED SELECTION"
		If (Is nil pointer:C315(<>ptPrintTable))
			If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
				<>ptPrintTable:=Table:C252([UserReport:46]tableNum:3)
			End if 
		End if 
		
		ON ERR CALL:C155("jOECNoAction")  // enable error trapping
		C_LONGINT:C283($records)
		$records:=RECORDS IN NAMED SELECTION(<>ptPrintTable; "<>curReportSet")
		If ($records>0)  // ### jwm ### 20180116_1553 to prevent error message.
			USE NAMED SELECTION:C332("<>curReportSet")
			CLEAR NAMED SELECTION:C333("<>curReportSet")
		End if 
		
		ON ERR CALL:C155("")  // Disable error trapping
		
		If (Is nil pointer:C315(<>ptPrintTable))
			$tablePassedIn:=0
		Else 
			$tablePassedIn:=Table:C252(<>ptPrintTable)
		End if 
		If ([UserReport:46]tableNum:3=0)
			[UserReport:46]tableNum:3:=$tablePassedIn
			If ([UserReport:46]tableNum:3=0)
				[UserReport:46]tableName:47:="undefined"
			Else 
				[UserReport:46]tableName:47:=Table name:C256([UserReport:46]tableNum:3)
			End if 
		End if 
		
		Case of 
			: ([UserReport:46]numLines:10=0)  //    "Record Count"
				aURpLnType:=1
			: ([UserReport:46]numLines:10=-99)  //  "Singles Loop"
				aURpLnType:=2
			: ([UserReport:46]numLines:10=-1)  //  "Custom Count"
				aURpLnType:=3
			: ([UserReport:46]numLines:10>0)  // "P_Var By Line"
				aURpLnType:=4
			: ([UserReport:46]numLines:10=-2)  // "ScriptDriven"
				aURpLnType:=5
		End case 
		
		If ([UserReport:46]printerProgress:35>0)
			aLoText2:=1
			[UserReport:46]printerProgress:35:=1
		Else 
			aLoText2:=2
			[UserReport:46]printerProgress:35:=0
		End if 
		
		If (([UserReport:46]destination:11>1) & ([UserReport:46]destination:11<7))  // must be within
			aLoText3:=[UserReport:46]destination:11
		Else 
			aLoText3:=1
		End if 
		[UserReport:46]destination:11:=aLoText3
		
		If ([UserReport:46]printNot:30<2)
			aLoText4:=[UserReport:46]printNot:30+1  // 
		Else 
			aLoText4:=1
		End if 
		[UserReport:46]printNot:30:=aLoText4-1
		
		ARRAY TEXT:C222(atDelimiter; 3)
		atDelimiter{1}:="Tab .txt"
		atDelimiter{2}:="Comma .csv"
		atDelimiter{3}:="Semicolon .csv"
		
		Case of 
			: ([UserReport:46]fieldDelimiter:50=Character code:C91("\t"))  //        Tab = 9
				atDelimiter:=1
				
			: ([UserReport:46]fieldDelimiter:50=Character code:C91(","))  //       Comma = 44
				atDelimiter:=2
				
			: ([UserReport:46]fieldDelimiter:50=Character code:C91(";"))  //       semicolon = 59
				atDelimiter:=3
				
			Else 
				
				[UserReport:46]fieldDelimiter:50:=9  //          Tab = 9
				atDelimiter:=1
				
		End case 
		
		ARRAY TEXT:C222(atLineEnding; 3)
		atLineEnding{1}:="CR"
		atLineEnding{2}:="LF"
		atLineEnding{3}:="CRLF"
		
		Case of 
			: ([UserReport:46]lineEnding:51=Character code:C91("\r"))  //      Carriage Return
				atLineEnding:=1
				
			: ([UserReport:46]lineEnding:51=Character code:C91("\n"))  //       Line Feed
				atLineEnding:=2
				
			: ([UserReport:46]lineEnding:51=0x000A000D)  //                  Carriage Retun + Line Feed
				atLineEnding:=3
				
			Else 
				
				[UserReport:46]lineEnding:51:=Character code:C91("\r")  //          Carriage Return     
				atLineEnding:=1
				
		End case 
		
		
		C_LONGINT:C283(superReportCounter)
		superReportCounter:=0
		
		If (Is new record:C668([UserReport:46]))
			[UserReport:46]active:1:=True:C214
			If (ptCurTable#(->[UserReport:46]))
				[UserReport:46]tableNum:3:=Table:C252(ptCurTable)
				[UserReport:46]tableName:47:=Table name:C256([UserReport:46]tableNum:3)
				doSearch:=1
			End if 
		End if 
		// check for valid table number
		If (([UserReport:46]tableNum:3<1) | ([UserReport:46]tableNum:3>Get last table number:C254))
			[UserReport:46]tableNum:3:=0
			[UserReport:46]tableName:47:=""
		End if 
		
		
		//
		$doChange:=(UserInPassWordGroup("UnlockRecord"))
		OBJECT SET ENTERABLE:C238([UserReport:46]scriptExecute:4; $doChange)
		Case of 
			: ([UserReport:46]numLines:10=0)
				<>ysURpLnType:=<>ciUserRptRecordCount  //By Record Count of the default file
			: ([UserReport:46]numLines:10=-99)
				<>ysURpLnType:=<>ciUserRptLoopSingleRec  //Loop once for each default file record
			: ([UserReport:46]numLines:10<0)
				<>ysURpLnType:=<>ciUserRptCustom  //Custom iterations; set-up in the editor for each report
			Else 
				<>ysURpLnType:=<>ciUserRptByFixedLineCnt  //Fixed number of lines per page, uses P_... vars
		End case 
		
		If (([UserReport:46]creator:6="GTSR") | ([UserReport:46]creator:6="SuperReport") | ([UserReport:46]creator:6="Super Report"))
			C_BLOB:C604(pRM_ReportDef)
			C_TEXT:C284($report)
			ARRAY LONGINT:C221(aRecordsToPrint; 0)  // Use to track the primary set of records to print
			ARRAY LONGINT:C221(aPrintBodyCount; 0)  // Used when printing a report based on one table, that prints body lines from another
			ARRAY LONGINT:C221(aPrntRecs; 0)  // Keep this to make old reports operate without being fixed.
			
			
			If ([UserReport:46]scriptLoop:34#"")
				ExecuteText(0; [UserReport:46]scriptLoop:34)
			End if 
			ARRAY LONGINT:C221(aPrintBodyCount; 0)
			ARRAY LONGINT:C221(aRecordsToPrint; 0)
			If (([UserReport:46]tableNum:3<1) | ([UserReport:46]tableNum:3>Get last table number:C254))
				ALERT:C41("A table must be selected. Automatically setting the Table to Customers.")
				[UserReport:46]tableNum:3:=2
				[UserReport:46]tableName:47:=Table name:C256([UserReport:46]tableNum:3)
				$w:=Find in array:C230(<>aTableNames; "Customer")
				<>aTableNames:=$w
			Else 
				SELECTION TO ARRAY:C260(Table:C252([UserReport:46]tableNum:3)->; aRecordsToPrint)  // if there is a table defined, identify the records
				FIRST RECORD:C50(Table:C252([UserReport:46]tableNum:3)->)
			End if 
			P_SetBodyCount  // 
			// End if 
			C_TEXT:C284($reportXML)
			C_BLOB:C604($blobReport)
			
			$reportXML:=URprt_LoadSuperReport
			$result:=-2
			reportTableNum:=[UserReport:46]tableNum:3
			
			If (Length:C16($reportXML)>0)
				$result:=SR_LoadReport(eSRWin; $reportXML; 1)  // third arg means it is a report
				SRE_VarByFile(eSRWin)
				
				If ([UserReport:46]tableNum:3>0)
					// SR_SetLongProperty (eSRWin;1;SRP_Print_NoProgress;0)
					// SR_GetLongProperty (eSRWin;1;SRP_Report_DataSource);SRP_DataSource_TableNum;[UserReport]TableNum)
					C_LONGINT:C283(reportTableNum)
					SR_SetLongProperty(eSRWin; SR_GetLongProperty(eSRWin; 1; SRP_Report_DataSource); SRP_DataSource_TableNum; reportTableNum)
				End if 
			Else 
				// this should never be called
				//$result:=SR Do Command (eRM_ReportArea;101;1)  // third arg means ignore associated 4D method
				//or
				$result:=SR_LoadReport(eSRWin; SR_GetTextProperty(0; 0; SeSRWinRP_Area_NewReport); 0)  // third arg means it is a report
				C_LONGINT:C283($objectID)
				
				If ([UserReport:46]tableNum:3>0)
					SR_SetLongProperty(eSRWin; SR_GetLongProperty(eSRWin; 1; SRP_Report_DataSource); SRP_DataSource_TableNum; reportTableNum)
				End if 
				
				If ($result#0)
					If (False:C215)
						If ([UserReport:46]tableNum:3>0)
							$result:=SR Main Table([UserReport:46]reportBlob:27; SR MainTable Choose Table; reportTableNum; "")
						End if 
						$result:=SR Set Area(eSRWin; [UserReport:46]reportBlob:27)
					End if 
				End if 
			End if 
		Else 
			SET BLOB SIZE:C606([UserReport:46]reportBlob:27; 0)
			$result:=SR Set Area(eSRWin; [UserReport:46]reportBlob:27)
			// $result:=SR_LoadReport (eSRWin;$reportXML;1)  // third arg means it is a report
			// $result:=SR_LoadReport (eSRWin;SR_GetTextProperty (0;0;SeSRWinRP_Area_NewReport);0)  // third arg means it is a report
			C_LONGINT:C283($objectID)
		End if 
		If ((doSearch=1) & ([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
			If ((Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)>0) & ([UserReport:46]tableNum:3#Table:C252(->[UserReport:46])))
				// ### bj ### 20190117_2118
				READ ONLY:C145(Table:C252([UserReport:46]tableNum:3)->)
				FIRST RECORD:C50(Table:C252([UserReport:46]tableNum:3)->)
			End if 
		End if 
		
		//$err:=SR Menu Item (eSRWin;SR MenuItem Set 4D Method;SRe_MenuIte;"";0;0;"SRE_MenuPrintPreview")
		$err:=SR Menu Item(eSRWin; SR MenuItem Set 4D Method; SR MenuItem Preview; ""; 0; 0; "SRE_MenuPrintPreview")
		
		SRPage:=1
		doSearch:=0
		//area; action; menu item; change name; enable; mark; 4D Procedure
		booAccept:=(([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
		<>aTableNames:=Find in array:C230(<>aTableNums; [UserReport:46]tableNum:3)
		COPY ARRAY:C226(<>aTableNames; aLoText1)
		INSERT IN ARRAY:C227(aLoText1; 1; 1)
		aLoText1{1}:="Related Body Table"
		If (([UserReport:46]tableNumBodyCount:32>0) & ([UserReport:46]tableNumBodyCount:32<=Get last table number:C254))
			$w:=Find in array:C230(<>aTableNums; [UserReport:46]tableNumBodyCount:32)
		Else 
			$w:=0
		End if 
		aLoText1:=$w+1
		
		
		If (False:C215)
			If ([UserReport:46]creator:6#"GTSR")
				P_SetBodyCount  // 
				C_LONGINT:C283($tempCounter)
				$tempCounter:=SR_GetLongProperty(eSRWin; 1; SRP_Report_Modified)
				If ($tempCounter>superReportCounter)
					superReportCounter:=$tempCounter
					CONFIRM:C162("SuperReport modified. Mark this as a SuperReport?")
					If (OK=1)
						[UserReport:46]creator:6:="SuperReport"
					End if 
				End if 
			End if 
		End if 
		Before_New(ptCurTable)  //last thing to do
		
	End if 
	//every cycle
End if 
booAccept:=True:C214

If (False:C215)
	$fia:=Find in array:C230(<>yURFAUniqID; [UserReport:46]faxAttachment:25)
	If ($fia>0)
		<>yURFAName:=$fia
	Else 
		<>yURFAName:=1  //none
		[UserReport:46]faxAttachment:25:=<>yURFAUniqID{1}  //none
	End if 
	If ([UserReport:46]coverPage:23+1<=Size of array:C274(<>yFAXCovers))
		<>yFAXCovers:=[UserReport:46]coverPage:23+1
	Else 
		<>yFAXCovers:=1  //no cover page
		[UserReport:46]coverPage:23:=0
	End if 
End if 
