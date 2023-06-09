//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_COLLECTION:C1488($colFound; $collection_Main; $collection_Sel)
C_OBJECT:C1216($collection_Cur)
C_LONGINT:C283($collection_Pos)
C_TEXT:C284($LBName)

$LBName:=$1

//Instead of passing parameters like ;Form.data_Numbers;Form.cur_Numbers;Form.sel_Numbers;Form.pos_Numbers)...
//..We can get the different collections from the Object objectEditor itself

$fieldName:=Form:C1466.objectFieldName

$collection_Main:=Form:C1466["data_"]  //This is exactly the same than Form.data_Numbers or Form.data_Optional_Data
$collection_Cur:=Form:C1466["cur_"]
$collection_Sel:=Form:C1466["sel_"]
$collection_Pos:=Form:C1466["pos_"]
$event:=Form event code:C388

If ($event=On Clicked:K2:4)
	If ($collection_Sel.length>0)
		If ($collection_Cur#Null:C1517)
			CONFIRM:C162(Util25_Get_LocalizedMessage("RemoveProperty"; $collection_Cur.Property); Get localized string:C991("Remove it"); Get localized string:C991("Cancel"))
			
			If (OK=1)
				$collection_Main.remove($collection_Pos-1)
				$collection_Main:=$collection_Main
				LISTBOX SELECT ROW:C912(*; $LBName; 0; lk remove from selection:K53:3)
			End if 
		End if 
	End if 
End if 
