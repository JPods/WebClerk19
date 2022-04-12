//%attributes = {"publishedWeb":true}
//Procedure: BOM_AddChildren
// ### jwm ### 20160505_1424 added AcceptBOM creates dBOM record
C_LONGINT:C283($i; $k)
C_TEXT:C284($curItemNum)
C_TEXT:C284($curItemDesc)
$curItemNum:=[Item:4]itemNum:1
$curItemDesc:=[Item:4]description:7
$k:=Size of array:C274(<>aItemLines)
If ($k>0)
	PUSH RECORD:C176([Item:4])
	For ($i; 1; $k)
		GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$i}})
		If ($curItemNum=[Item:4]itemNum:1)
			ALERT:C41("Skip current item number.")
		Else 
			BOM_BuildExtend([Item:4]itemNum:1)
			$w:=Find in array:C230(aRptPartNum; $curItemNum)
			If ($w=-1)
				CREATE RECORD:C68([BOM:21])
				
				[BOM:21]ItemNum:1:=$curItemNum
				[BOM:21]ChildItem:2:=[Item:4]itemNum:1
				[BOM:21]Description:6:=[Item:4]description:7
				[BOM:21]PlanCost:8:=[Item:4]costAverage:13
				[BOM:21]QtyInAssembly:3:=<>rQQAddQty
				//SAVE RECORD([BOM])
				AcceptBOM  // ### jwm ### 20160505_1423
			Else 
				ALERT:C41([Item:4]itemNum:1+" is related to "+$curItemNum)
			End if 
		End if 
	End for 
	POP RECORD:C177([Item:4])
End if 