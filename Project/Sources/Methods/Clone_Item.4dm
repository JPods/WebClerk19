//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/25/10, 11:46:36
// ----------------------------------------------------
// Method: Clone_Item
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
C_TEXT:C284($theItem; $origItem)
C_BOOLEAN:C305($doNewNum)
$doChange:=(UserInPassWordGroup("ItemClone"))
If (Not:C34($doChange))
	jAlertMessage(-9991)
Else 
	If (Count parameters:C259=1)
		If ($1=1)
			$theItem:=[Item:4]itemNum:1+"?"
		Else 
			$theItem:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Item:4]))
		End if 
	Else 
		$doNewNum:=False:C215
		$theItem:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Item:4]))
	End if 
	$doClone:=True:C214
	$theItem:=Request:C163("Clone "+[Item:4]itemNum:1+" with BOM/Spec"; $theItem)
	If (OK=1)
		PUSH RECORD:C176([Item:4])
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$theItem)
		If (Records in selection:C76([Item:4])=0)
			$doCloneWith:=True:C214
		Else 
			ALERT:C41("Item Number exists.")
			$doClone:=False:C215
		End if 
		POP RECORD:C177([Item:4])
		If ($doClone)
			KeyModifierCurrent
			$origItem:=[Item:4]itemNum:1
			DUPLICATE RECORD:C225(ptCurTable->)
			[Item:4]itemNum:1:=$theItem
			srItemNum:=[Item:4]itemNum:1
			[Item:4]qtyOnHand:14:=0
			[Item:4]qtySold:25:=0
			[Item:4]qtyOnPo:20:=0
			[Item:4]qtyOnSalesOrder:16:=0
			[Item:4]costofSales:50:=0
			[Item:4]sales:49:=0
			[Item:4]dtItemDate:33:=DateTime_Enter
			// add objects
			[Item:4]dtReviewed:85:=0
			jDateTimeRecov([Item:4]dtItemDate:33; ->vDate1; ->vTime1)
			jDateTimeRecov([Item:4]dtBestUseStart:102; ->iLoDate6)
			jDateTimeRecov([Item:4]dtBestUseEnd:103; ->iLoDate7)
			jDateTimeRecov([Item:4]dtReviewed:85; ->iLoDate8)
			[Item:4]dateLastCost:54:=!00-00-00!
			OBJECT SET ENTERABLE:C238([Item:4]itemNum:1; True:C214)
			OBJECT SET ENTERABLE:C238(srItemNum; True:C214)
			
			REDUCE SELECTION:C351([ItemXRef:22]; 0)
			REDUCE SELECTION:C351([InventoryStack:29]; 0)
			If ($doCloneWith)
				SAVE RECORD:C53([Item:4])
				If (([Item:4]specification:42) & ([Item:4]specid:62=""))
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=$origItem)
					DUPLICATE RECORD:C225([ItemSpec:31])
					[ItemSpec:31]itemNum:1:=$theItem
					
					SAVE RECORD:C53([ItemSpec:31])
				End if 
				QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$origItem)
				$k:=Records in selection:C76([BOM:21])
				SELECTION TO ARRAY:C260([BOM:21]; aBomRecs)
				For ($i; 1; $k)
					GOTO RECORD:C242([BOM:21]; aBomRecs{$i})
					DUPLICATE RECORD:C225([BOM:21])
					[BOM:21]itemNum:1:=$theItem
					SAVE RECORD:C53([BOM:21])
					UNLOAD RECORD:C212([BOM:21])
				End for 
				QUERY:C277([BOM:21]; [BOM:21]itemNum:1=[Item:4]itemNum:1)
				Bom_FillArray(Records in selection:C76([BOM:21]))
				BOM_BuildMom
				
				
				
				PriceMatrix_FillArrays(Records in selection:C76([PriceMatrix:105]))
				
				QUERY:C277([Document:100]; [Document:100]itemNum:20=[Item:4]itemNum:1)
			Else 
				REDUCE SELECTION:C351([BOM:21]; 0)
				REDUCE SELECTION:C351([ItemSpec:31]; 0)
			End if 
		End if 
	End if 
End if 