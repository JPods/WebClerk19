//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/05/16, 14:56:04
// ----------------------------------------------------
// Method: DeleteBOM
// Description
// 
//
// Parameters
// ----------------------------------------------------
$doChange:=(UserInPassWordGroup("EditBOM"))
If ($doChange)
	CONFIRM:C162("Delete, there is no UnDo?")
	If (OK=1)
		SORT ARRAY:C229(aBomSelect)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(aBomSelect)
		For ($i; $k; 1; -1)
			GOTO RECORD:C242([BOM:21]; aBomRecs{aBomSelect{$i}})
			LOAD RECORD:C52([BOM:21])
			If (Locked:C147([BOM:21]))
				jAlertMessage(10011)
			Else 
				// ### jwm ### 20160505_1453 create dBOM when deleting BOM
				C_TEXT:C284($comment)
				$comment:=""
				CREATE RECORD:C68([DBOM:129])
				
				[DBOM:129]dtEvent:7:=DateTime_Enter
				[DBOM:129]changedBy:10:=Current user:C182
				[DBOM:129]itemParent:3:=Old:C35([BOM:21]itemNum:1)
				[DBOM:129]itemChild:4:=Old:C35([BOM:21]childItem:2)
				[DBOM:129]itemParentNew:5:=[BOM:21]itemNum:1
				[DBOM:129]itemChildNew:6:=[BOM:21]childItem:2
				[DBOM:129]quantityOld:8:=Old:C35([BOM:21]qtyInAssembly:3)
				[DBOM:129]quantityNew:9:=[BOM:21]qtyInAssembly:3
				[DBOM:129]reason:11:="BOM Deleted"
				$comment:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+[DBOM:129]reason:11+"\r"
				[DBOM:129]comment:12:=[DBOM:129]comment:12+$comment  // append
				SAVE RECORD:C53([DBOM:129])
				UNLOAD RECORD:C212([DBOM:129])
				
				DELETE RECORD:C58([BOM:21])
				Bom_FillArray(-1; aBomSelect{$i}; 1)
			End if 
		End for 
		ARRAY LONGINT:C221(aBomSelect; 0)
		//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)
	End if 
Else 
	jAlertMessage(-9991)
End if 