//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-29T00:00:00, 14:32:17
// ----------------------------------------------------
// Method: P_CountLinesToPrint
// Description
// Modified: 07/29/13
// 
// 
//
// Parameters
// ----------------------------------------------------



Case of 
	: (Table:C252([UserReport:46]tableNum:3)=(->[Order:3]))
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2; *)
		Case of 
			: ([UserReport:46]PrintNot:30=0)  //"Print All Lines")
				// Keep all line records
			: ([UserReport:46]PrintNot:30=2)  //"BLQ Only")
				QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0; *)
				QUERY:C277([OrderLine:49];  & [OrderLine:49]printNot:56=0; *)
			: ([UserReport:46]PrintNot:30=1)  //Limit Line Printing
				QUERY:C277([OrderLine:49];  & [OrderLine:49]printNot:56=0; *)
		End case 
		QUERY:C277([OrderLine:49])
		SELECTION TO ARRAY:C260([OrderLine:49]; aPrintBodyCount)
		
	: (Table:C252([UserReport:46]tableNum:3)=(->[Invoice:26]))
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2; *)
		Case of 
			: ([UserReport:46]PrintNot:30=0)  //="Print All Lines")
				// Keep all line records
			: ([UserReport:46]PrintNot:30=1)  //Limit Line Printing
				QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]printNot:52=0; *)
		End case 
		QUERY:C277([InvoiceLine:54])
		$cntThese:=Records in selection:C76([InvoiceLine:54])
		SELECTION TO ARRAY:C260([InvoiceLine:54]; aPrintBodyCount)
		
	: (Table:C252([UserReport:46]tableNum:3)=(->[PO:39]))
		QUERY:C277([QQQPOLine:40];  & [QQQPOLine:40]poNum:1=[PO:39]poNum:5)
		$cntThese:=Records in selection:C76([QQQPOLine:40])
		SELECTION TO ARRAY:C260([QQQPOLine:40]; aPrintBodyCount)
		
	: (Table:C252([UserReport:46]tableNum:3)=(->[Proposal:42]))
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5; *)
		Case of 
			: ([UserReport:46]PrintNot:30=0)  //[UserReport]ScriptCode#"Print All Lines")
				
			: ([UserReport:46]PrintNot:30=1)  //Limit Line Printing
				QUERY:C277([ProposalLine:43];  & [ProposalLine:43]printNot:54=0; *)
		End case 
		QUERY:C277([ProposalLine:43])
		$cntThese:=Records in selection:C76([ProposalLine:43])
		SELECTION TO ARRAY:C260([ProposalLine:43]; aPrintBodyCount)
	Else 
		ARRAY LONGINT:C221(aPrintBodyCount; 0)
End case 