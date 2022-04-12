//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_TEXT:C284($1)
C_OBJECT:C1216($selection; $2)

$dataClass:=$1  //Name of the table AND the dialog
$params:=$2  //Is there a selection? if yes, use it

$windowRef:=Storage:C1525.windowList[$dataClass]
$windowRef:=Current form window:C827
SHOW WINDOW:C435($windowRef)

If ($params.useSelection)
	If ($params.selection2Use#Null:C1517)
		Form:C1466.displayedSelection:=$params.selection2Use
		If (FORM Get current page:C276=2)
			Form:C1466.currentPage:=1
			FORM GOTO PAGE:C247(Form:C1466.currentPage)
		End if 
		Util25_UpdateSelection("_LB_1")
		Util25_UpdateOnContext
		
	End if 
End if 



