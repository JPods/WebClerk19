//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/24/20, 09:43:05
// ----------------------------------------------------
// Method: ParseProposalLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20181219_1001
// $k is never set to any value
// used in WCC_Parse of OrderLines
// uncertain is this is a correct action
//TRACE


C_LONGINT:C283($0; $viProposalNum)

C_LONGINT:C283($k)
C_BOOLEAN:C305($lineTaxable; $notLocked)
C_LONGINT:C283($viProposalNum; $orderLineUniqueID; $lineDelete; $orderLineRecNum)
// do the specific line

$viProposalNum:=[ProposalLine:43]idNumProposal:1
If ([Proposal:42]idNum:5#[ProposalLine:43]idNumProposal:1)
	QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=[ProposalLine:43]idNumProposal:1)
End if 
$0:=[ProposalLine:43]idNumProposal:1
If ([Customer:2]customerID:1#[ProposalLine:43]customerID:42)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[ProposalLine:43]customerID:42)
End if 
$notLocked:=True:C214
$lockedOrderLines:=Locked:C147([ProposalLine:43])
$lockedOrders:=Locked:C147([Proposal:42])
$lockedCustomers:=Locked:C147([Customer:2])
If (($lockedOrderLines) | ($lockedOrders))  //|($lockedCustomers))
	vResponse:="Locked Records Proposal: "+String:C10(Num:C11($lockedOrders))+"; ProposalLines: "+String:C10(Num:C11($lockedOrderLines))
	$notLocked:=False:C215
	$0:=-11
End if 

If ($notLocked)
	
	$k:=Record number:C243([ProposalLine:43])
	C_BOOLEAN:C305($lineTaxable)
	C_REAL:C285($vrTaxRate)
	READ ONLY:C145([TaxJurisdiction:14])
	QUERY:C277([TaxJurisdiction:14]; [TaxJurisdiction:14]taxJurisdiction:1=[Proposal:42]taxJuris:33)
	$vrTaxRate:=[TaxJurisdiction:14]taxRateSales:2
	UNLOAD RECORD:C212([TaxJurisdiction:14])
	//read write([Taxe])
	
	// ### bj ### 20191012_1628
	// change to have a taxable field in each line
	If (($vrTaxRate>0) & ([ProposalLine:43]salesTax:18>0))
		$lineTaxable:=True:C214
	Else 
		$lineTaxable:=False:C215
	End if 
	
	If ([ProposalLine:43]lineNum:43=0)  // should never happen
		[ProposalLine:43]lineNum:43:=[ProposalLine:43]idNum:52
	End if 
	If ([ProposalLine:43]seq:33=0)  // should never happen
		[ProposalLine:43]seq:33:=[ProposalLine:43]idNum:52
	End if 
	
	If ([ProposalLine:43]typeSale:32#(Old:C35([ProposalLine:43]typeSale:32)))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
		DscntSetPrice([ProposalLine:43]typeSale:32; [Proposal:42]dateDocument:3)
		OrdSetPrice(->[ProposalLine:43]unitPrice:15; ->[ProposalLine:43]discount:17; [ProposalLine:43]qty:3; ->pComm)
		vComRep:=CM_FindRate(->[Proposal:42]repID:7; -><>aReps; -><>aRepRate)
		vComSales:=CM_FindRate(->[Proposal:42]salesNameID:9; -><>aComNameID; -><>aEmpRate)
		[ProposalLine:43]commRateSales:21:=vComSales*pComm*0.01
		[ProposalLine:43]commRateRep:27:=vComRep*pComm*0.01
	End if 
	
	// ### bj ### 20181219_1001
	// $k is never set to any value
	
	Case of 
		: (vPackingProcess="PK")  //when operating from the PK window
			//TRACE
			// how is this different that IvcLnLoadRec qqqq
			$dOnHand:=0
		: ($k>-1)  //existing order line
			C_REAL:C285($oldOnOrder; $newOnOrder; $dOnHand)
			// ### bj ### 20191012_1415
			// If there is a change in quantity ordered
			$oldOnOrder:=Old:C35([ProposalLine:43]qty:3)
			$newOnOrder:=[ProposalLine:43]qty:3  // restating the obvious for debugging
			$dOnOrder:=[ProposalLine:43]qty:3-$oldOnOrder
			$dAction:=3
	End case 
	//  zzzzz
	
	
	
	SAVE RECORD:C53([ProposalLine:43])
	
	
	Execute_TallyMaster("ProposalLinesAfterParse"; "WebScript")
	
	// ### bj ### 20200426_1658
	// determine if the records is to be deleted where is this applied???
	$orderLineUniqueID:=[ProposalLine:43]idNum:52
	$orderLineRecNum:=Record number:C243([ProposalLine:43])
	$lineDelete:=Num:C11(([ProposalLine:43]status:30="delete") | ([ProposalLine:43]description:4="delete"))
	//
	
	C_LONGINT:C283($thisRecord)
	$thisRecord:=Record number:C243([ProposalLine:43])
	//  PUSH RECORD([ProposalLine])  //build the order before checking this order line.  May need to add a feature to identify new orderlines when one is created (-3000)
End if 


