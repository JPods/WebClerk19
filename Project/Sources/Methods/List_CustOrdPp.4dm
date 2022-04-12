//%attributes = {"publishedWeb":true}
//Procedure: List_CustOrdPp 
C_TEXT:C284($2)  //use @ to do all items
C_TEXT:C284($3)
C_LONGINT:C283($6; $4; $5)
C_BOOLEAN:C305($doCustomer)
//$1 = areaList to update
//$2 = item num
//$3 = Customer id  list multiple customers if ""
//$4 = Ord Lines 
//$5 = Pp Lines 
List_RaySize(0)
C_LONGINT:C283($i; $k; $w; $rangeOrd; $rangePp)
//$doCustomer:=False
//If ((ptCurFile=([Customer]))|(ptCurFile=([Order]))|(ptCurFile=(
//[Invoice]))|(ptCurFile=([Proposal])))
//$doCustomer:=True
//End if 
If (($4=1) & (Record number:C243([Order:3])>-1))
	PUSH RECORD:C176([Order:3])
	$doOrdPop:=True:C214
End if 
If (($5=1) & (Record number:C243([Proposal:42])>-1))
	PUSH RECORD:C176([Proposal:42])
	$doPpPop:=True:C214
	
End if 
If ($4=1)  //do ord lines
	If ($3#"")  //0 to list only this customer
		QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=$3; *)
	End if 
	QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=$2)
	$k:=Records in selection:C76([OrderLine:49])
	$w:=$k-<>tcMaxArray
	If ((OptKey=0) & ($w>0))
		SELECTION RANGE TO ARRAY:C368($w; $k; [OrderLine:49]idNumOrder:1; aLsSrRec; [OrderLine:49]customerID:2; aTmp10Str1; [OrderLine:49]itemNum:4; aLsItemNum; [OrderLine:49]description:5; aLsItemDesc; [OrderLine:49]qty:6; aLsQtyOH; [OrderLine:49]unitPrice:9; aLsQtySO; [OrderLine:49]discount:10; aLsQtyPO; [OrderLine:49]dateRequired:23; aLsDate; [OrderLine:49]unitCost:12; aLsCost)
	Else 
		SELECTION TO ARRAY:C260([OrderLine:49]idNumOrder:1; aLsSrRec; [OrderLine:49]customerID:2; aTmp10Str1; [OrderLine:49]itemNum:4; aLsItemNum; [OrderLine:49]description:5; aLsItemDesc; [OrderLine:49]qty:6; aLsQtyOH; [OrderLine:49]unitPrice:9; aLsQtySO; [OrderLine:49]discount:10; aLsQtyPO; [OrderLine:49]dateRequired:23; aLsDate; [OrderLine:49]unitCost:12; aLsCost)
	End if 
	ARRAY TEXT:C222(aLsText1; $k)
	ARRAY TEXT:C222(aLsText2; $k)
	ARRAY LONGINT:C221(aLsSrRec; $k)  //Record number([Item])
	ARRAY TEXT:C222(aLsDocType; $k)
	ARRAY LONGINT:C221(aLsLeadTime; $k)
	ARRAY REAL:C219(aLsPrice; $k)
	ARRAY REAL:C219(aLsMargin; $k)
	For ($i; 1; $k)
		If ($4=1)
			If (Abs:C99(aLsSrRec{$i})#[Order:3]idNum:2)
				QUERY:C277([Order:3]; [Order:3]idNum:2=Abs:C99(aLsSrRec{$i}))
			End if 
			aLsText2{$i}:=[Order:3]billToCompany:76
		Else 
			aLsText2{$i}:=aTmp10Str1{$i}
		End if 
		aLsText1{$i}:=aTmp10Str1{$i}
		aLsSrRec{$i}:=-aLsSrRec{$i}  //Record number([Item])
		aLsDocType{$i}:="ol"
		aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
	End for   //use "h" to trigger a search  
End if 
//
If ($5=1)
	If ($w<0)
		$w:=-$w
		If ($3#"")
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]customerID:42=[Customer:2]customerID:1; *)
		End if 
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]itemNum:2=$1)
		$k:=Records in selection:C76([ProposalLine:43])
		SELECTION TO ARRAY:C260([ProposalLine:43]idNumProposal:1; aTmpLong1; [ProposalLine:43]customerID:42; aTmp10Str1; [ProposalLine:43]itemNum:2; aTmp35Str1; [ProposalLine:43]description:4; aTmp80Str1; [ProposalLine:43]qty:3; aTmpReal1; [ProposalLine:43]unitPrice:15; aTmpReal2; [ProposalLine:43]discount:17; aTmpReal3; [ProposalLine:43]dateExpected:41; aTmpDate1; [ProposalLine:43]unitCost:7; aTmpReal4)
		$k:=Size of array:C274(aTmpLong1)
		For ($i; 1; $k)
			$w:=Size of array:C274(aLsSrRec)+1
			List_RaySize($w; 1)
			aLsSrRec{$w}:=-aTmpLong1{$i}
			aLsItemNum{$w}:=aTmp35Str1{$i}
			aLsItemDesc{$w}:=aTmp80Str1{$i}
			aLsText1{$i}:=aTmp10Str1{$i}
			aLsQtyOH{$w}:=aTmpReal1{$i}
			aLsQtySO{$w}:=aTmpReal2{$i}
			aLsQtyPO{$w}:=aTmpReal3{$i}
			aLsCost{$w}:=aTmpReal4{$i}
			aLsDate{$w}:=aTmpDate1{$i}
			If ($doCustomer)
				If (Abs:C99(aLsSrRec{$i})#[Proposal:42]idNum:5)
					QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=Abs:C99(aLsSrRec{$i}))
				End if 
				aLsText2{$i}:=[Order:3]billToCompany:76
			End if 
			aLsSrRec{$i}:=-1  //Record number([Item])
			aLsDocType{$i}:="ol"
			aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
		End for   //use "h" to trigger a search        
	End if 
End if 
//
If ($doOrdPop)
	POP RECORD:C177([Order:3])
End if 
If ($doPpPop)
	POP RECORD:C177([Proposal:42])
End if 
If ($1>0)
	// -- AL_SetHeaders($1; 1; 14; "T"; "Item Number"; "Description"; "Qty"; "Unit Cost"; ""; "Days"; ""; ""; ""; "Date"; ""; "Customer"; "")
	// -- AL_SetWidths($1; 1; 14; 10; 3; 3; 48; 48; 3; <>wAlDate; 3; 3; 3; <>wAlDate; 3; 200; 30)
	//// -- AL_SetSort ($1;-11)//sorted before it is filled
	// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)  //$columnCnt;0)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 