//%attributes = {}
vText11:="https://www.webclerk.net/hearth/catalog/SimDura/DuraTech/DT Chimney Pipe.jpg"
vi5:=Position:C15("/hearth/catalog"; vText11)
vText12:=Substring:C12(vText11; 1; vi5-1)+"/CommerceExpert"+Substring:C12(vText11; vi5)
vText12:=Substring:C12(vText12; 1; vi5-1)+"/CommerceExpert"+Substring:C12(vText12; vi5)
vText13:=Replace string:C233(vText12; "/CommerceExpert/CommerceExpert/"; "/CommerceExpert/")

CONFIRM:C162("Fix Image Paths")
If (OK=1)
	vtext1:=Request:C163("Enter password for fixing image paths")
	If ((OK=1) & (vtext1="fix"))
		vi9:=0
		var rec_ent; sel_ent : Object
		sel_ent:=ds:C1482.Item.query("imagePath = :1"; "@https://www.webclerk.net@")
		For each (rec_ent; sel_ent)
			vi5:=Position:C15("/hearth/catalog"; rec_ent.imagePath)
			If (vi5>0)
				vi9:=vi9+1
				rec_ent.imagePath:=Substring:C12(rec_ent.imagePath; 1; vi5-1)+"/CommerceExpert"+Substring:C12(rec_ent.imagePath; vi5)
				// protect against running twice
				rec_ent.imagePath:=Replace string:C233(rec_ent.imagePath; "/CommerceExpert/CommerceExpert/"; "/CommerceExpert/")
				rec_ent.save()
			End if 
		End for each 
		ALERT:C41("Finished fix image path, count: "+String:C10(vi9))
	End if 
End if 
