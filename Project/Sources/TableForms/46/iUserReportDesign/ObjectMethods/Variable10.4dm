// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-20T00:00:00, 00:09:58
// ----------------------------------------------------
// Method: aSREdits
// Description
// Modified: 11/20/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



Case of 
	: (Form event code:C388=On Unload:K2:2)
		ARRAY TEXT:C222(aSREdits; 0)
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aSREdits; 0)
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="SuperReport_Scripts")
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; aSREdits)
		APPEND TO ARRAY:C911(aSREdits; "Height Set")
		APPEND TO ARRAY:C911(aSREdits; "Width Set")
		APPEND TO ARRAY:C911(aSREdits; "Subselect Fields/Variables")
		APPEND TO ARRAY:C911(aSREdits; "Subselect Lines/Boxes")
		APPEND TO ARRAY:C911(aSREdits; "Text Spacing Single")
		SORT ARRAY:C229(aSREdits)
		
		
		INSERT IN ARRAY:C227(aSREdits; 1; 1)
		aSREdits{1}:="Show TallyMasters"
		INSERT IN ARRAY:C227(aSREdits; 1; 1)
		aSREdits{1}:="SuperReport Edits"
		aSREdits:=1
		
	: (aSREdits=2)  //(cmdKey=1)&
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SuperReport_Scripts")
		If (Records in selection:C76([TallyMaster:60])=0)
			CREATE RECORD:C68([TallyMaster:60])
			
			[TallyMaster:60]purpose:3:="SuperReportEdits"
			[TallyMaster:60]name:8:=aSREdits{aSREdits}
			SAVE RECORD:C53([TallyMaster:60])
		End if 
		DB_ShowCurrentSelection(->[TallyMaster:60])
		CANCEL:C270
	: (aSREdits>2)
		Case of 
			: (aSREdits{aSREdits}="Subselect Fields/Variables")
				SREActionSelectFieldVars
			: (aSREdits{aSREdits}="Subselect Lines/Boxes")
				SREActionSelectLinesBoxes
			: (aSREdits{aSREdits}="Width Set")
				SREActionSetWidth
			: (aSREdits{aSREdits}="Height Set")
				SREActionSetHeight
			: (aSREdits{aSREdits}="Text Spacing Single")
				SREActionTextSingleSpaceSet
			Else 
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SuperReport_Scripts"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=aSREdits{aSREdits})
				//QUERY([TallyMaster];&[TallyMaster]Publish>0;*)
				//QUERY([TallyMaster];&[TallyMaster]Publish<=Storage.user.securityLevel)
				If (Records in selection:C76([TallyMaster:60])>0)
					FIRST RECORD:C50([TallyMaster:60])
					SET TEXT TO PASTEBOARD:C523([TallyMaster:60]script:9)
					REDUCE SELECTION:C351([TallyMaster:60]; 0)
				End if 
		End case 
End case 
aSREdits:=1