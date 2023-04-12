//%attributes = {}

// Modified by: Bill James (2022-06-28T05:00:00Z)
// Method: Print_QuickReport
// Description 
// Parameters
// ----------------------------------------------------


#DECLARE($dateClassName : Text)
var $ptTable : Pointer
var $fromEntity : Boolean
$ptTable:=Null:C1517
$fromEntity:=False:C215
If ($dateClassName="")
	If (process_o.dataClassName#Null:C1517)
		$fromEntity:=True:C214
	Else 
		If (ptCurTable#Null:C1517)  // from old oLo
			QR REPORT:C197(ptCurTable->; Char:C90(1))
		Else 
			ALERT:C41("No tableName passed.")
		End if 
	End if 
Else 
	$fromEntity:=True:C214
End if 
If ($fromEntity)
	$ptTable:=STR_GetTablePointer(process_o.dataClassName)
	READ ONLY:C145($ptTable->)
	USE ENTITY SELECTION:C1513(process_o.ents)
	QR REPORT:C197($ptTable->; Char:C90(1))
	REDUCE SELECTION:C351($ptTable->; 0)
	READ WRITE:C146($ptTable->)
End if 


