//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_LONGINT:C283($column;$row)
C_COLLECTION:C1488($colFound;$collection_Main;$collection_Sel)
C_OBJECT:C1216($1)
C_LONGINT:C283($collection_Pos)
C_TEXT:C284($LBName)

$this:=$1
$LBName:=$2

$event:=FORM Event:C1606

Case of 
	: (($event.code=On Clicked:K2:4) | ($event.code=On Double Clicked:K2:5))
		If (Right click:C712 | Contextual click:C713 | ($event.code=On Double Clicked:K2:5))
			If (Not:C34(This:C1470.entityIsReadOnly))
				LISTBOX GET CELL POSITION:C971(*;$LBName;$column;$row)
				action_Property_Add ($LBName)
			End if 
		End if 
End case 
