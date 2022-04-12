//%attributes = {"publishedWeb":true}
C_TEXT:C284($ComPart; $SupPart)
C_LONGINT:C283($w; $k)
//TRACE
Case of 
	: ([BOM:21]ItemNum:1=[BOM:21]ChildItem:2)
		ALERT:C41("A parent cannot be its own child.")
		[BOM:21]ChildItem:2:=""
	: (Not:C34(([BOM:21]ChildItem:2="") | ([BOM:21]ItemNum:1="")))
		$ComPart:=[BOM:21]ChildItem:2
		$SupPart:=[BOM:21]ItemNum:1
		PUSH RECORD:C176([BOM:21])
		BOM_BuildExtend($ComPart)
		ARRAY TEXT:C222(aItemNum; 0)  //clear the parent for this BOM item
		$w:=Find in array:C230(aRptPartNum; $SupPart)
		$k:=0
		ARRAY TEXT:C222(aRptPartNum; $k)
		ARRAY LONGINT:C221(aBOMLevel; $k)  //Depth in BOM
		ARRAY REAL:C219(aQtyPlan; $k)  //Needed at this BOM Point        aQtyPlan
		ARRAY REAL:C219(aQtyAct; $k)  //Multiple at this BOM Point  aQtyAct
		ARRAY LONGINT:C221(aBOMPlace; $k)  //keeps the place in line        aBOMPlace
		ARRAY TEXT:C222(aChecks; $k)  //                                    aChecks
		ARRAY REAL:C219(aCosts; $k)
		REDUCE SELECTION:C351([BOM:21]; 0)  //clear the records in selection for this child item.
		POP RECORD:C177([BOM:21])
		If ($w=-1)
			PUSH RECORD:C176([Item:4])
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]ChildItem:2)
			If (Records in selection:C76([Item:4])=1)
				If (ptCurTable=(->[BOM:21]))
					[BOM:21]ChildItem:2:=[Item:4]itemNum:1
					[BOM:21]Description:6:=[Item:4]description:7
					v2:=[Item:4]unitOfMeasure:11
					vi1:=[Item:4]location:9
					vr1:=[Item:4]leadTimeSales:12
					vr2:=[Item:4]qtySaleDefault:15
					vr3:=[Item:4]qtyOnHand:14
					vr4:=[Item:4]qtyOnSalesOrder:16
					vr5:=[Item:4]qtyOnPo:20
					vr6:=[Item:4]weightAverage:8
					vr7:=[Item:4]costAverage:13
					[BOM:21]PlanCost:8:=[Item:4]costAverage:13
					$unitMeasBy:=1
					If (v2#"")  // Modified by: williamjames (111216 checked for <= length protection)
						If (v2[[1]]="*")
							//Jan 11, 1997
							C_REAL:C285($unitMeasBy)
							$unitMeasBy:=Item_PricePer(->v2)
						End if 
					End if 
					[BOM:21]PlanExtCost:9:=[BOM:21]PlanCost:8*[BOM:21]QtyInAssembly:3/$unitMeasBy
				Else 
					SAVE RECORD:C53([BOM:21])
				End if 
				UNLOAD RECORD:C212([Item:4])
			Else 
				ALERT:C41("The item card could not be found for Item "+[BOM:21]ChildItem:2+".")
				[BOM:21]ChildItem:2:=Old:C35([BOM:21]ChildItem:2)
				HIGHLIGHT TEXT:C210([BOM:21]ChildItem:2; 1; 15)
			End if 
			POP RECORD:C177([Item:4])
		Else 
			ALERT:C41("CANCELED, the Child Part;  "+[BOM:21]ChildItem:2+" is already listed as a Parent to Item Number "+[BOM:21]ItemNum:1+".")
			[BOM:21]ChildItem:2:=Old:C35([BOM:21]ChildItem:2)
		End if 
End case 