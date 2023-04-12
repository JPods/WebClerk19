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
			BRING TO FRONT:C326($found)
			//POST OUTSIDE CALL($found)  //Storage.process.processList)
		Else 
			var $new_o : Object
			$new_o:=New object:C1471("processParent"; Current process:C322)
			Use (Storage:C1525.process)
				Storage:C1525.process.processList:=New process:C317("Process_Running"; <>tcPrsMemory; "Processes"; $new_o)
			End use 
		End if 
	Else 
		var process_o; $1 : Object
		process_o:=$1
		Process_InitLocal
		Process_ListActive
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
		FORM GET PROPERTIES:C674([Base:1]; "Processes"; $viWidthForm; $viHeightForm; $viPageCount; $vbfixedWidth; $vbfixedHeight; $vtTitle)
		Case of 
			: ($placement="UpperRight")
				$vhReference:=Open form window:C675([Base:1]; "Processes"; Palette form window:K39:9; On the right:K39:3; At the top:K39:5; *)
				
			: ($placement="LowerRight")
				$vhReference:=Open form window:C675([Base:1]; "Processes"; Palette form window:K39:9; On the right:K39:3; At the bottom:K39:6; *)
				
			Else   // LowerLeft
				$vhReference:=Open form window:C675([Base:1]; "Processes"; Palette form window:K39:9; On the left:K39:2; At the bottom:K39:6; *)
				
		End case 
		
		
		DIALOG:C40([Base:1]; "Processes"; process_o)
		CLOSE WINDOW:C154  // is this needed ???
		
	End if 
End if 