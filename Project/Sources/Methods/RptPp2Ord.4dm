//%attributes = {"publishedWeb":true}
//Method: RptPp2Ord
If (False:C215)
	//Date: 02/23/02
	//Who: Bill James
	//Description: Post groups of proposals to orders
	VERSION_960
End if 
//C_LONGINT(eOpenOrds)

TRACE:C157
If (ptCurTable#(->[Proposal:42]))
	ALERT:C41("Must be in Proposals")
Else 
	//
	C_LONGINT:C283($i; $k; $incsub; $myOK)
	C_BOOLEAN:C305(booManyInv; $endView)  //coming from add invoice dialog
	C_LONGINT:C283($invNum)
	C_REAL:C285($qtyOK)
	$myOK:=0
	If (vHere=1)
		doByLine:=False:C215
		CONFIRM:C162("Orders will be created for these "+String:C10(Records in selection:C76([Proposal:42]))+" Proposals.")
		$myOK:=OK
		If ($myOK=1)
			C_TEXT:C284($status)
			$status:=Request:C163("Would you like to apply a status to Proposals?"; "Complete")
			//$myOK:=OK
		End if 
	End if 
	If ($myOK=1)
		CREATE EMPTY SET:C140([Order:3]; "NewInvoices")
		CREATE EMPTY SET:C140([Proposal:42]; "SkipOrders")
		CREATE EMPTY SET:C140([Proposal:42]; "ProcOrders")
		CREATE SET:C116([Proposal:42]; "OrigOrders")
		FIRST RECORD:C50([Proposal:42])
		//xTRACE
		$k:=Records in selection:C76([Proposal:42])
		// ThermoInitExit ("Processing Orders";$k;True)
		<>ThermoAbort:=False:C215
		C_BOOLEAN:C305($localPass)
		$localPass:=allowAlerts_boo
		allowAlerts_boo:=False:C215
		For ($i; 1; $k)
			//ThermoUpdate ($i)
			If (<>ThermoAbort)
				$i:=$k
			End if 
			LOAD RECORD:C52([Proposal:42])
			If (Locked:C147([Proposal:42]))
				ADD TO SET:C119([Proposal:42]; "SkipOrders")
			Else 
				MESSAGE:C88("Processing Proposal:  "+String:C10([Proposal:42]proposalNum:5))
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
				PpLnFillRays(Records in selection:C76([ProposalLine:43]))
				C_LONGINT:C283($cntLines; $incLines; $raySize)
				$cntLines:=Size of array:C274(aPItemNum)
				ARRAY LONGINT:C221(aPPLnSelect; 0)
				For ($incLines; 1; $cntLines)
					If (aPUse{$incLines}#"")
						$raySize:=Size of array:C274(aPPLnSelect)+1
						INSERT IN ARRAY:C227(aPPLnSelect; $raySize)
						aPPLnSelect{$raySize}:=$incLines
					End if 
				End for 
				//QUERY([Customer];[Customer]customerID=[Proposal]customerID)
				CREATE RECORD:C68([Order:3])
				[Order:3]orderNum:2:=CounterNew(->[Order:3])
				//TRACE
				Ord_FromProposal
				booAccept:=True:C214
				acceptOrders
				ADD TO SET:C119([Order:3]; "NewInvoices")
				vMod:=True:C214
				vLineMod:=True:C214
				booAccept:=True:C214
				If ($status#"")
					[Proposal:42]complete:56:=True:C214
					[Proposal:42]status:2:=$status
					[Proposal:42]dateOrdered:66:=Current date:C33
				End if 
				acceptPropsl
			End if 
			NEXT RECORD:C51([Proposal:42])
		End for 
		//ThermoClose 
		allowAlerts_boo:=$localPass
		UNLOAD RECORD:C212([Item:4])
		UNLOAD RECORD:C212([Order:3])
		UNLOAD RECORD:C212([OrderLine:49])
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([ProposalLine:43])
		UNLOAD RECORD:C212([Proposal:42])
		$showView:=True:C214
		vi1:=Records in set:C195("NewInvoices")
		vi2:=Records in set:C195("SkipOrders")
		vi3:=Records in set:C195("ProcOrders")
		vi4:=Records in set:C195("OrigOrders")
		If (vi1>1)
			<>ptCurTable:=(->[Order:3])
			USE SET:C118("NewInvoices")
			CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
			REDUCE SELECTION:C351(<>ptCurTable->; 0)
			<>prcControl:=1
			<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; "New Orders"; Current process:C322)
			Repeat 
				DELAY PROCESS:C323(Current process:C322; 30)
			Until (<>prcControl=0)
		End if 
		If (vi2>1)
			<>ptCurTable:=(->[Proposal:42])
			USE SET:C118("SkipOrders")
			CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
			REDUCE SELECTION:C351(<>ptCurTable->; 0)
			<>prcControl:=1
			<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; "Skipped Proposals"; Current process:C322)  //->[Proposal]
			Repeat 
				DELAY PROCESS:C323(Current process:C322; 30)
			Until (<>prcControl=0)
		End if 
		If (vi3>1)
			<>ptCurTable:=(->[Proposal:42])
			USE SET:C118("ProcOrders")
			CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
			REDUCE SELECTION:C351(<>ptCurTable->; 0)
			<>prcControl:=1
			<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; "Processed Proposals"; Current process:C322)  //->[Proposal]
			Repeat 
				DELAY PROCESS:C323(Current process:C322; 30)
			Until (<>prcControl=0)
		End if 
		USE SET:C118("OrigOrders")
		Prs_ListActive
		CLEAR SET:C117("OrigOrders")
		CLEAR SET:C117("NewInvoices")
		CLEAR SET:C117("SkipOrders")
		CLEAR SET:C117("OldOrders")
	End if 
End if 

REDRAW WINDOW:C456