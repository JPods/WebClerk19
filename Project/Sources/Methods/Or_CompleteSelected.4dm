//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 02:24:52
// ----------------------------------------------------
// Method: Or_CompleteSelected
// Description
// 
//
// Parameters
// ----------------------------------------------------
//### jwm ### 20130411_1353 changed <>tcsiteID to vsiteID

//October 25, 1995
C_LONGINT:C283($i; $k; $e; $w)
C_TEXT:C284($canItems)
C_REAL:C285($canDisc; $canValue)
ARRAY TEXT:C222(aCurSets; 0)
CONFIRM:C162("Are you sure you wish to Complete these "+String:C10(Records in set:C195("UserSet"))+" orders.")
If (OK=1)
	CONFIRM:C162("This change cannot be undone!!!")
	If (OK=1)
		USE SET:C118("UserSet")  //select the highlighted records    
		CREATE EMPTY SET:C140([Order:3]; "OrdCurrent")
		ARRAY TEXT:C222(aCurSets; 1)
		aCurSets{1}:="OrdCurrent"
		//    ON EVENT CALL("jotcCmdQAction")
		IVNT_dRayInit
		$k:=Records in selection:C76([Order:3])
		//ThermoInitExit ("Cancel Back-log";$k;True)
		$viProgressID:=Progress New
		
		FIRST RECORD:C50([Order:3])
		For ($i; 1; $k)
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Cancel Back-log")
			If (<>ThermoAbort)
				$i:=$k
			End if 
			$canItems:=""
			$canValue:=0
			LOAD RECORD:C52([Order:3])
			If (Not:C34(Locked:C147([Order:3])))
				If ([Order:3]complete:83<2)
					ADD TO SET:C119([Order:3]; "OrdCurrent")
					If ([Customer:2]customerID:1#[Order:3]customerID:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
					End if 
					[Customer:2]balanceOpenOrders:78:=[Customer:2]balanceOpenOrders:78-[Order:3]amountBackLog:54
					SAVE RECORD:C53([Customer:2])
					[Order:3]status:59:="Completed"
					[Order:3]lng:34:=DateTime_Enter
					[Order:3]dateInvoiceComp:6:=Current date:C33
					QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
					$w:=Records in selection:C76([OrderLine:49])
					FIRST RECORD:C50([OrderLine:49])
					For ($e; 1; $w)
						If ([OrderLine:49]qtyBackLogged:8>0)
							$dOnHand:=0
							$dOnOrd:=-[OrderLine:49]qtyBackLogged:8
							If ($dOnOrd#0)
								Invt_dRecCreate("SO"; [Order:3]idNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "Cancel Backorder"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; 0; -[OrderLine:49]qtyBackLogged:8; [OrderLine:49]unitCost:12; ""; vsiteID; 0)
							End if 
							[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6
							[OrderLine:49]qtyBackLogged:8:=0  //[OrderLine]QtyOrdered-[OrderLine]QtyShipped
							[OrderLine:49]backOrdAmount:26:=0
						End if 
						NEXT RECORD:C51([OrderLine:49])
					End for 
					[Order:3]amountBackLog:54:=0
					[Order:3]complete:83:=2
					SAVE RECORD:C53([Order:3])
				End if 
				INVT_dInvtApply
			Else 
				ADD TO SET:C119([Order:3]; "OrdCurrent")
			End if 
			NEXT RECORD:C51([Order:3])
		End for 
		TallyInventory
		UNLOAD RECORD:C212([Order:3])
		USE SET:C118("OrdCurrent")
		CLEAR SET:C117("OrdCurrent")
		ARRAY TEXT:C222(aCurSets; 0)
		// ON EVENT CALL("")
		//Thermo_Close 
		Progress QUIT($viProgressID)
	End if 
End if 




