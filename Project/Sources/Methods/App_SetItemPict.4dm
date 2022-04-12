//%attributes = {"publishedWeb":true}
//Method: App_SetItemPict
C_TEXT:C284($fileFold; $testItem)
$fileFold:=Get_FolderName("Select folder to locate images.")
If ($fileFold#"")
	vText1:=""
	$error:=HFS_CatToArray($fileFold; "aText1")
	C_LONGINT:C283($i; $k; $p)
	$k:=Size of array:C274(aText1)
	For ($i; 1; $k)
		$p:=Position:C15(".gif"; aText1{$i})
		If ($p=0)
			$p:=Position:C15(".jpg"; aText1{$i})
		End if 
		If ($p>0)
			$testItem:=Substring:C12(aText1{$i}; 1; $p-1)
			QUERY:C277([Item:4]; [Item:4]barCode:34=$testItem)
			If (Records in selection:C76([Item:4])=1)
				[Item:4]vendorId:45:=$testItem
				SAVE RECORD:C53([Item:4])
			End if 
		End if 
	End for 
End if 
//
