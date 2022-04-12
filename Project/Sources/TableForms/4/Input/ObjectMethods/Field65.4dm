C_BOOLEAN:C305($setState; $doState)
C_LONGINT:C283($i; $k; $fileNum)
$doState:=False:C215
If ([Item:4]specification:42)
	If ([Item:4]specId:62="")
		QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]itemNum:1)
	Else 
		QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]specId:62)
	End if 
	If ((Records in selection:C76([ItemSpec:31])=0) & ([Item:4]itemNum:1#""))
		CREATE RECORD:C68([ItemSpec:31])
		
		If ([Item:4]specId:62="")
			[ItemSpec:31]ItemNum:1:=[Item:4]itemNum:1
		Else 
			[ItemSpec:31]ItemNum:1:=[Item:4]specId:62
		End if 
		SAVE RECORD:C53([ItemSpec:31])
	End if 
	$doState:=True:C214
	$setState:=True:C214
Else 
	If (Records in selection:C76([ItemSpec:31])=1)
		CONFIRM:C162("Delete the Item Specification?!?")
		If (OK=1)
			CONFIRM:C162("Delete, there is no UnDo?!?")
			If (OK=1)
				DELETE RECORD:C58([ItemSpec:31])
				$setState:=False:C215
				$doState:=True:C214
			End if 
		Else 
			[Item:4]specification:42:=True:C214
		End if 
	End if 
End if 
If ($doState)
	$fileNum:=Table:C252(->[ItemSpec:31])
	$k:=Get last field number:C255(->[ItemSpec:31])
	For ($i; 1; $k)
		OBJECT SET ENTERABLE:C238(Field:C253($fileNum; $i)->; $setState)
	End for 
End if 
//