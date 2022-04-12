//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
C_TEXT:C284($theScript)
C_LONGINT:C283($curTableNum)
C_TEXT:C284($curTableNumChar)
$curTableNum:=Table:C252($1)
var $tableName : Text

If (($curTableNum>0) & ($curTableNum<=Get last table number:C254))
	$tableName:=Table name:C256($1)
	If (<>aLastRecNum{$curTableNum}<0)
		$curTableNumChar:=String:C10($curTableNum)
		$theScript:="LastRecordInTable("+String:C10($curTableNum)+")"+"\r"
		$theScript:=$theScript+"GOTO RECORD(["+$tableName+"];<>aLastRecNum{"+String:C10($curTableNum)+"})"
	Else 
		$theScript:="GOTO RECORD(["+$tableName+"];<>aLastRecNum{"+String:C10($curTableNum)+"})"
	End if 
	
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $tableName; \
		"script"; $theScript; \
		"windowTitleAdder"; "Last Record"; \
		"processParent"; Current process:C322; \
		"task"; "Script"; \
		"form"; "Input")
	
	$newProcess:=New process:C317("ProcessObject"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
	
End if 