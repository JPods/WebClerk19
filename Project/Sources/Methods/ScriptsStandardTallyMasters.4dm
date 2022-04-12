//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/05/19, 10:25:05
// ----------------------------------------------------
// Method: ScriptsStandardTallyMasters
// Description
// 
//
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aStandardScripts; 0)
		APPEND TO ARRAY:C911(aStandardScripts; "AcceptTest")
		APPEND TO ARRAY:C911(aStandardScripts; "AcceptPostTask")
		APPEND TO ARRAY:C911(aStandardScripts; "CR_Script")
		APPEND TO ARRAY:C911(aStandardScripts; "Execute_Tally")
		APPEND TO ARRAY:C911(aStandardScripts; "help")
		APPEND TO ARRAY:C911(aStandardScripts; "HTML_Parse_End")
		APPEND TO ARRAY:C911(aStandardScripts; "iLo_OnLoadRecord")
		APPEND TO ARRAY:C911(aStandardScripts; "ilo_SaveRec")
		APPEND TO ARRAY:C911(aStandardScripts; "iLoInterProcess")
		APPEND TO ARRAY:C911(aStandardScripts; "iLoScripts")
		APPEND TO ARRAY:C911(aStandardScripts; "ImportExport")
		APPEND TO ARRAY:C911(aStandardScripts; "StartUp")
		APPEND TO ARRAY:C911(aStandardScripts; "ManagementReport")
		APPEND TO ARRAY:C911(aStandardScripts; "oLoScripts")
		APPEND TO ARRAY:C911(aStandardScripts; "RecordPassing")
		APPEND TO ARRAY:C911(aStandardScripts; "RelateWebClerk")
		APPEND TO ARRAY:C911(aStandardScripts; "RemoteAuto")
		APPEND TO ARRAY:C911(aStandardScripts; "SchedulerCrews")
		APPEND TO ARRAY:C911(aStandardScripts; "search")
		APPEND TO ARRAY:C911(aStandardScripts; "ShippingCalc")
		APPEND TO ARRAY:C911(aStandardScripts; "Soap")
		APPEND TO ARRAY:C911(aStandardScripts; "Sort")
		APPEND TO ARRAY:C911(aStandardScripts; "Wcc_PO_Report")
		APPEND TO ARRAY:C911(aStandardScripts; "WccExecute")
		APPEND TO ARRAY:C911(aStandardScripts; "WccSave")
		APPEND TO ARRAY:C911(aStandardScripts; "WebPrinting")
		APPEND TO ARRAY:C911(aStandardScripts; "webscript")
		APPEND TO ARRAY:C911(aStandardScripts; "RP_SyncToRecord")
		APPEND TO ARRAY:C911(aStandardScripts; "ScriptEditorHTML")
		APPEND TO ARRAY:C911(aStandardScripts; "HTTPSelectList")
		APPEND TO ARRAY:C911(aStandardScripts; "oloOpen")
		APPEND TO ARRAY:C911(aStandardScripts; "ExecuteArray")
		APPEND TO ARRAY:C911(aStandardScripts; "Admin")
		APPEND TO ARRAY:C911(aStandardScripts; "ScriptDrafts")
		APPEND TO ARRAY:C911(aStandardScripts; "DataBaseLicenses")
		APPEND TO ARRAY:C911(aStandardScripts; "BadKeyWords")
		APPEND TO ARRAY:C911(aStandardScripts; "WebCommandOverRide")
		APPEND TO ARRAY:C911(aStandardScripts; "WebCommandAlias")
		APPEND TO ARRAY:C911(aStandardScripts; "Scheduler")
		APPEND TO ARRAY:C911(aStandardScripts; "Sets")
		APPEND TO ARRAY:C911(aStandardScripts; "Current Machine")
		APPEND TO ARRAY:C911(aStandardScripts; "AjaxTemplates")
		APPEND TO ARRAY:C911(aStandardScripts; "Sets")
		APPEND TO ARRAY:C911(aStandardScripts; "ArchiveInternal")
		APPEND TO ARRAY:C911(aStandardScripts; "ajax")
		APPEND TO ARRAY:C911(aStandardScripts; "Object")
		APPEND TO ARRAY:C911(aStandardScripts; "ObjectArray")
		
		SORT ARRAY:C229(aStandardScripts)
		
		QUERY:C277([Word:99]; [Word:99]tableNum:2=Table:C252(->[TallyMaster:60]); *)
		QUERY:C277([Word:99];  & [Word:99]alternate:12="PurposeTallyMasters")
		If (Records in selection:C76([Word:99])=0)
			CREATE RECORD:C68([Word:99])
			[Word:99]tableNum:2:=Table:C252(->[TallyMaster:60])
			[Word:99]alternate:12:="PurposeTallyMasters"
			[Word:99]wordOnly:3:="Scripts"
			[Word:99]comment:10:="Populates OutPut Layout search choices for TallyMasters."
			SAVE RECORD:C53([Word:99])
		End if 
		
		
		C_LONGINT:C283($i; $records; $w)
		
		$records:=Records in selection:C76([Word:99])
		FIRST RECORD:C50([Word:99])
		For ($i; 1; $records)
			$w:=Find in array:C230(aStandardScripts; [Word:99]wordOnly:3)
			If ($w<1)
				APPEND TO ARRAY:C911(aStandardScripts; [Word:99]wordOnly:3)
			End if 
			NEXT RECORD:C51([Word:99])
		End for 
		
		
		//
		REDUCE SELECTION:C351([Word:99]; 0)
		
		INSERT IN ARRAY:C227(aStandardScripts; 1; 1)
		aStandardScripts{1}:="Purpose"  // ### jwm ### 20180101_1415 shortened name from Purpose tallyMasters to Purpose
		aStandardScripts:=1
		
	: (aStandardScripts=0)
		aStandardScripts:=1
	: (aStandardScripts=1)
		// ### bj ### 20200107_2343
		Case of 
			: (Current form name:C1298="Output")
				QUERY:C277([Word:99]; [Word:99]tableNum:2=Table:C252(->[TallyMaster:60]); *)
				QUERY:C277([Word:99];  & [Word:99]alternate:12="PurposeTallyMasters")
				DB_ShowCurrentSelection(->[Word:99])
			: (Current form name:C1298="Input")
				// do nothing
		End case 
		
	: (aStandardScripts>1)
		Case of 
			: (Current form name:C1298="Output")
				iLo80String3:=aStandardScripts{aStandardScripts}
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=aStandardScripts{aStandardScripts})
			: (Current form name:C1298="Input")
				[TallyMaster:60]purpose:3:=aStandardScripts{aStandardScripts}
		End case 
		aStandardScripts:=1
End case 
