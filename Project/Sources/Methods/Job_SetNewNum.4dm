//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_POINTER:C301($ptJob)
//$ptJob:=Nil
Case of 
	: ($1=(->[Order:3]))
		$ptJob:=->[Order:3]projectNum:50
	: ($1=(->[Service:6]))
		$ptJob:=->[Service:6]ProjectNum:28
	: ($1=(->[Invoice:26]))
		$ptJob:=->[Invoice:26]projectNum:50
	: ($1=(->[InventoryStack:29]))
		$ptJob:=->[InventoryStack:29]ProjectNum:4
	: ($1=(->[PO:39]))
		$ptJob:=->[PO:39]projectNum:6
	: ($1=(->[Proposal:42]))
		$ptJob:=->[Proposal:42]projectNum:22
	: ($1=(->[QQQTime:56]))
		$ptJob:=->[QQQTime:56]ProjectNum:2
End case 
If (Not:C34(Is nil pointer:C315($ptJob)))
	If ($ptJob->=0)
		$ptJob->:=[Project:24]projectNum:1
	End if 
End if 