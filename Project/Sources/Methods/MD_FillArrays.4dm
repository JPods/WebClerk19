//%attributes = {"publishedWeb":true}
//Procedure: MD_FillArrays
C_LONGINT:C283($1; $2; $3; $inc; $sizeRay)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aMdOrdNum; 0)  //[WOdraw]WOKey
		//ALERT(String(Type(aMdOrdNum))+"aMdOrdNum")
		ARRAY TEXT:C222(aMdItemNum; 0)  //[WOdraw]PartNum
		//ALERT(String(Type(aMdItemNum))+"aMdItemNum")
		ARRAY DATE:C224(aWdDateUsed; 0)  //[WOdraw]DateTaken
		//ALERT(String(Type(aWdDateUsed))+"aWdDateUsed")
		ARRAY LONGINT:C221(aWdTimeUsed; 0)  //[WOdraw]TimeTaken
		//ALERT(String(Type(aWdTimeUsed))+"aWdTimeUsed")
		ARRAY REAL:C219(aWdQtyUsed; 0)  //[WOdraw]QtyTaken
		//ALERT(String(Type(aWdQtyUsed))+"aWdQtyUsed")
		ARRAY TEXT:C222(aWdNameID; 0)  //[WOdraw]nameID
		//ALERT(String(Type(aWdNameID))+"aWdNameID")
		ARRAY REAL:C219(aWdUnitCost; 0)  //[WOdraw]Cost
		//ALERT(String(Type(aWdUnitCost))+"aWdUnitCost")
		ARRAY TEXT:C222(aWdNote; 0)  //[WOdraw]Note
		//ALERT(String(Type(aWdNote))+"aWdNote")
		ARRAY TEXT:C222(aWdStatus; 0)  //[WOdraw]Status
		//ALERT(String(Type(aWdStatus))+"aWdStatus")
		ARRAY LONGINT:C221(aWdJobId; 0)  //[WOdraw]JobKey
		//ALERT(String(Type(aWdJobId))+"aWdJobId")
		ARRAY LONGINT:C221(aWdRecNum; 0)  //[WOdraw] record number
		//ALERT(String(Type(aWdRecNum))+"aWdRecNum")
		ARRAY TEXT:C222(aWdReason; 0)
		//ALERT(String(Type(aWdReason))+"aWdCause")
		ARRAY LONGINT:C221(aWdOrdLn; 0)
		//ALERT(String(Type(aWdOrdLn))+"aWdOrdLn")
		//
		ARRAY LONGINT:C221(aMtlLns; 0)
		//ALERT(String(Type(aMtlLns))+"aMtlLns")
	: ($1>0)  //selection to array
		SELECTION TO ARRAY:C260([WOdraw:68]cause:12; aWdReason; [WOdraw:68]orderNum:1; aMdOrdNum; [WOdraw:68]itemNum:2; aMdItemNum; [WOdraw:68]dateTaken:3; aWdDateUsed; [WOdraw:68]timeTaken:4; aWdTimeUsed; [WOdraw:68]qtyTaken:5; aWdQtyUsed; [WOdraw:68]nameid:6; aWdNameID; [WOdraw:68]cost:7; aWdUnitCost; [WOdraw:68]note:8; aWdNote; [WOdraw:68]status:9; aWdStatus; [WOdraw:68]projectNum:10; aWdJobId; [WOdraw:68]; aWdRecNum; [WOdraw:68]salesOrdLine:11; aWdOrdLn)
		$sizeRay:=Size of array:C274(aWdTimeUsed)
		For ($inc; 1; $sizeRay)
			aWdTimeUsed{$inc}:=aWdTimeUsed{$inc}*1
		End for 
	: ($1=-4)
		[WOdraw:68]cause:12:=aWdReason{$2}
		[WOdraw:68]orderNum:1:=aMdOrdNum{$2}
		[WOdraw:68]itemNum:2:=aMdItemNum{$2}
		[WOdraw:68]dateTaken:3:=aWdDateUsed{$2}
		[WOdraw:68]timeTaken:4:=aWdTimeUsed{$2}
		[WOdraw:68]qtyTaken:5:=aWdQtyUsed{$2}
		[WOdraw:68]nameid:6:=aWdNameID{$2}
		[WOdraw:68]cost:7:=aWdUnitCost{$2}
		[WOdraw:68]note:8:=aWdNote{$2}
		[WOdraw:68]status:9:=aWdStatus{$2}
		[WOdraw:68]projectNum:10:=aWdJobId{$2}
		[WOdraw:68]salesOrdLine:11:=aWdOrdLn{$2}
	: ($1=-5)  //array to selection
		// ### bj ### 20181212_2138
		// get rid of this
		ARRAY TO SELECTION:C261(aWdReason; [WOdraw:68]cause:12; aMdOrdNum; [WOdraw:68]orderNum:1; aMdItemNum; [WOdraw:68]itemNum:2; aWdDateUsed; [WOdraw:68]dateTaken:3; aWdTimeUsed; [WOdraw:68]timeTaken:4; aWdQtyUsed; [WOdraw:68]qtyTaken:5; aWdNameID; [WOdraw:68]nameid:6; aWdUnitCost; [WOdraw:68]cost:7; aWdNote; [WOdraw:68]note:8; aWdStatus; [WOdraw:68]status:9; aWdJobId; [WOdraw:68]projectNum:10; aWdOrdLn; [WOdraw:68]salesOrdLine:11)
	: ($1=-1)  //delete an element
		
	: ($1=-3)  //insert an element
		
End case 