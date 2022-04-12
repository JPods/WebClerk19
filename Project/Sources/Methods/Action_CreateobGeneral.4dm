//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/28/21, 14:43:58
// ----------------------------------------------------
// Method: Action_CreateobGeneral
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obRec; $obSel)
C_LONGINT:C283($incTable; $changeField)
C_TEXT:C284($tableName)
TRACE:C157
For ($incTable; 1; Get last table number:C254)  //Loop for files
	$tableName:=Table name:C256($incTable)
	If (($tableName="Control") | ($tableName="zz@"))
		// do nothing
	Else 
		$obSel:=ds:C1482[$tableName].all()
		For each ($obRec; $obSel)
			$changeField:=0
			If ($obRec.obGeneral=Null:C1517)
				$obRec.obGeneral:=New object:C1471
				$changeField:=1
			End if 
			If ($obRec.obGeneral.events=Null:C1517)
				$obRec.obGeneral.events:=New object:C1471
				$changeField:=1
			End if 
			If ($changeField=1)
				$result_o:=$obRec.save()
			End if 
		End for each 
	End if 
End for 

