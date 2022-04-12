$doChange:=UserInPassWordGroup("EditBOM")
If ($doChange)
	ADD RECORD:C56([BOM:21])
	QUERY:C277([BOM:21]; [BOM:21]itemNum:1=[Item:4]itemNum:1)
	Bom_FillArray(Records in selection:C76([BOM:21]))
	//BOM_ALDefine (eBOMList;1)
	//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)
Else 
	jAlertMessage(-9991)
End if 