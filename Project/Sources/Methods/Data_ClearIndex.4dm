//%attributes = {"publishedWeb":true}
C_LONGINT:C283($incTables; $cntTables; $cntFld; $indexFld)
C_TEXT:C284($textResult)

C_LONGINT:C283($typeFld; $lenField; $numFld; $k)
C_BOOLEAN:C305($indexed)
ARRAY LONGINT:C221($aFileNums; 0)
TRACE:C157
$cntTables:=Get last table number:C254
For ($incTables; 1; $cntTables)
	KeyModifierCurrent
	$textResult:=Request:C163(Table name:C256($incTables)+" "+String:C10($incTables)+" Cancel Clears Indexes"; "Cancel")
	If (OptKey=1)
		$incTables:=$cntTables
	End if 
	If (OK=0)
		INSERT IN ARRAY:C227($aFileNums; 1; 1)
		$aFileNums{1}:=$incTables
	End if 
End for 
$cntTables:=Size of array:C274($aFileNums)
For ($incTables; 1; $cntTables)
	ALL RECORDS:C47(Table:C252($aFileNums{$incTables})->)
	$cntFld:=Get last field number:C255($aFileNums{$incTables})
	MESSAGE:C88(String:C10($incTables)+" of "+String:C10($cntTables))
	For ($indexFld; 1; $cntFld)
		GET FIELD PROPERTIES:C258($aFileNums{$incTables}; $indexFld; $typeFld; $lenField; $indexed)  // file #, field #, type, length, index
		If ($indexed)
			SET INDEX:C344(Field:C253($aFileNums{$incTables}; $indexFld)->; False:C215)
		End if 
	End for 
End for 

REDRAW WINDOW:C456