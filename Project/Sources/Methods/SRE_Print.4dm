//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-08T00:00:00, 22:10:57
// ----------------------------------------------------
// Method: SRE_Print
// Description
// Modified: 08/08/13
// 
// 
//
// Parameters
// ----------------------------------------------------
//  ### jwm ### 20140210_1527 If not found try Alternate Name 
// ### jwm ### 20150105_1633 moved report name and added destination folder
// ### jwm ### 20150129_1057 only change for Disk File or PDF *** DEBUG THIS ***

// ### jwm ### 20150720_1932 QQQQQQQQ  Check all types of reports and name of report PDF PDF PDF 


C_LONGINT:C283($incPrintings; $cntPrintings; $viDelimiter)
C_LONGINT:C283(vPageCurrent)
C_LONGINT:C283($debugAdders)
C_TEXT:C284($reportXML; jobName; $jobName; $suffix)
C_LONGINT:C283($err; $i; $destination)
C_LONGINT:C283($session)
C_TEXT:C284($documentPath; $XML; $jobName; $printerName)

C_TEXT:C284(MESSAGES; reportDocument)

MESSAGES OFF:C175
READ ONLY:C145([Default:15])
QUERY:C277([Default:15]; [Default:15]primeDefault:176=1)
If (vHere=0)  //  being called from a process without coming from an input layout
	vHere:=1
	If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
		If (Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)=1)
			vHere:=2
		End if 
	End if 
End if 

$documentPath:=""
$printerName:=Get current printer:C788


If ([UserReport:46]printerSelected:36#"")
	ARRAY TEXT:C222($namesArray; 0)
	ARRAY TEXT:C222($altNamesArray; 0)
	ARRAY TEXT:C222($modelsArray; 0)
	PRINTERS LIST:C789($namesArray; $altNamesArray; $modelsArray)
	
	$findWantedPrinter:=Find in array:C230($namesArray; [UserReport:46]printerSelected:36)
	If ($findWantedPrinter>0)
		$printerName:=$namesArray{$findWantedPrinter}
	Else   //  ### jwm ### 20140210_1527 If not found try Alternate Name 
		$findWantedPrinter:=Find in array:C230($altNamesArray; [UserReport:46]printerSelected:36)
		If ($findWantedPrinter>0)
			$printerName:=$namesArray{$findWantedPrinter}
		End if 
	End if 
	
End if 
//  $changedPrinter:=PrinterSelect ([UserReport]PrinterSelected)
//  PrintControls   // Get and set the printer
// review this

//### jwm ### 20131028_1251 begin changed choice to Print progress
If ([UserReport:46]printerProgress:35=0)
	$debugAdders:=SRP_Print_NoProgress
End if 
//### jwm ### 20131028_1251 end 
$suffix:=""

C_BOOLEAN:C305(<>doTwice; noDialog)
<>doTwice:=False:C215
If (<>doTwice)
	C_TEXT:C284(reportXML)
	$destination:=SRP_Print_AskJobSetup  //### jwm ### 20131028_1
	reportXML:=URprt_LoadSuperReport
	$err:=SR_Print(reportXML; 0; 0; ""; $session)
End if 

Case of 
	: (noDialog)  // coming from iPad etc...
		$destination:=SRP_Print_DestinationPrinter
	: ([UserReport:46]destination:11=1)  //print
		$destination:=SRP_Print_DestinationPrinter
	: ([UserReport:46]destination:11=2)  //preview
		If (Is macOS:C1572)
			$destination:=SRP_Print_DestinationPreview
		Else 
			// Windows Preview changed to PDF
			$destination:=(SRP_Print_DestinationPDF | SRP_Print_WinOpenCreatedFile)
			$suffix:=".pdf"
		End if 
	: ([UserReport:46]destination:11=3)  //print to PDF   
		$destination:=(SRP_Print_DestinationPDF)
		$suffix:=".pdf"
	: ([UserReport:46]destination:11=4)  //print to disk   
		$destination:=(SRP_Export_Text | SRP_Export_CSVFormat | SRP_Export_Headers | SRP_Export_Body | SRP_Export_Total | SRP_Export_StaticText)
		
		Case of 
			: ([UserReport:46]fieldDelimiter:50=Character code:C91("\t"))  //   Tab = 9
				$suffix:=".txt"
				
			: ([UserReport:46]fieldDelimiter:50=Character code:C91(","))  //    Comma = 44
				$suffix:=".csv"
				
			: ([UserReport:46]fieldDelimiter:50=Character code:C91(";"))  //    Semicolon = 59
				$suffix:=".csv"
				
			Else 
				
				[UserReport:46]fieldDelimiter:50:=Character code:C91("\t")  //     Tab = 9
				$suffix:=".txt"
				
		End case 
		
		$viDelimiter:=[UserReport:46]fieldDelimiter:50
		
		Case of 
			: ([UserReport:46]lineEnding:51=Character code:C91("\r"))  //   carriage return
				$viLineEnding:=Character code:C91("\r")
				
			: ([UserReport:46]lineEnding:51=Character code:C91("\n"))  //   Line Feed
				
			: ([UserReport:46]lineEnding:51=0x000A000D)  //   Carriage Return + Line Feed
				$viLineEnding:=0x000A000D
				
			Else 
				
				[UserReport:46]lineEnding:51:=Character code:C91("\r")  //     Tab = 9
				$viLineEnding:=Character code:C91("\r")
				
		End case 
		
	Else   //: ([UserReport]Destination=6)  // ask with pdf 
		//$destination:=SRP_Print_AskPageSetup
		$destination:=SRP_Print_AskJobSetup  //### jwm ### 20131028_1159
End case 

// ### jwm ### 20150105_1633_begin
// check file / report name
C_TEXT:C284(pvJobName; pvFolderName)

If ([UserReport:46]destination:11#4)  // do not add for Disk Files
	$destination:=$destination+$debugAdders  //### jwm ### 20131028_1242
End if 

pvJobName:=""
pvFolderName:=""
$jobName:=""
If (([UserReport:46]scriptExecute:4) & ([UserReport:46]scriptBegin:5#""))  // once per session
	ExecuteText(0; [UserReport:46]scriptBegin:5)
End if 
// pvJobName allows a name to be
// ### bj ### 20200114_1056
If (pvJobName#"")
	$jobName:=pvJobName
Else 
	$jobName:=[UserReport:46]name:2  //### jwm ### 20131028_1255  Add field [UserReport]JobName ???
	C_POINTER:C301($ptTable)
	$ptTable:=STR_GetTablePointer(Table name:C256([UserReport:46]tableNum:3))
	If (Not:C34(Is nil pointer:C315($ptTable)))
		If (Records in selection:C76($ptTable->)=1)
			Case of 
				: ($ptTable=(->[Proposal:42]))
					
				: ($ptTable=(->[Order:3]))
					
				: ($ptTable=(->[Invoice:26]))
					
				: ($ptTable=(->[PO:39]))
					
				: ($ptTable=(->[Project:24]))
					
				: ($ptTable=(->[WorkOrder:66]))
					
				: ($ptTable=(->[Employee:19]))
					
				: ($ptTable=(->[Customer:2]))
					
				: ($ptTable=(->[Vendor:38]))
					
				: ($ptTable=(->[Item:4]))
					
				Else 
					If ([UserReport:46]appendTableName:43)
						$jobName:=$jobName+"_"+Table name:C256([UserReport:46]tableNum:3)
					End if 
			End case 
		End if 
	End if 
End if 
If ([UserReport:46]idAppend:42)
	C_TEXT:C284($thePrimary)
	
	$thePrimary:=STR_GetProtectString(Table name:C256([UserReport:46]tableNum:3))
	$jobName:=$jobName+"_"+$thePrimary
End if 
If ([UserReport:46]appendDate:41)
	$jobName:=$jobName+"_"+Date_strYrMmDd(Current date:C33; 2)
End if 
//TRACE
// check folder name
If (([UserReport:46]destination:11=2) | ([UserReport:46]destination:11=3) | ([UserReport:46]destination:11=4))  // ### jwm ### 20150129_1057 only change for Disk File or PDF
	If (pvFolderName#"")
		$documentPath:=pvFolderName+$jobName+$suffix
	Else 
		$documentPath:=Storage:C1525.folder.jitDocs+$jobName+$suffix
	End if 
	pvDocumentPath:=$documentPath
End if 
// ### jwm ### 20150105_1633_end
//TRACE
C_TEXT:C284(reportXML)
reportXML:=URprt_LoadSuperReport

If ([UserReport:46]destination:11=4)
	
	// ### jwm ### 20190709_1602 export tab delimited text file
	$err:=SR_Export(reportXML; $destination; $viDelimiter; $documentPath; $viLineEnding)
	
Else 
	
	$err:=SR_OpenSession($session; $destination; $documentPath; reportXML; $jobName; $printerName)
	
	If ($err>-1)
		
		
		//  load the report
		//$err:=SR_Print (reportXML;0;0;"";$session)
		
		// Modified by: William James (2013-07-29T00:00:00)
		// THIS IS A KEY CHANGE  
		ARRAY LONGINT:C221(aRecordsToPrint; 0)  // Use to track the primary set of records to print
		ARRAY LONGINT:C221(aPrintBodyCount; 0)  // Used when printing a report based on one table, that prints body lines from another
		ARRAY LONGINT:C221(aPrntRecs; 0)  // Keep this to make old reports operate without being fixed.
		
		C_BOOLEAN:C305($doMultipleRecords)
		$doMultipleRecords:=True:C214
		If (([UserReport:46]numLines:10=-1) | ([UserReport:46]numLines:10=-2))  // user control everything via the SuperReport and scripts
			$err:=SR_Print(reportXML; 0; 0; ""; $session)
		Else 
			If ((vhere>1) & (ptCurTable#(->[UserReport:46])))
				ARRAY LONGINT:C221(aRecordsToPrint; 1)
				aRecordsToPrint{1}:=Record number:C243(ptCurTable->)
				$doMultipleRecords:=False:C215
			Else 
				SELECTION TO ARRAY:C260(Table:C252([UserReport:46]tableNum:3)->; aRecordsToPrint)  // if there is a table defined, identify the records
			End if 
			If ($doMultipleRecords)
				FIRST RECORD:C50(Table:C252([UserReport:46]tableNum:3)->)
			End if 
			$cntPrintings:=Size of array:C274(aRecordsToPrint)  // set to loop the printing proceedure one for each record
			If (([UserReport:46]numLines:10=-99) | ([UserReport:46]numLines:10>0))  // //singleLoop Report
				$SingleLoop:=True:C214
				For ($incPrintings; 1; $cntPrintings)
					If ($doMultipleRecords)
						GOTO RECORD:C242(Table:C252([UserReport:46]tableNum:3)->; aRecordsToPrint{$incPrintings})  // alwasy printing in a new process
					Else 
						// the record should be loaded
					End if 
					P_SetBodyCount
					$err:=SR_Print(reportXML; 0; 0; ""; $session)
				End for 
			Else   //: ([UserReport]NumLines=0)
				COPY ARRAY:C226(aRecordsToPrint; aPrintBodyCount)  // print regardless of the array choose of these two
				$err:=SR_Print(reportXML; 0; 0; ""; $session)
			End if 
		End if 
		
		$err:=SR_CloseSession($session)
		
		[UserReport:46]timesPrinted:31:=[UserReport:46]timesPrinted:31+1
		SAVE RECORD:C53([UserReport:46])
	End if 
	
End if 

// ### jwm ### 20170609_1551 moved above unload record
If (([UserReport:46]scriptExecute:4) | ([UserReport:46]scriptEnd:38#""))  // once per session
	ExecuteText(0; [UserReport:46]scriptEnd:38)
End if 

// view document after report complete
If ([UserReport:46]previewAlways:26=True:C214)
	// ### jwm ### 20150129_1057 only change for Disk File or PDF
	If (([UserReport:46]destination:11=3) | ([UserReport:46]destination:11=4))  // PDF or Text file
		OPEN URL:C673(pvDocumentPath)
	End if 
End if 

ARRAY LONGINT:C221(aRecordsToPrint; 0)  // Use to track the primary set of records to print
ARRAY LONGINT:C221(aPrintBodyCount; 0)  // Used when printing a report based on one table, that prints body lines from another
ARRAY LONGINT:C221(aPrntRecs; 0)  // Keep this to make old reports operate without being fi
UNLOAD RECORD:C212([UserReport:46])
UNLOAD RECORD:C212([Default:15])

reportDocument:=""

