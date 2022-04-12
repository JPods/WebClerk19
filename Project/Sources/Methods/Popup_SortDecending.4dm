//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/26/21, 20:27:40
// ----------------------------------------------------
// Method: Popup_SortDecending
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obRec; $obSel)
C_TEXT:C284($vtArrayName)
C_LONGINT:C283($inc)
$obSel:=ds:C1482.PopupChoice.all().orderBy("arrayName, choice")
$vtArrayName:=$obSel.first().arrayName
$inc:=0
For each ($obRec; $obSel)
	If ($vtArrayName=$obRec.arrayName)
		$inc:=$inc+1
	Else 
		$vtArrayName:=$obRec.arrayName
		$inc:=1
	End if 
	$obRec.seq:=$inc
	$result_o:=$obRec.save()
End for each 



