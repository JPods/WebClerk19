TRACE:C157
C_LONGINT:C283($k; $i; $w; $iBom; $cntBom)
C_DATE:C307($cutDate)
C_TEXT:C284($dateStr)
MESSAGES OFF:C175
CONFIRM:C162("This will take a while.")
If (OK=1)
	CREATE EMPTY SET:C140([Item:4]; "CurItems")
	CREATE EMPTY SET:C140([OrderLine:49]; "FC_Ord")
	CREATE EMPTY SET:C140([POLine:40]; "FC_Po")
	CREATE EMPTY SET:C140([ProposalLine:43]; "FC_Pp")
	CREATE EMPTY SET:C140([WorkOrder:66]; "FC_Wo")
	CREATE EMPTY SET:C140([OrderLine:49]; "FC_TmpOrd")
	CREATE EMPTY SET:C140([POLine:40]; "FC_TmpPo")
	CREATE EMPTY SET:C140([ProposalLine:43]; "FC_TmpPp")
	CREATE EMPTY SET:C140([WorkOrder:66]; "FC_TmpWo")
	//array TEXT(a20Str1;0)
	For ($i; Size of array:C274(aFCRecNum); 1; -1)
		If (aFCTypeTran{$i}#"IT")
			FC_FillRay(-1; $i; 1)  //fix 3/15/02 dan - changed $1 to $i (there is no $1)
		End if 
	End for 
	//
	If (Size of array:C274(aFCRecNum)>0)
		C_BOOLEAN:C305($bAccountForQtyOnHand)
		//CONFIRM("Do you want to account for Quantity on Hand?")
		$bAccountForQtyOnHand:=False:C215  //(OK=1)
		TRACE:C157
		For ($i; 1; Size of array:C274(aFCRecNum))
			If (aFCTypeTran{$i}="IT")
				BOM_BuildExtend(aFCItem{$i})
				$cntBom:=Size of array:C274(aRptPartNum)
				For ($iBom; 1; $cntBom)
					$w:=Find in array:C230(aFCItem; aRptPartNum{$iBom})
					If ($w=-1)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=aRptPartNum{$iBom})
						If (Records in selection:C76([Item:4])=1)
							BOM_NeedExpand([Item:4]itemNum:1; [Item:4]qtyOnHand:14; !00-00-00!; "Item Record"; ""; "IT"; 0; Record number:C243([Item:4]); ->[Item:4]vendorID:45)
						End if 
					End if 
				End for 
			End if 
		End for 
		
		ARRAY TEXT:C222(aBOMQtyLookupItemNum; 0)
		ARRAY REAL:C219(aBOMQtyLookupQtyOnHand; 0)
		
		COPY ARRAY:C226(aFCItem; aBOMQtyLookupItemNum)
		COPY ARRAY:C226(aFCBomCnt; aBOMQtyLookupQtyOnHand)
		//  
		For ($i; 1; Size of array:C274(aFCRecNum))
			If (aFCItem{$i}#"")
				QUERY:C277([OrderLine:49]; [OrderLine:49]qtyBackLogged:8#0; *)
				QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=aFCItem{$i})
				CREATE SET:C116([OrderLine:49]; "FC_TmpOrd")
				UNION:C120("FC_Ord"; "FC_TmpOrd"; "FC_Ord")
				CLEAR SET:C117("FC_TmpOrd")
				//
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]itemNum:2=aFCItem{$i}; *)
				QUERY:C277([ProposalLine:43];  & [ProposalLine:43]complete:35=False:C215; *)
				QUERY:C277([ProposalLine:43];  & [ProposalLine:43]calculateLine:20=True:C214)
				CREATE SET:C116([ProposalLine:43]; "FC_TmpPp")
				UNION:C120("FC_Pp"; "FC_TmpPp"; "FC_Pp")
				CLEAR SET:C117("FC_TmpPp")
				//
				QUERY:C277([POLine:40]; [POLine:40]itemNum:2=aFCItem{$i}; *)
				QUERY:C277([POLine:40];  & [POLine:40]qtyBackLogged:5#0)
				CREATE SET:C116([POLine:40]; "FC_TmpPo")
				UNION:C120("FC_Po"; "FC_TmpPo"; "FC_Po")
				CLEAR SET:C117("FC_TmpPo")
				//
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]itemNum:12=aFCItem{$i}; *)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtComplete:6=0)
				CREATE SET:C116([WorkOrder:66]; "FC_TmpWo")
				UNION:C120("FC_Wo"; "FC_TmpWo"; "FC_Wo")
				CLEAR SET:C117("FC_TmpWo")
			End if 
		End for 
		USE SET:C118("FC_Ord")
		USE SET:C118("FC_Pp")
		USE SET:C118("FC_Po")
		USE SET:C118("FC_Wo")
		CLEAR SET:C117("FC_Ord")
		CLEAR SET:C117("FC_Pp")
		CLEAR SET:C117("FC_Po")
		CLEAR SET:C117("FC_Wo")
		FC_FillArrays(1; 1; 1; $bAccountForQtyOnHand; ->aBOMQtyLookupItemNum; ->aBOMQtyLookupQtyOnHand)  //include POs and WOs; expand BOM; by OrdLn
	End if 
End if 
If (Size of array:C274(aFCItem)<=<>alpArrayMax)
	//FC_FillRay (-8)
	FC_FillQtyDescription
	//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
	viRecordsInSelection:=Size of array:C274(aFCItem)
Else 
	doSearch:=0
	ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
End if 
MESSAGES ON:C181
//