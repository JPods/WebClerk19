//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-07-20T00:00:00, 15:14:32
// ----------------------------------------------------
// Method: ScriptsDrafts
// Description
// Modified: 07/20/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="ScriptDrafts")
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; aScriptDrafts)
		SORT ARRAY:C229(aScriptDrafts)
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		INSERT IN ARRAY:C227(aScriptDrafts; 1; 1)  // 4
		aScriptDrafts{1}:="Create TallyMaster from Edit Area"
		INSERT IN ARRAY:C227(aScriptDrafts; 1; 1)  // 3
		aScriptDrafts{1}:="Create TallyMaster from Clipboard"
		INSERT IN ARRAY:C227(aScriptDrafts; 1; 1)  // 2
		aScriptDrafts{1}:="Show TallyMasters"
		INSERT IN ARRAY:C227(aScriptDrafts; 1; 1)  //  1
		aScriptDrafts{1}:="Script Drafts"
		aScriptDrafts:=1
		
	: (aScriptDrafts>4)
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ScriptDrafts"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=aScriptDrafts{aScriptDrafts})
		//QUERY([TallyMaster];&[TallyMaster]Publish>0;*)
		//QUERY([TallyMaster];&[TallyMaster]Publish<=Storage.user.securityLevel)
		If (Records in selection:C76([TallyMaster:60])>0)
			FIRST RECORD:C50([TallyMaster:60])
			Case of 
				: (myCycle=9)  // in ScriptEditor
					vTextSummary:=[TallyMaster:60]script:9+"\r"+"\r"+" //  Script End  "+"\r"+"\r"+vTextSummary
				: (myCycle=11)  // in a dialog box in Execute Script on Clipboard
					vEntryText:=[TallyMaster:60]script:9+"\r"+"\r"+" //  Script End  "+"\r"+"\r"+vEntryText
				: (ptCurTable=(->[UserReport:46]))
					[UserReport:46]scriptEnd:38:=[TallyMaster:60]script:9+"\r"+"\r"+" //  Script End  "+"\r"+"\r"+[UserReport:46]scriptEnd:38
				Else 
					SET TEXT TO PASTEBOARD:C523([TallyMaster:60]script:9)
					ALERT:C41("Script on clipboard.")
			End case 
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
		End if 
		
	: (aScriptDrafts=2)  //(cmdKey=1)&
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ScriptDrafts")
		If (Records in selection:C76([TallyMaster:60])=0)
			CREATE RECORD:C68([TallyMaster:60])
			[TallyMaster:60]purpose:3:="ScriptDrafts"
			[TallyMaster:60]name:8:=aScriptDrafts{aScriptDrafts}
			SAVE RECORD:C53([TallyMaster:60])
		End if 
		DB_ShowCurrentSelection(->[TallyMaster:60])
		If (myCycle=11)  // in a dialog window
			CANCEL:C270
		End if 
		aScriptDrafts:=1
		
	: (aScriptDrafts=3)
		C_TEXT:C284($clipboard; $reportName)
		$clipboard:=Get text from pasteboard:C524
		If ($clipboard="")
			ALERT:C41("Clipboard is empty")
		Else 
			$reportName:=Request:C163("Enter name of script."; Substring:C12($clipboard; 1; 20))
			If ((OK=1) & ($reportName#""))
				CREATE RECORD:C68([TallyMaster:60])
				[TallyMaster:60]purpose:3:=$reportName
				[TallyMaster:60]purpose:3:="ScriptDrafts"
				[TallyMaster:60]script:9:=Get text from pasteboard:C524
				SAVE RECORD:C53([TallyMaster:60])
				DB_ShowCurrentSelection(->[TallyMaster:60])
				If (myCycle=11)  // in a dialog window
					CANCEL:C270
				End if 
			End if 
		End if 
		
		
	: (aScriptDrafts=4)
		C_TEXT:C284($clipboard; $reportName)
		If (vTextSummary="")
			ALERT:C41("Edit Area is empty")
		Else 
			$reportName:=Request:C163("Enter name of script."; Substring:C12(vTextSummary; 1; 20))
			If ((OK=1) & ($reportName#""))
				CREATE RECORD:C68([TallyMaster:60])
				[TallyMaster:60]name:8:=$reportName
				[TallyMaster:60]purpose:3:="ScriptDrafts"
				[TallyMaster:60]script:9:=vTextSummary
				SAVE RECORD:C53([TallyMaster:60])
				DB_ShowCurrentSelection(->[TallyMaster:60])
				If (myCycle=11)  // in a dialog window
					CANCEL:C270
				End if 
			End if 
		End if 
		
End case 
aScriptDrafts:=1