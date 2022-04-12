//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($selection)

$selection:=$1

If (FORM Get current page:C276=2)
	FORM GOTO PAGE:C247(1)
End if 

Form:C1466.displayedSelection:=$selection

Util25_UpdateSelection("_LB_1")
Util25_UpdateOnContext(1)  //Because the FORM Get current page will return 2 for it's updated only after display


