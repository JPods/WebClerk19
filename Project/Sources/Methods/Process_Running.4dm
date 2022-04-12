//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-13T06:00:00Z)
// Method: Process_Running
// Description 
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($found)
If (Not:C34(Application type:C494=4D Server:K5:6))  // 
	If (Count parameters:C259=0)
		$found:=Prs_CheckRunnin("Processes")
		If ($found>0)
			POST OUTSIDE CALL:C329($found)  //<>theProcessList)
		Else 
			var $new_o : Object
			oeix:=New object:C1471("ents"; New object:C1471; \
				"currentData"; New object:C1471; \
				"cur"; New object:C1471; \
				"tableName"; "Control"; \
				"tableForm"; "Processes"; \
				"form"; ""; \
				"process"; Current process:C322)
			<>theProcessList:=New process:C317("Process_Running"; <>tcPrsMemory; "Processes"; $new_o)
		End if 
	Else 
		var process_o; $1 : Object
		process_o:=$1
		Process_InitLocal
		<>prsWndOp:=True:C214
		Prs_ListActive
		ptCurTable:=(->[Customer:2])
		C_LONGINT:C283($windHeigth)
		If (<>viDebugMode=1)
			$windH:=300
		Else 
			$windH:=250
		End if 
		C_TEXT:C284($placement)
		$placement:="UpperRight"
		C_OBJECT:C1216($obRec)
		$obSel:=ds:C1482.DefaultSetup.query("variableName = ProcessWindow").first()
		If ($obSel=Null:C1517)
			$placement:=$obRec.value
		End if 
		
		
		
		C_LONGINT:C283($viWidthForm; $viHeightForm; $viPageCount; $viAdjWidth; $viAdjHeight)
		C_BOOLEAN:C305($vbfixedWidth; $vbfixedHeight)
		C_TEXT:C284($vtTitle; $vtFormName)
		$vtFormName:=Current form name:C1298
		FORM GET PROPERTIES:C674([Control:1]; "Processes"; $viWidthForm; $viHeightForm; $viPageCount; $vbfixedWidth; $vbfixedHeight; $vtTitle)
		Case of 
			: ($placement="UpperRight")
				$vhReference:=Open form window:C675([Control:1]; "Processes"; Palette form window:K39:9; On the right:K39:3; At the top:K39:5; *)
				
			: ($placement="LowerRight")
				$vhReference:=Open form window:C675([Control:1]; "Processes"; Palette form window:K39:9; On the right:K39:3; At the bottom:K39:6; *)
				
			Else   // LowerLeft
				$vhReference:=Open form window:C675([Control:1]; "Processes"; Palette form window:K39:9; On the left:K39:2; At the bottom:K39:6; *)
				
		End case 
		
		
		DIALOG:C40([Control:1]; "Processes"; process_o)
		CLOSE WINDOW:C154  // is this needed ???
		<>prsWndOp:=False:C215
		<>viHasSaved:=0
		
	End if 
End if 