//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-10T00:00:00, 10:31:59
// ----------------------------------------------------
// Method: ImageItemSpec
// Description
// Modified: 12/10/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($thePath)
If (Records in selection:C76([ItemSpec:31])=0)
	If ([Item:4]specId:62#"")
		QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]specId:62)
		If (Records in selection:C76([ItemSpec:31])=0)
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]itemNum:1)
		End if 
		If (Records in selection:C76([ItemSpec:31])=0)
			CREATE RECORD:C68([ItemSpec:31])
			
			[ItemSpec:31]ItemNum:1:=[Item:4]itemNum:1
			SAVE RECORD:C53([ItemSpec:31])
		End if 
	End if 
End if 
$thePath:=[ItemSpec:31]ImagePath:29
If ([ItemSpec:31]ImagePath:29#"")
	CONFIRM:C162("Change image path?")
	If (OK=1)
		READ PICTURE FILE:C678(""; vItemPict; *)
		If (OK=1)
			[ItemSpec:31]ImagePath:29:=document
			SAVE RECORD:C53([ItemSpec:31])
		End if 
	End if 
Else 
	READ PICTURE FILE:C678(""; vItemPict)
	If (OK=1)
		[ItemSpec:31]ImagePath:29:=document
		SAVE RECORD:C53([ItemSpec:31])
	End if 
End if 

vImagePath:=document


If (False:C215)
	
	
	If (OK=1)
		vImagePath:=document
		If (Record number:C243([ItemSpec:31])>-1)
			[ItemSpec:31]ImagePath:29:=vImagePath
		End if 
		[Item:4]photo:104:=vImagePath
	End if 
	//
	
End if 
If (False:C215)
	C_BOOLEAN:C305($doPicture)
	TRACE:C157
	C_TEXT:C284($thePath)
	$thePath:=[ItemSpec:31]ImagePath:29
	If ([ItemSpec:31]ImagePath:29#"")
		CONFIRM:C162("Change picture path?")
		If (OK=0)
			$thePath:=""
		Else 
			$thePath:=Get_FileName("Locate Image"; "")
		End if 
	Else 
		$thePath:=Get_FileName("Locate Image"; "")
	End if 
	If ($thePath#"")
		[ItemSpec:31]ImagePath:29:=$thePath
		IE_GetPict([ItemSpec:31]ImagePath:29; ->vItemPict)
	End if 
End if 