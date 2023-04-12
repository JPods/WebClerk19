//%attributes = {}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: Data_vCardLoadMove
// Description 
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $folderPath; $processedPath; $script; $newName)
C_LONGINT:C283($foundFolder)
If (Count parameters:C259>0)
	$folderPath:=$1
End if 
If ($folderPath="")
	$folderPath:=Select folder:C670("Select vCard Folder"; "")
End if 
$foundFolder:=Test path name:C476($folderPath)
If ($foundFolder#0)  //a folder was not found
	If (allowAlerts_boo)
		ALERT:C41("No vCard folder found: "+"\r"+$folderPath)
	End if 
Else 
	ARRAY TEXT:C222($aDocList; 0)
	ARRAY TEXT:C222($aFolderList; 0)
	DOCUMENT LIST:C474($folderPath; $aDocList)
	FOLDER LIST:C473($folderPath; $aFolderList)
	$processedPath:=$folderPath+"vCardsProcessed"+Folder separator:K24:12+Date_strYyyymmdd+Folder separator:K24:12
	
	If (Test path name:C476($processedPath)#0)
		CREATE FOLDER:C475($processedPath)
	End if 
	C_LONGINT:C283($cntDocs; $incDocs)
	$cntDocs:=Size of array:C274($aDocList)
	If ($cntDocs>0)
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Admin"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="vCardModify")
		If (Records in selection:C76([TallyMaster:60])>0)
			FIRST RECORD:C50([TallyMaster:60])
			$script:=[TallyMaster:60]script:9
		Else 
			CREATE RECORD:C68([TallyMaster:60])
			
			[TallyMaster:60]purpose:3:="Admin"
			[TallyMaster:60]name:8:="vCardModify"
			[TallyMaster:60]profileName1:13:="Used in"
			[TallyMaster:60]profile1:23:="vCardIn"
			SAVE RECORD:C53([TallyMaster:60])
		End if 
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		CREATE EMPTY SET:C140([Customer:2]; "current")
		CREATE EMPTY SET:C140([Customer:2]; "duplicate")
		C_TEXT:C284($groupName)
		// ### bj ### 20181221_1417
		If ($groupName="")
			$groupName:=Request:C163("Enter Group Name")
		End if 
		For ($incDocs; 1; $cntDocs)
			If (Position:C15(".vcf"; $aDocList{$incDocs})>1)
				Data_vCardIn($folderPath+$aDocList{$incDocs}; $script; "current"; "duplicate"; $groupName)
			End if 
			If (Test path name:C476($processedPath+$aDocList{$incDocs})=1)  // already exists
				$newName:=String:C10(DateTime_DTTo)+"_"+$aDocList{$incDocs}
				MOVE DOCUMENT:C540($folderPath+$aDocList{$incDocs}; $folderPath+$newName)
				MOVE DOCUMENT:C540($folderPath+$newName; $processedPath+$newName)
			Else 
				MOVE DOCUMENT:C540($folderPath+$aDocList{$incDocs}; $processedPath+$aDocList{$incDocs})
			End if 
		End for 
		If (Records in set:C195("current")>0)
			USE SET:C118("current")
			DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "vCards"; 0)
		End if 
		CLEAR SET:C117("current")
		If (Records in set:C195("duplicate")>0)
			USE SET:C118("duplicate")
			DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "vCards duplicates"; 0)
		End if 
		CLEAR SET:C117("failed")
	End if 
End if 