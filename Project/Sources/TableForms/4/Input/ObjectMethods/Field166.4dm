C_LONGINT:C283($grpSpec; $itemSpec)
$grpSpec:=-1
$itemSpec:=-1
TRACE:C157
If ([Item:4]specId:62#"")
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]specId:62)
	If (Records in selection:C76([ItemSpec:31])>0)
		$grpSpec:=Record number:C243([ItemSpec:31])
	End if 
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]itemNum:1)
	If (Records in selection:C76([ItemSpec:31])>0)
		$itemSpec:=Record number:C243([ItemSpec:31])
	End if 
	Case of 
		: (($grpSpec>-1) & ($itemSpec>-1))
			CONFIRM:C162("Delete ItemNum ItemSpec, use SpecID ItemSpec?")
			If (OK=1)
				GOTO RECORD:C242([ItemSpec:31]; $itemSpec)
				DELETE RECORD:C58([ItemSpec:31])
				GOTO RECORD:C242([ItemSpec:31]; $grpSpec)
			Else 
				CONFIRM:C162("Delete SpecID ItemSpec, use ItemNum ItemSpec?")
				If (OK=1)
					GOTO RECORD:C242([ItemSpec:31]; $grpSpec)
					DELETE RECORD:C58([ItemSpec:31])
					GOTO RECORD:C242([ItemSpec:31]; $itemSpec)
					[ItemSpec:31]ItemNum:1:=[Item:4]specId:62
					SAVE RECORD:C53([ItemSpec:31])
				Else 
					ALERT:C41("No changes to ItemSpec, ItemNum ItemSpec remains an orphan.")
				End if 
			End if 
		: (($grpSpec=-1) & ($itemSpec>-1))
			GOTO RECORD:C242([ItemSpec:31]; $itemSpec)
			[ItemSpec:31]ItemNum:1:=[Item:4]specId:62
			SAVE RECORD:C53([ItemSpec:31])
		: (($grpSpec>-1) & ($itemSpec=-1))
			GOTO RECORD:C242([ItemSpec:31]; $grpSpec)
		Else 
			CREATE RECORD:C68([ItemSpec:31])
			
			[ItemSpec:31]ItemNum:1:=[Item:4]specId:62
			SAVE RECORD:C53([ItemSpec:31])
	End case 
	[Item:4]specification:42:=True:C214
Else 
	QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]itemNum:1)
	If (Records in selection:C76([ItemSpec:31])>0)
		[Item:4]specification:42:=True:C214
	Else 
		[Item:4]specification:42:=False:C215
	End if 
End if 
If (Record number:C243([ItemSpec:31])>0)
	$setState:=True:C214
Else 
	$setState:=False:C215
End if 
C_LONGINT:C283($fileNum; $k; $i)
$fileNum:=Table:C252(->[ItemSpec:31])
$k:=Get last field number:C255(->[ItemSpec:31])
For ($i; 1; $k)
	OBJECT SET ENTERABLE:C238(Field:C253($fileNum; $i)->; $setState)
End for 
