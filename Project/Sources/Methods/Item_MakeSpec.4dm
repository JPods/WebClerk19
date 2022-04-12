//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Item_MakeSpec  
	//Date: 07/01/02
	//Who: Bill
	//Description: Create Item Spec Record
End if 
//
If (Records in selection:C76([ItemSpec:31])=0)
	CREATE RECORD:C68([ItemSpec:31])
	
	If ([Item:4]specId:62="")
		[ItemSpec:31]ItemNum:1:=[Item:4]itemNum:1
	Else 
		[ItemSpec:31]ItemNum:1:=[Item:4]specId:62
	End if 
	[Item:4]specification:42:=True:C214
	SAVE RECORD:C53([ItemSpec:31])
	SAVE RECORD:C53([Item:4])
End if 