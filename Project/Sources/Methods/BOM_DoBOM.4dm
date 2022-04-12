//%attributes = {}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 09/22/09, 10:29:13
// ----------------------------------------------------
// Method: BOM_DoBOM
// Description
// 
//
// Parameters
// ----------------------------------------------------

[Item:4]bomHasChild:48:=False:C215

BOM_BuildMom  //build parent list

If (bExtendedBOM=0)  //extended BOM is false
	//build single level BOM
	QUERY:C277([BOM:21]; [BOM:21]itemNum:1=[Item:4]itemNum:1)
	Bom_FillArray(Records in selection:C76([BOM:21]))
Else   //extended BOM is true
	//build multi-level BOM
	BOM_BuildExtend([Item:4]itemNum:1)
End if 

If (Records in selection:C76([BOM:21])>0)
	[Item:4]bomHasChild:48:=True:C214
End if 

//BOM_ALDefine (eBOMList;1)
//BOM_ALDefineParent (eParentList;1)
//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)
//  --  CHOPPED  AL_UpdateArrays(eParentList; -2)