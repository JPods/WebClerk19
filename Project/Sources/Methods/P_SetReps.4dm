//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-16T00:00:00, 10:11:09
// ----------------------------------------------------
// Method: P_SetReps
// Description
// Modified: 07/16/13
// 
// 
//
// Parameters
// ----------------------------------------------------
//Sub_record_removal

C_LONGINT:C283($i; $k; $w; $1; $pageLines; $fixedPageLines; $cntThese; vlongCnt)
C_LONGINT:C283($0)

ARRAY LONGINT:C221(aPrintBodyCount; 0)
ARRAY LONGINT:C221(aPrntRecs; 0)
C_LONGINT:C283(vPrintBodyCounter)
C_LONGINT:C283(vPageCurrent)
C_LONGINT:C283(vPagesTotal)
vPrintBodyCount:=0
$fixedPageLines:=[UserReport:46]NumLines:10

// There will always be just one record
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
		$cntThese:=Records in selection:C76([OrderLine:49])
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
		If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
			$cntThese:=Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)  //  this handles printing of one body per record for not big 4
			SELECTION TO ARRAY:C260(Table:C252([UserReport:46]tableNum:3)->; aPrintBodyCount)
		End if 
End case 


$pages:=($cntThese\$fixedPageLines)
If (($cntThese%$fixedPageLines)#0)  //will we need one extra page for the remaining lines
	$pages:=$pages+1  //$fixedPageLines
End if 
$pageLines:=$pages*$fixedPageLines
vPageCount:=$pages

While ($pageLines>Size of array:C274(aPrintBodyCount))
	APPEND TO ARRAY:C911(aPrintBodyCount; -1)
End while 
$0:=Size of array:C274(aPrintBodyCount)
COPY ARRAY:C226(aPrintBodyCount; aPrntRecs)  // legacy reports
