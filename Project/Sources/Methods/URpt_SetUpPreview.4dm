//%attributes = {"publishedWeb":true}
//Method: Method: URpt_SetUpPreview
//Noah Dykoski   March 11, 1999 / 1:42 AM
C_LONGINT:C283($result)
If (([UserReport:46]tableNum:3>0) & ([UserReport:46]Creator:6="GtSR"))
	//must have come from an output or splash screen layout
	curLines:=0
	vLongCnt:=1
	If ((vHere=2) & (Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)>0) & ([UserReport:46]tableNum:3#Table:C252(->[UserReport:46])))
		FIRST RECORD:C50(Table:C252([UserReport:46]tableNum:3)->)
	End if 
	$result:=0
	Case of 
		: ([UserReport:46]NumLines:10=0)  //leave the zero
		: ([UserReport:46]NumLines:10>0)
			$result:=P_SetReps  // // do not turn on autoRelate before this step
		: ([UserReport:46]NumLines:10<0)
			Case of 
				: ([UserReport:46]tableNum:3=Table:C252(->[Order:3]))
					QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
					$result:=Records in selection:C76([OrderLine:49])
				: ([UserReport:46]tableNum:3=Table:C252(->[Invoice:26]))
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
					$result:=Records in selection:C76([InvoiceLine:54])
				: ([UserReport:46]tableNum:3=Table:C252(->[PO:39]))
					$result:=Records in selection:C76([QQQPOLine:40])
				: ([UserReport:46]tableNum:3=Table:C252(->[Proposal:42]))
					$result:=Records in selection:C76([ProposalLine:43])
			End case 
			ARRAY LONGINT:C221(aPrntRecs; $result)
			For ($i; 1; $result)  //rptLineCnt)
				aPrntRecs{$i}:=Record number:C243(Table:C252([UserReport:46]tableNum:3)->)
			End for 
	End case 
	rptLineCnt:=$result  // // do not turn on autoRelate before this step     
	$result:=SR Get Area(eSRWin; reportDefinitionBlob)
	Case of 
		: ([UserReport:46]NumLines:10>0)
			$result:=SR Main Table(reportDefinitionBlob; 8; 0; "aPrintBodyCount")
		: ([UserReport:46]NumLines:10=-99)  // SINGLE Loop Report
			P_SetBodyCount
			//$result:=SR Main Table (reportDefinitionBlob;8;0;"aPrintBodyCount")
		: ([UserReport:46]NumLines:10<0)  //allow user to override with Print file selection
			
		: ([UserReport:46]NumLines:10=0)  //print by record count
			$result:=SR Main Table(reportDefinitionBlob; Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->); [UserReport:46]tableNum:3; "")
		Else 
			$result:=SR Main Table(reportDefinitionBlob; Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->); [UserReport:46]tableNum:3; "")
			// Else 
			//leave as set by user
			//report pict; report on file or mechanism; File or count; Variable with count
			//$2 -- -1 sh file choice; 0 Query main file; 1, set file ($3)  cnt in var ($4);
			//2, specify iteratins in $3, $4 - ""; 4, iterate by "varName" in $4;
			//8, literate by array size in $4 ("array name")
	End case 
	If ($result=0)
		Prnt_SetStruct(eSRWin; [UserReport:46]tableNum:3)
		$result:=SR Set Area(eSRWin; reportDefinitionBlob)
	End if 
End if 