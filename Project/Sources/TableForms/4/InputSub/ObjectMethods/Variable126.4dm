$doChange:=UserInPassWordGroup("EditBOM")
If ($doChange)
	If (Size of array:C274(<>aItemLines)>0)
		C_TEXT:C284($curItemNum)
		$curItemNum:=[Item:4]itemNum:1
		BOM_AddChildren
		If (b44=1)
			BOM_BuildExtend([Item:4]itemNum:1)
		Else 
			QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$curItemNum)
			Bom_FillArray(Records in selection:C76([BOM:21]))
			//BOM_ALDefine (eBOMList;1)
			//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)
		End if 
	Else 
		ALERT:C41("Use Quick Quotes to select items.")
	End if 
Else 
	jAlertMessage(-9991)
End if 