//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: ImageGetPict
// Description 
// Parameters
// ----------------------------------------------------

CLEAR VARIABLE:C89(vItemPict)
If (process_o.image=Null:C1517)
	process_o.image:=New object:C1471
End if 
Case of 
	: (process_o.ents.ItemSpec.imagePath#Null:C1517)
		process_o.image.item:=New object:C1471("path"; process_o.ents.ItemSpec.imagePath)
	: (process_o.ents.Item.imagePath#"")
		process_o.image.item:=New object:C1471("path"; process_o.ents.Item.imagePath)
	Else 
		vImagePath:=""
End case 
Case of 
	: (process_o.image.item=Null:C1517)
		
	: (process_o.image.item=Null:C1517)
		IE_GetPict(process_o.image.item.path; ->vItemPict)
End case 

