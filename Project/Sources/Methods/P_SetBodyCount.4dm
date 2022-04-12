//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/06, 13:33:31
// ----------------------------------------------------
// Method: P_SetBodyCount
// Description
// 
//
// Parameters
// ----------------------------------------------------



// Only used in Single Loop printing 

ARRAY LONGINT:C221(aPrintBodyCount; 0)
C_TEXT:C284(vReportName)
C_LONGINT:C283($cntThese)
//
Case of 
	: (([UserReport:46]NumLines:10=-99) | ([UserReport:46]NumLines:10>0))  // Single Loop or p-Line number report
		Case of 
			: (Table:C252([UserReport:46]tableNum:3)=(->[Order:3]))
				If (Records in selection:C76([Order:3])=0)  // only used if directly accessing UserReport iLo
					LastRecordInTable(Table:C252(->[Order:3]))
					GOTO RECORD:C242([Order:3]; <>aLastRecNum{Table:C252(->[Order:3])})
				End if 
				vReportName:=[Order:3]company:15+"_Order_"+String:C10([Order:3]orderNum:2)
				SET WINDOW TITLE:C213(vReportName)
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2; *)
				Case of 
					: ([UserReport:46]PrintNot:30=0)  //"Print All Lines")   //add no additional criteria
					: ([UserReport:46]PrintNot:30=2)  //"BLQ Only")
						QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0; *)
						QUERY:C277([OrderLine:49];  & [OrderLine:49]printNot:56=0; *)
					: ([UserReport:46]PrintNot:30=1)  //Limit Line Printing
						QUERY:C277([OrderLine:49];  & [OrderLine:49]printNot:56=0; *)
				End case 
				QUERY:C277([OrderLine:49])
				ORDER BY:C49([OrderLine:49]; [OrderLine:49]sequence:30)
				SELECTION TO ARRAY:C260([OrderLine:49]; aPrintBodyCount)
				COPY ARRAY:C226(aPrintBodyCount; aPrntRecs)
				$cntThese:=Records in selection:C76([OrderLine:49])
				P_OrdHeadVars  // may want to remove and have only in the report
			: (Table:C252([UserReport:46]tableNum:3)=(->[Invoice:26]))
				If (Records in selection:C76([Invoice:26])=0)  // only used if directly accessing UserReport iLo
					LastRecordInTable(Table:C252(->[Invoice:26]))
					GOTO RECORD:C242([Invoice:26]; <>aLastRecNum{Table:C252(->[Invoice:26])})
				End if 
				// & (Table([UserReport]TableNumBodyCount)=(->[InvoiceLine])))
				SET WINDOW TITLE:C213(Table name:C256([UserReport:46]tableNum:3)+" - "+String:C10([Invoice:26]invoiceNum:2))
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2; *)
				Case of 
					: ([UserReport:46]PrintNot:30=0)  //="Print All Lines")  //add no additional criteria
					: ([UserReport:46]PrintNot:30=1)  //Limit Line Printing
						QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]printNot:52=0; *)
				End case 
				QUERY:C277([InvoiceLine:54])
				ORDER BY:C49([InvoiceLine:54]; [InvoiceLine:54]sequence:28)
				SELECTION TO ARRAY:C260([InvoiceLine:54]; aPrintBodyCount)
				COPY ARRAY:C226(aPrintBodyCount; aPrntRecs)
				$cntThese:=Records in selection:C76([InvoiceLine:54])
				P_IvcHeadVars  // may want to remove and have only in the report
			: (Table:C252([UserReport:46]tableNum:3)=(->[PO:39]))  // only used if directly accessing UserReport iLo
				If (Records in selection:C76([PO:39])=0)
					LastRecordInTable(Table:C252(->[PO:39]))
					GOTO RECORD:C242([PO:39]; <>aLastRecNum{Table:C252(->[PO:39])})
				End if 
				// & (Table([UserReport]TableNumBodyCount)=(->[POLine])))
				SET WINDOW TITLE:C213(Table name:C256([UserReport:46]tableNum:3)+" - "+String:C10([PO:39]poNum:5))
				QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=[PO:39]poNum:5)
				ORDER BY:C49([QQQPOLine:40]; [QQQPOLine:40]sequence:21)
				$cntThese:=Records in selection:C76([QQQPOLine:40])
				PoLnFillRays(Records in selection:C76([QQQPOLine:40]))
				SELECTION TO ARRAY:C260([QQQPOLine:40]; aPrintBodyCount)
				P_PoHeadVars  // may want to remove and have only in the report
			: (Table:C252([UserReport:46]tableNum:3)=(->[Proposal:42]))
				If (Records in selection:C76([Proposal:42])=0)  // only used if directly accessing UserReport iLo
					LastRecordInTable(Table:C252(->[Proposal:42]))
					GOTO RECORD:C242([Proposal:42]; <>aLastRecNum{Table:C252(->[Proposal:42])})
				End if 
				// & (Table([UserReport]TableNumBodyCount)=(->[ProposalLine])))
				SET WINDOW TITLE:C213(Table name:C256([UserReport:46]tableNum:3)+" - "+String:C10([Proposal:42]proposalNum:5))
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5; *)
				Case of 
					: ([UserReport:46]PrintNot:30=0)  //[UserReport]ScriptCode#"Print All Lines")
						
					: ([UserReport:46]PrintNot:30=1)  //Limit Line Printing
						QUERY:C277([ProposalLine:43];  & [ProposalLine:43]printNot:54=0; *)
				End case 
				QUERY:C277([ProposalLine:43])
				ORDER BY:C49([ProposalLine:43]; [ProposalLine:43]sequence:33)
				$cntThese:=Records in selection:C76([ProposalLine:43])
				PpLnFillRays(Records in selection:C76([ProposalLine:43]))
				SELECTION TO ARRAY:C260([ProposalLine:43]; aPrintBodyCount)
				COPY ARRAY:C226(aPrintBodyCount; aPrntRecs)
				P_PpHeadVars  // may want to remove and have only in the report
			Else 
				SELECTION TO ARRAY:C260(Table:C252([UserReport:46]tableNum:3)->; aPrintBodyCount)
				$cntThese:=Size of array:C274(aPrintBodyCount)
		End case 
	: (([UserReport:46]NumLines:10=-1) | ([UserReport:46]NumLines:10=-2))  // some report defined by the user
		iLoText1:=[UserReport:46]ScriptLoop:34
		ARRAY LONGINT:C221(aPrintBodyCount; 0)  // must be set in the script
		ExecuteText(0; iLoText1)
		// This must set the value of iterations, generally the size of array aPrintBodyCount
		$cntThese:=Size of array:C274(aPrintBodyCount)
	: (([UserReport:46]tableNumBodyCount:32>0) & ([UserReport:46]tableNumBodyCount:32<=Get last table number:C254))  // If there is no related table to affect body count
		ARRAY LONGINT:C221(aPrintBodyCount; 0)
		iLoText1:=[UserReport:46]ScriptLoop:34
		ExecuteText(0; iLoText1)
		OK:=1
		If (Records in selection:C76(Table:C252([UserReport:46]tableNumBodyCount:32)->)>200)
			C_LONGINT:C283($printNumber; $finalCount)
			C_TEXT:C284($printString)
			$printNumber:=Records in selection:C76(Table:C252([UserReport:46]tableNumBodyCount:32)->)
			$printString:=String:C10($printNumber)
			$finalCount:=Num:C11(Request:C163("Proceed with "+$printString+" records."; $printString))
			If (OK=1)
				If ($finalCount<$printNumber)
					REDUCE SELECTION:C351(Table:C252([UserReport:46]tableNumBodyCount:32)->; $finalCount)
					$printNumber:=$finalCount
				End if 
			Else 
				REDUCE SELECTION:C351(Table:C252([UserReport:46]tableNumBodyCount:32)->; 0)
			End if 
		End if 
		If (OK=1)
			SELECTION TO ARRAY:C260(Table:C252([UserReport:46]tableNumBodyCount:32)->; aPrintBodyCount)  // if there is a table defined, identify the records
		End if 
End case 
// Legacy for existing reports using aPrntRecs, New Reports should use aPrintBodyCount

COPY ARRAY:C226(aPrintBodyCount; aPrntRecs)
vPageCurrent:=0  // these must be reset to zero
vPrintBodyCounter:=0  // incremented at each line
vPageNumber:=0