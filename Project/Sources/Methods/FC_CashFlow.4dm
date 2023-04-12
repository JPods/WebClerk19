//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/14/02
	//Who: Dan Bentson, Arkware
	//Description: Added base quantity, tally
	VERSION_960
End if 

// Modified by: Bill James (2022-12-09T06:00:00Z)
// Method: FC_CashFlow
// Description 
// Parameters
// ----------------------------------------------------
//  QQQREWORK


If (UserInPassWordGroup("Accounting"))
	C_LONGINT:C283($i; $k)
	C_REAL:C285($runBalance)
	C_DATE:C307($dateDue; $dateCost; $startDate; $endDate)
	KeyModifierCurrent
	
	CONFIRM:C162("Project Cash Flow.")
	If (OK=1)
		$leadDays:=Num:C11(Request:C163("Typical days between cost & delivery."))
		If (OK=1)
			$runBalance:=0
			//SetAreaHeaders (eForeCast;"Item Num";"Description";"Date";"Qty Chng";
			//"Qty OH";"Level";"Doc Item";"Type";"Doc ID") 
			//$error:=// -- AL_SetArraysNam (eForeCast;1;10;"aFCItem";"aFCDesc";
			//"aFCActionDt";"aFCBomCnt";"aFCRunQty";"aFCBomLevel";"aFCParent";
			//"aFCTypeTran";"aFCDocID";"aFCRecNum")
			//Ray_ZeroElement (->aFCItem;->aFCBomCnt;->aFCActionDt;->aFCBomLevel;->aFCParent;->aFCTypeTran;->aFCDocID;->aFCDesc;->aFCRunQty;->aFCWho;->aFCRecNum;->aFCBaseQty;->aFCTallyYTD;->aFCTallyLess1Year;->aFCTallyLess2Year)
			FC_FillRay(0)
			
			READ ONLY:C145([Order:3])
			QUERY:C277([Order:3]; [Order:3]amountBackLog:54#0)
			FIRST RECORD:C50([Order:3])
			For ($i; 1; Records in selection:C76([Order:3]))
				$w:=Find in array:C230(<>aTerms; [Order:3]terms:23)
				If ($w>0)
					$dateDue:=[Order:3]dateNeeded:5+<>aTermDueDay{$w}
				Else 
					$dateDue:=[Order:3]dateNeeded:5
				End if 
				If (($dateDue<Current date:C33) & (OptKey=1))
					$dateDue:=Current date:C33
				End if 
				$dateCost:=[Order:3]dateNeeded:5-$leadDays
				If ($startDate>$dateCost)
					$startDate:=$dateCost
				End if 
				If ($endDate<$dateDue)
					$endDate:=$dateDue
				End if 
				C_REAL:C285($openPart)
				C_LONGINT:C283($amount; $cost)
				If ([Order:3]amount:24#0)
					$openPart:=[Order:3]amountBackLog:54/[Order:3]amount:24
				Else 
					$openPart:=1
				End if 
				C_REAL:C285($comm)
				$comm:=[Order:3]repCommission:9+[Order:3]salesCommission:11
				If ([Order:3]mfrID:52#"")
					$amount:=Round:C94($comm*$openPart; 0)
					$cost:=0
				Else 
					$amount:=Round:C94(([Order:3]amount:24-$comm)*$openPart; 0)
					$cost:=Round:C94([Order:3]totalCost:42*$openPart; 0)
				End if 
				If ($amount#0)
					BOM_NeedExpand([Order:3]customerID:1; $amount; $dateDue; [Order:3]salesNameID:10; [Order:3]status:59; "SO"; [Order:3]idNum:2; Record number:C243([Order:3]); ->[Order:3]company:15)
					$w:=Size of array:C274(aFCRecNum)
					INSERT IN ARRAY:C227(aFCDesc; $w)
					INSERT IN ARRAY:C227(aFCRunQty; $w)
					aFCDesc{$w}:=String:C10(Round:C94([Order:3]amount:24; 0); "###,###,##0")
					aFCRunQty{$w}:=0
				End if 
				If ($cost#0)
					BOM_NeedExpand([Order:3]customerID:1; -$cost; $dateCost; [Order:3]salesNameID:10; [Order:3]status:59; "SO"; [Order:3]idNum:2; Record number:C243([Order:3]); ->[Order:3]company:15)
					$w:=Size of array:C274(aFCRecNum)
					INSERT IN ARRAY:C227(aFCDesc; $w)
					INSERT IN ARRAY:C227(aFCRunQty; $w)
					aFCDesc{$w}:=String:C10(Round:C94([Order:3]amount:24; 0); "###,###,##0")
					aFCRunQty{$w}:=0
				End if 
				NEXT RECORD:C51([Order:3])
			End for 
			UNLOAD RECORD:C212([Order:3])
			READ WRITE:C146([Order:3])
			//
			READ ONLY:C145([Proposal:42])
			QUERY:C277([Proposal:42]; [Proposal:42]complete:56=False:C215)
			FIRST RECORD:C50([Proposal:42])
			For ($i; 1; Records in selection:C76([Proposal:42]))
				If ([Proposal:42]probability:43>0)
					$w:=Find in array:C230(<>aTerms; [Proposal:42]terms:21)
					If ($w>0)
						$dateDue:=[Proposal:42]dateExpected:42+<>aTermDueDay{$w}
					Else 
						$dateDue:=[Proposal:42]dateExpected:42
					End if 
					If (($dateDue<Current date:C33) & (OptKey=1))
						$dateDue:=Current date:C33
					End if 
					$dateCost:=[Proposal:42]dateNeeded:4-$leadDays
					If ($startDate>$dateCost)
						$startDate:=$dateCost
					End if 
					If ($endDate<$dateDue)
						$endDate:=$dateDue
					End if 
					$comm:=[Proposal:42]repCommission:8+[Proposal:42]salesCommission:10
					If ([Proposal:42]profile1:51="Commission")
						$amount:=Round:C94(($comm*[Proposal:42]probability:43*0.01); 0)
						$cost:=0
					Else 
						$amount:=Round:C94(([Proposal:42]amount:26-$comm)*[Proposal:42]probability:43*0.01; 0)
						$cost:=Round:C94([Proposal:42]totalCost:23*[Proposal:42]probability:43*0.01; 0)
					End if 
					If ($amount#0)
						BOM_NeedExpand([Proposal:42]customerID:1; $amount; $dateDue; [Proposal:42]salesNameID:9; [Proposal:42]status:2; "Pp"; [Proposal:42]idNum:5; Record number:C243([Proposal:42]); ->[Proposal:42]company:11)
						$w:=Size of array:C274(aFCRecNum)
						INSERT IN ARRAY:C227(aFCDesc; $w)
						INSERT IN ARRAY:C227(aFCRunQty; $w)
						aFCDesc{$w}:=String:C10(Round:C94([Proposal:42]amount:26; 0); "###,###,##0")
						aFCRunQty{$w}:=0
					End if 
					If ($cost#0)
						BOM_NeedExpand([Proposal:42]customerID:1; -$cost; $dateCost; [Proposal:42]salesNameID:9; [Proposal:42]status:2; "Pp"; [Proposal:42]idNum:5; Record number:C243([Proposal:42]); ->[Proposal:42]company:11)
						$w:=Size of array:C274(aFCRecNum)
						INSERT IN ARRAY:C227(aFCDesc; $w)
						INSERT IN ARRAY:C227(aFCRunQty; $w)
						aFCDesc{$w}:=String:C10(Round:C94([Proposal:42]amount:26; 0); "###,###,##0")
						aFCRunQty{$w}:=0
					End if 
				End if 
				NEXT RECORD:C51([Proposal:42])
			End for 
			UNLOAD RECORD:C212([Proposal:42])
			READ WRITE:C146([Proposal:42])
			//
			READ ONLY:C145([Invoice:26])
			QUERY:C277([Invoice:26]; [Invoice:26]balanceDue:44#0)
			FIRST RECORD:C50([Invoice:26])
			For ($i; 1; Records in selection:C76([Invoice:26]))
				$dateDue:=Invc_DateDue
				$dateCost:=Invc_PrimeDate-$leadDays
				If (($dateDue<Current date:C33) & (OptKey=1))
					$dateDue:=Current date:C33
				End if 
				If ($startDate>$dateCost)
					$startDate:=$dateCost
				End if 
				If ($endDate<$dateDue)
					$endDate:=$dateDue
				End if 
				If ([Invoice:26]total:18#0)
					$openPart:=[Invoice:26]balanceDue:44/[Invoice:26]total:18
				Else 
					$openPart:=1
				End if 
				If ($amount#0)
					BOM_NeedExpand([Invoice:26]customerID:3; Round:C94([Invoice:26]amount:14*$openPart; 0); $dateDue; [Invoice:26]salesNameID:23; [Invoice:26]adSource:52; "IV"; [Invoice:26]idNum:2; Record number:C243([Invoice:26]); ->[Invoice:26]company:7)
					$w:=Size of array:C274(aFCRecNum)
					INSERT IN ARRAY:C227(aFCDesc; $w)
					INSERT IN ARRAY:C227(aFCRunQty; $w)
					aFCDesc{$w}:=String:C10(Round:C94([Invoice:26]amount:14; 0); "###,###,##0")
					aFCRunQty{$w}:=0
				End if 
				If ($cost#0)
					BOM_NeedExpand([Invoice:26]customerID:3; -Round:C94([Invoice:26]totalCost:37*$openPart; 0); $dateCost; [Invoice:26]salesNameID:23; [Invoice:26]adSource:52; "IV"; [Invoice:26]idNum:2; Record number:C243([Invoice:26]); ->[Invoice:26]company:7)
					$w:=Size of array:C274(aFCRecNum)
					INSERT IN ARRAY:C227(aFCDesc; $w)
					INSERT IN ARRAY:C227(aFCRunQty; $w)
					aFCDesc{$w}:=String:C10(Round:C94([Invoice:26]amount:14; 0); "###,###,##0")
					aFCRunQty{$w}:=0
				End if 
				NEXT RECORD:C51([Invoice:26])
			End for 
			UNLOAD RECORD:C212([Invoice:26])
			READ WRITE:C146([Invoice:26])
			//
			If (CtlKey=1)
				READ ONLY:C145([PO:39])
				QUERY:C277([PO:39])
				FIRST RECORD:C50([PO:39])
				C_LONGINT:C283($thisPO)
				For ($i; 1; Records in selection:C76([PO:39]))
					QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
					FIRST RECORD:C50([POLine:40])
					$thisPO:=Record number:C243([POLine:40])  //needed because PO Lines are seached in arealist.
					$w:=Find in array:C230(<>aTerms; [PO:39]terms:17)
					If ($w>0)
						$dateDue:=[PO:39]dateNeeded:3+<>aTermDueDay{$w}
					Else 
						$dateDue:=[PO:39]dateNeeded:3
					End if 
					If (($dateDue<Current date:C33) & (OptKey=1))
						$dateDue:=Current date:C33
					End if 
					BOM_NeedExpand([PO:39]vendorID:1; -Round:C94([PO:39]amountBackLog:25; 0); $dateDue; [PO:39]buyer:7; [PO:39]terms:17; "PO"; [PO:39]idNum:5; $thisPO; ->[PO:39]shipToCompany:8)
					$w:=Size of array:C274(aFCRecNum)
					INSERT IN ARRAY:C227(aFCDesc; $w)
					INSERT IN ARRAY:C227(aFCRunQty; $w)
					aFCDesc{$w}:=[PO:39]vendorCompany:39
					aFCRunQty{$w}:=0
					NEXT RECORD:C51([PO:39])
				End for 
				UNLOAD RECORD:C212([PO:39])
				READ WRITE:C146([PO:39])
			End if 
			//
			$dtEnd:=DateTime_DTTo($endDate; ?23:59:59?)
			$dtStart:=DateTime_DTTo($startDate; ?23:59:59?)
			READ ONLY:C145([TallyResult:73])
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="Forecast/Budgeted"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12>=$dtStart; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12<=$dtEnd)
			FIRST RECORD:C50([TallyResult:73])
			C_LONGINT:C283($thisPO)
			For ($i; 1; Records in selection:C76([TallyResult:73]))
				DateTime_DTFrom([TallyResult:73]dtReport:12; ->vDate1)
				BOM_NeedExpand([TallyResult:73]profile1:17; -Round:C94([TallyResult:73]real1:13; 0); vDate1; [TallyResult:73]profile2:18; [TallyResult:73]profile3:19; "TR"; [TallyResult:73]idNum:35; Record number:C243([TallyResult:73]); ->[TallyResult:73]textBlk1:5)
				$w:=Size of array:C274(aFCRecNum)
				INSERT IN ARRAY:C227(aFCDesc; $w)
				INSERT IN ARRAY:C227(aFCRunQty; $w)
				aFCDesc{$w}:=[TallyResult:73]name:1
				aFCRunQty{$w}:=0
				NEXT RECORD:C51([TallyResult:73])
			End for 
			//
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="Forecast/Recurring")
			FIRST RECORD:C50([TallyResult:73])
			C_LONGINT:C283($period; $index; $maxIndex)
			C_DATE:C307($dateDue)
			For ($i; 1; Records in selection:C76([TallyResult:73]))
				//      $cntExp:=[Service]DollarImpactCus-[Service]DollarImpactRep
				$index:=0
				$period:=[TallyResult:73]longint1:7+(Num:C11([TallyResult:73]longint1:7=0)*30)
				$maxIndex:=[TallyResult:73]real1:13+(Num:C11([TallyResult:73]real1:13=0)*5000)
				Repeat 
					$dateDue:=$startDate+($index*$period)
					$index:=$index+1
					BOM_NeedExpand([TallyResult:73]profile1:17; -Round:C94([TallyResult:73]real1:13; 0); $dateDue; [TallyResult:73]profile2:18; [TallyResult:73]profile3:19; "TR"; [TallyResult:73]idNum:35; Record number:C243([TallyResult:73]); ->[TallyResult:73]textBlk1:5)
					$w:=Size of array:C274(aFCRecNum)
					
					aFCDesc{$w}:=[TallyResult:73]name:1
					aFCRunQty{$w}:=0
				Until (($dateDue>=$endDate) | ($index>$maxIndex))
				NEXT RECORD:C51([TallyResult:73])
			End for 
			UNLOAD RECORD:C212([TallyResult:73])
			//
			//SEARCH([Service];[Service]Action="Forecast/FixPeriod";*)
			//SEARCH([Service];&[Service]Completed=False)
			//FIRST RECORD([Service])
			//C_LONGINT($thisPO)
			//For ($i;1;Records in selection([Service]))
			////      $cntExp:=[Service]DollarImpactCus-[Service]DollarImpactRep
			//For ($index;[Service]DollarImpactCus;[Service]DollarImpactRep)
			//$dateDue:=[Service]ActionDate+($index*30)
			//BOM_NeedExpand ([Service]FunctionProcess;-Round([Service
			//]DollarImpactUs;0);$dateDue;[Service]Action nameID;[Service]Attribute;"Sv";
			//[Service]UniqueID;Record number([Service]);[Service]Comment)
			//$w:=Size of array(aFCRecNum)
			//INSERT ELEMENT(aFCDesc;$w)
			//INSERT ELEMENT(aFCRunQty;$w)
			//aFCDesc{$w}:=[Service]ProbableCause
			//aFCRunQty{$w}:=0
			//End for 
			//NEXT RECORD([Service])
			//End for 
			//UNLOAD RECORD([Service])
			//READ WRITE([Service])
			//
			//
			//If (Is macOS)
			//DA_Sort (">";aFCActionDt;aFCItem;aFCDesc;aFCBomCnt;aFCRunQty
			//;aFCBomLevel;aFCParent;aFCTypeTran;aFCDocID;aFCRecNum;aFCWho)
			//Else 
			//COPY ARRAY(aFCActionDt;aTmpDate1)
			SORT ARRAY:C229(aFCActionDt; aFCItem; aFCDesc; aFCBomCnt; aFCRunQty; aFCBomLevel; aFCParent; aFCTypeTran; aFCDocID; aFCRecNum; aFCWho)  //
			CLEAR VARIABLE:C89(aTmpDate1)
			// End if 
			//
			$k:=Size of array:C274(aFCRecNum)
			aFCRunQty{0}:=0
			C_REAL:C285($lastValue)
			$lastValue:=0
			For ($i; 1; $k)
				aFCRunQty{$i}:=Round:C94(aFCRunQty{$lastValue}+aFCBomCnt{$i}; 0)
				$lastValue:=$lastValue+1
			End for 
			ARRAY LONGINT:C221(aTmpInt1; 0)
			//    // -- AL_SetSort (eForeCast;3;8)
			TRACE:C157
			// -- AL_SetHeaders(eForeCast; 1; 10; "Acct"; "Orig Amt"; "Date"; "$ Chng"; "Running $"; "Name"; "Source/Att"; "Type"; "Doc ID"; "Who")
			//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
		End if 
	End if 
End if 
