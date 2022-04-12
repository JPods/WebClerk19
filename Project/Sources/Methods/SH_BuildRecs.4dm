//%attributes = {"publishedWeb":true}
//Procedure: SH_BuildRecs
C_LONGINT:C283($i; $k; $rptCnt; $incRpt)
C_TEXT:C284($rptName)
If (Size of array:C274(aText3)>0)  //must be coming from 
	$i:=0
	$doSkip:=(SH_TallyPendCha#0)
	If ((vlDtEnd-vlDtStart)=86399)
		$rptName:="daily"
		OK:=1
		$rptCnt:=1
	Else 
		$rptName:=Request:C163("Enter the type of Report"; "Periods")
		If ($rptName="Periods")
			$rptCnt:=1
		Else 
			$rptCnt:=1
		End if 
	End if 
	If ($doSkip)
		jAlertMessage(10014)
	Else 
		If (OK=1)
			TRACE:C157
			READ WRITE:C146([TallyResult:73])
			$k:=Size of array:C274(aCustomers)
			For ($i; 1; $k)
				//For ($incRpt;1;$rptCnt)
				//  Case of 
				//: ($incRpt=1)
				$theDT:=vlDTEnd
				$rptName:="Daily"
				QUERY:C277([TallyResult:73]; [TallyResult:73]dtReport:12=$theDT; *)
				If ((Storage:C1525.default.company="True@") & (Storage:C1525.default.zip="63366@"))
					QUERY:C277([TallyResult:73];  & [TallyResult:73]siteID:29=aText1{$i}; *)  //company
				End if 
				QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$rptName; *)  //period
				QUERY:C277([TallyResult:73];  & [TallyResult:73]itemNum:34=aPartNum{$i}; *)  //item number
				QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=aCustAcct{$i}; *)  //Cust
				QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=aCustRep{$i})  //Rep
				If (Records in selection:C76([TallyResult:73])=0)
					CREATE RECORD:C68([TallyResult:73])
					
					[TallyResult:73]dtReport:12:=$theDT
					[TallyResult:73]siteID:29:=aText1{$i}
					[TallyResult:73]name:1:=$rptName
					[TallyResult:73]purpose:2:=aText4{$i}
					[TallyResult:73]customerID:30:=aCustAcct{$i}
					[TallyResult:73]salesNameID:31:=aCustRep{$i}
					[TallyResult:73]itemNum:34:=aPartNum{$i}
					[TallyResult:73]nameReal1:20:="Qty Inv"
					[TallyResult:73]nameReal2:21:="$ Ship"
					[TallyResult:73]nameReal3:22:="Net Sales"
					[TallyResult:73]nameReal4:23:="FOB Diff"
					[TallyResult:73]nameReal5:33:="Hidden Frieght"
					[TallyResult:73]nameProfile1:26:="FOB"
					[TallyResult:73]nameReal6:37:="Qty Ord"
					[TallyResult:73]nameReal7:38:="$ Ordered"
					[TallyResult:73]nameReal8:39:="Net Ordered"
					[TallyResult:73]nameReal9:40:="FOB Diff Ord"
					[TallyResult:73]nameReal10:41:="Hidden Frieght Ord"
					If ([TallyResult:73]profile1:17="")
						[TallyResult:73]profile1:17:=aTmp20Str1{$i}
					End if 
					If ([TallyResult:73]profile2:18="")
						[TallyResult:73]profile2:18:=aTmp20Str2{$i}
					End if 
					If ([TallyResult:73]profile3:19="")
						[TallyResult:73]profile3:19:=aTmp20Str3{$i}
					End if 
					$doTally:=True:C214
				Else 
					LOAD RECORD:C52([TallyResult:73])
					$doTally:=(Not:C34(Locked:C147([TallyResult:73])))
				End if 
				If ($doTally)
					Case of 
						: (aTmpLong2{$i}=2)  //from shipments
							[TallyResult:73]real1:13:=[TallyResult:73]real1:13+aQtyNact{$i}  //qty
							[TallyResult:73]real2:14:=[TallyResult:73]real2:14+aSaleNact{$i}  //sales
							[TallyResult:73]real3:15:=[TallyResult:73]real3:15+aInvNact{$i}  //Net Sales
							[TallyResult:73]real4:16:=[TallyResult:73]real4:16+aScpNPlan{$i}  //FOB diff
							[TallyResult:73]real5:32:=[TallyResult:73]real5:32+aScpNact{$i}  //Hidden Frght      
						: (aTmpLong2{$i}=1)  //from bookings
							[TallyResult:73]real6:42:=[TallyResult:73]real6:42+aQtyNact{$i}  //qty
							[TallyResult:73]real7:43:=[TallyResult:73]real7:43+aSaleNact{$i}  //sales
							[TallyResult:73]real8:44:=[TallyResult:73]real8:44+aInvNact{$i}  //Net Sales
							[TallyResult:73]real9:45:=[TallyResult:73]real9:45+aScpNPlan{$i}  //FOB diff
							[TallyResult:73]real10:46:=[TallyResult:73]real10:46+aScpNact{$i}  //Hidden Frght                    
					End case 
					SAVE RECORD:C53([TallyResult:73])
				Else 
					CREATE RECORD:C68([TallyChange:65])
					
					[TallyChange:65]fileNum:1:=Table:C252(->[TallyResult:73])
					[TallyChange:65]fieldNum:2:=Table:C252(->[TallyResult:73]real1:13)
					[TallyChange:65]longIntKey:4:=Record number:C243([TallyResult:73])
					[TallyChange:65]change:5:=aQtyNact{$i}  //qty
					SAVE RECORD:C53([TallyResult:73])
					CREATE RECORD:C68([TallyChange:65])
					
					[TallyChange:65]fileNum:1:=Table:C252(->[TallyResult:73])
					[TallyChange:65]fieldNum:2:=Table:C252(->[TallyResult:73]real2:14)
					[TallyChange:65]longIntKey:4:=Record number:C243([TallyResult:73])
					[TallyChange:65]change:5:=aSaleNact{$i}  //sales
					SAVE RECORD:C53([TallyResult:73])
					CREATE RECORD:C68([TallyChange:65])
					
					[TallyChange:65]fileNum:1:=Table:C252(->[TallyResult:73])
					[TallyChange:65]fieldNum:2:=Table:C252(->[TallyResult:73]real3:15)
					[TallyChange:65]longIntKey:4:=Record number:C243([TallyResult:73])
					[TallyChange:65]change:5:=aInvNact{$i}  //Net Sales
					SAVE RECORD:C53([TallyResult:73])
					CREATE RECORD:C68([TallyChange:65])
					
					[TallyChange:65]fileNum:1:=Table:C252(->[TallyResult:73])
					[TallyChange:65]fieldNum:2:=Table:C252(->[TallyResult:73]real4:16)
					[TallyChange:65]longIntKey:4:=Record number:C243([TallyResult:73])
					[TallyChange:65]change:5:=aScpNPlan{$i}  //FOB diff
					SAVE RECORD:C53([TallyResult:73])
					CREATE RECORD:C68([TallyChange:65])
					
					[TallyChange:65]fileNum:1:=Table:C252(->[TallyResult:73])
					[TallyChange:65]fieldNum:2:=Table:C252(->[TallyResult:73]real5:32)
					[TallyChange:65]longIntKey:4:=Record number:C243([TallyResult:73])
					[TallyChange:65]change:5:=aScpNact{$i}  //Hidden Frght  
					SAVE RECORD:C53([TallyResult:73])
				End if 
			End for 
			// End for 
			READ ONLY:C145([TallyResult:73])
		End if 
	End if 
End if 