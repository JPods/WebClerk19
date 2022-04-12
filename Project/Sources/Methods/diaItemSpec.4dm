//%attributes = {"publishedWeb":true}
//(P) diaItemSpec
//C_POINTER($1)
//TRACE
C_POINTER:C301($1; $2)
If ($1->#"")
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$1->)
	If (Records in selection:C76([Item:4])=1)
		Item_GetSpec(0)
		If (Records in selection:C76([ItemSpec:31])=0)
			CONFIRM:C162("There is no Spec for "+$1->+".  Do you want to create one?")
			If (OK=1)
				[Item:4]specification:42:=True:C214
				SAVE RECORD:C53([Item:4])
				UNLOAD RECORD:C212([Item:4])
				CREATE RECORD:C68([ItemSpec:31])
				
				[ItemSpec:31]itemNum:1:=[Item:4]itemNum:1
				SAVE RECORD:C53([ItemSpec:31])
			End if 
		End if 
		If (Records in selection:C76([ItemSpec:31])>0)
			ProcessTableOpen(-(Table:C252(->[ItemSpec:31])))
		End if 
	End if 
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([ItemSpec:31])
	READ WRITE:C146([ItemSpec:31])
Else 
	ALERT:C41("No Item")
End if 