//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-15T00:00:00, 11:38:37
// ----------------------------------------------------
// Method: jPareto
// Description
// Modified: 04/15/17
// 
// 
//
// Parameters
// ----------------------------------------------------



b1:=1
b2:=0
b3:=0
myOK:=1
Case of 
	: (vHere=0)
		jsetDefaultFile(->[Service:6])
		File_Select("Select Service Records for Pareto chart.")
	: ((ptCurTable=(->[Service:6])) & (Modified record:C314([Service:6])))
		CONFIRM:C162("Do you wish to save the record.")
		If (ok=1)
			jAcceptButton
		Else 
			jCancelButton
		End if 
End case 
If (myOK=1)
	CREATE SET:C116([Service:6]; "Pareto")
	viRecordsInTable:=Size of array:C274(<>aProcesses)
	viRecordsInSelection:=Records in selection:C76([Service:6])
	If (viRecordsInSelection=0)
		ALERT:C41("Select the Service Records for the Pareto Chart.")
	Else 
		ARRAY TEXT:C222(aAttributes; 0)
		ARRAY TEXT:C222(aCauses; 0)
		DELETE FROM ARRAY:C228(<>aProcesses; 1; 1)
		DELETE FROM ARRAY:C228(<>aProcessNums; 1; 1)
		jCenterWindow(720; 430; 1)
		DIALOG:C40([Control:1]; "grafPareto")
		CLOSE WINDOW:C154
		INSERT IN ARRAY:C227(<>aProcesses; 1; 1)
		INSERT IN ARRAY:C227(<>aProcessNums; 1; 1)
		<>aProcesses{1}:="Process"
		ARRAY TEXT:C222(aAttributes; 1)
		ARRAY LONGINT:C221(aAttNums; 1)
		aAttributes{1}:="Attribute"
		ARRAY TEXT:C222(aCauses; 1)
		ARRAY LONGINT:C221(aCauseNums; 1)
		aCauses{1}:="Causes"
		vHeadTitle:=""
		ARRAY TEXT:C222(aTallyFiles; 0)
		ARRAY TEXT:C222(aCatFiles; 0)
		ARRAY TEXT:C222(aTallyFlds; 0)
		ARRAY TEXT:C222(aCatFlds; 0)
		ARRAY TEXT:C222(aCatagory; 0)
		ARRAY TEXT:C222(aShowCats; 0)
		CLEAR SET:C117("Pareto")
		UNLOAD RECORD:C212([Service:6])
		UNLOAD RECORD:C212([Process:16])
	End if 
End if 