//%attributes = {"publishedWeb":true}
//Procedure: List_PplOrdLns
C_LONGINT:C283($0; $3)
C_LONGINT:C283($i; $k; $w; $incItem; $cntItem; $incRay; $incRay; $sizeRay; $docID)
C_TEXT:C284($2)
$doCustomer:=($2#"")
$popOrd:=False:C215
$popPp:=False:C215
Case of 
	: ($3=0)
		$cntItem:=Size of array:C274(aItemLines)
		ARRAY TEXT:C222(aXItemNum; 0)
		For ($i; 1; $cntItem)
			aXItemNum{$i}:=aLsItemNum{aItemLines{$i}}
		End for 
	: (($3=1) & ($2=""))
		$cntItem:=0
	Else 
		$cntItem:=1
End case 
If ($cntItem>0)
	If ($1>0)
		// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Description"; "Qty"; "Unit Price"; "Disc"; "Days"; "")
		// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Doc"; "Customer"; "")
		// -- AL_SetWidths($1; 1; 8; 10; 50; 54; 48; 48; 20; <>wAlDate; 3)
		// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; <>wAlDate; 58; 200; 30)
		// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)  //$columnCnt;0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		//// -- AL_SetRowColor ($1;0;"Black";0;"white";0)
		If (Size of array:C274(aLsSrRec)>1)
			// -- AL_SetSort($1; 2; -7)
		End if 
		//  --  CHOPPED  AL_UpdateArrays($1; -2)
	End if 
	List_RaySize(0)
	Case of 
		: ((vhere>1) & ((ptCurTable=(->[Order:3])) | ((ptCurTable=(->[Invoice:26])) & ([Invoice:26]idNumOrder:1#1))))
			$popOrd:=True:C214
			$docID:=[Order:3]idNum:2
			PUSH RECORD:C176([Order:3])
		: ((vhere>1) & (ptCurTable=(->[Proposal:42])))
			PUSH RECORD:C176([Proposal:42])
			$popPp:=True:C214
			$docID:=[Proposal:42]idNum:5
	End case 
	For ($incItem; 1; $cntItem)
		Case of 
			: ($3=1)
				QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=$2)
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]customerID:42=$2)
			: ($doCustomer)
				QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=$2; *)
				QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=aXItemNum{$incItem})
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]customerID:42=$2; *)
				QUERY:C277([ProposalLine:43];  & [ProposalLine:43]itemNum:2=aXItemNum{$incItem})
			Else 
				QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=aXItemNum{$incItem})
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]itemNum:2=aXItemNum{$incItem})
		End case 
		$k:=Records in selection:C76([OrderLine:49])
		If ($k>0)
			SELECTION TO ARRAY:C260([OrderLine:49]idNumOrder:1; aTmpLong1; [OrderLine:49]itemNum:4; aTmp35Str1; [OrderLine:49]description:5; aTmp80Str1; [OrderLine:49]qty:6; aTmpReal1; [OrderLine:49]unitPrice:9; aTmpReal2; [OrderLine:49]discount:10; aTmpReal3; [OrderLine:49]dateRequired:23; aTmpDate1)
			
			$w:=Size of array:C274(aLsSrRec)
			$sizeRay:=$w+$k
			$w:=$w+1
			List_RaySize($w; $k; 1)
			$i:=0
			For ($incRay; $w; $sizeRay)
				$i:=$i+1
				aLsItemNum{$incRay}:=aTmp35Str1{$i}
				aLsItemDesc{$incRay}:=aTmp80Str1{$i}
				aLsQtyOH{$incRay}:=aTmpReal1{$i}
				aLsQtySO{$incRay}:=aTmpReal2{$i}
				aLsQtyPO{$incRay}:=aTmpReal3{$i}
				aLsDate{$incRay}:=aTmpDate1{$i}
				If (aLsDate{$incRay}=!00-00-00!)
					aLsDate{$incRay}:=!1901-01-01!
				End if 
				If ($doCustomer)
					If (aTmpLong1{$i}#[Order:3]idNum:2)
						QUERY:C277([Order:3]; [Order:3]idNum:2=aTmpLong1{$i})
					End if 
					aLsText2{$incRay}:=[Order:3]billToCompany:76
				End if 
				aLsText1{$incRay}:=String:C10(aTmpLong1{$i})
				aLsSrRec{$incRay}:=-1  //Record number([Item])
				aLsDocType{$incRay}:="ol"
				aLsLeadTime{$incRay}:=Current date:C33-aTmpDate1{$i}
				aLsDiscount{$incRay}:=0
				aLsDiscountPrice{$incRay}:=0
			End for 
		End if 
		$k:=Records in selection:C76([ProposalLine:43])
		If ($k>0)
			
			SELECTION TO ARRAY:C260([ProposalLine:43]idNumProposal:1; aTmpLong1; [ProposalLine:43]itemNum:2; aTmp35Str1; [ProposalLine:43]description:4; aTmp80Str1; [ProposalLine:43]qty:3; aTmpReal1; [ProposalLine:43]unitPrice:15; aTmpReal2; [ProposalLine:43]discount:17; aTmpReal3; [ProposalLine:43]dateExpected:41; aTmpDate1)
			
			$w:=Size of array:C274(aLsSrRec)  // get the existing size of array
			$sizeRay:=$w+$k  // calc total size needed
			$w:=$w+1  // add one to the existing size of array
			List_RaySize($w; $k)
			$i:=0
			For ($incRay; $w; $sizeRay)
				$i:=$i+1
				aLsItemNum{$incRay}:=aTmp35Str1{$i}
				aLsItemDesc{$incRay}:=aTmp80Str1{$i}
				aLsQtyOH{$incRay}:=aTmpReal1{$i}
				aLsQtySO{$incRay}:=aTmpReal2{$i}
				aLsQtyPO{$incRay}:=aTmpReal3{$i}
				aLsDate{$incRay}:=aTmpDate1{$i}
				If (aLsDate{$incRay}=!00-00-00!)
					aLsDate{$incRay}:=!1901-01-01!
				End if 
				If ($doCustomer)
					If (aTmpLong1{$i}#[Proposal:42]idNum:5)
						QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=aTmpLong1{$i})
					End if 
					aLsText2{$incRay}:=[Proposal:42]bill2Company:57
				End if 
				aLsText1{$incRay}:=String:C10(aTmpLong1{$i})
				aLsSrRec{$incRay}:=-1  //Record number([Item])
				aLsDocType{$incRay}:="ppl"
				aLsLeadTime{$incRay}:=Current date:C33-aTmpDate1{$i}
				aLsDiscount{$incRay}:=0
				aLsDiscountPrice{$incRay}:=0
			End for 
		End if 
	End for 
	Case of 
		: ($popOrd)
			POP RECORD:C177([Order:3])
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=$docID)
		: ($popPp)
			POP RECORD:C177([Proposal:42])
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=$docID)
	End case 
	
	ARRAY TEXT:C222(aXItemNum; 0)
End if 
If ($1>0)
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 
