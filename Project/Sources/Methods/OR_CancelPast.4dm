//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/16/10, 17:35:58
// ----------------------------------------------------
// Method: OR_CancelPast
// Description
// 
//
// Parameters
// ----------------------------------------------------
//October 25, 1995
//### jwm ### 20130411_0921 changed <>tcsiteID to [Order]siteID
If (UserInPassWordGroup("AdminControl"))
	C_LONGINT:C283($i; $k; $e; $w)
	C_TEXT:C284($canItems)
	C_REAL:C285($canDisc; $canValue)
	ARRAY TEXT:C222(aCurSets; 0)
	KeyModifierCurrent
	
	$doDone:=0
	If (allowAlerts_boo)
		If (OptKey=0)
			CONFIRM:C162("Are you sure you wish to CANCEL these "+String:C10(Records in set:C195("UserSet"))+" orders.")
		Else 
			CONFIRM:C162("Complete these "+String:C10(Records in set:C195("UserSet"))+" orders without affective inventory.")
			$doDone:=1
		End if 
	Else 
		OK:=1
	End if 
	If (OK=1)
		If (allowAlerts_boo)
			CONFIRM:C162("This change cannot be undone!!!")
		End if 
		If (OK=1)
			If (allowAlerts_boo)
				USE SET:C118("UserSet")  //select the highlighted records    
				CREATE EMPTY SET:C140([Order:3]; "OrdCurrent")
			End if 
			ARRAY TEXT:C222(aCurSets; 1)
			aCurSets{1}:="OrdCurrent"
			//    ON EVENT CALL("jotcCmdQAction")
			IVNT_dRayInit
			$k:=Records in selection:C76([Order:3])
			If (allowAlerts_boo)
				//ThermoInitExit ("Cancel Back-log";$k;True)
				$viProgressID:=Progress New
				
			End if 
			FIRST RECORD:C50([Order:3])
			TRACE:C157
			READ WRITE:C146([OrderLine:49])
			For ($i; 1; $k)
				If (allowAlerts_boo)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Cancel Back-log")
					If (<>ThermoAbort)
						$i:=$k
					End if 
				End if 
				$canItems:=""
				$canValue:=0
				LOAD RECORD:C52([Order:3])
				If (Not:C34(Locked:C147([Order:3])))
					If ([Order:3]complete:83<2)
						transactionActive:=True:C214
						START TRANSACTION:C239
						SET QUERY AND LOCK:C661(True:C214)
						QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
						If (OK=0)  // there are locked records
							CANCEL TRANSACTION:C241
						Else 
							
							If (allowAlerts_boo)
								ADD TO SET:C119([Order:3]; "OrdCurrent")
							End if 
							If ($doDone=0)
								[Order:3]amountCancel:60:=[Order:3]amountBackLog:54
							End if 
							If ([Customer:2]customerID:1#[Order:3]customerID:1)
								QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
							End if 
							[Customer:2]balanceOpenOrders:78:=[Customer:2]balanceOpenOrders:78-[Order:3]amountBackLog:54
							SAVE RECORD:C53([Customer:2])
							If ($doDone=0)
								[Order:3]status:59:="Cancel"
							End if 
							[Order:3]lng:34:=DateTime_Enter
							[Order:3]dateInvoiceComp:6:=Current date:C33
							$w:=Records in selection:C76([OrderLine:49])
							FIRST RECORD:C50([OrderLine:49])
							For ($e; 1; $w)
								If ([OrderLine:49]qtyBackLogged:8>0)
									$dOnHand:=0
									$dOnOrd:=-[OrderLine:49]qtyBackLogged:8
									If (($dOnOrd#0) & ($doDone=0))
										Invt_dRecCreate("SO"; [Order:3]idNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "Cancel Backorder"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; 0; -[OrderLine:49]qtyBackLogged:8; [OrderLine:49]unitCost:12; ""; vsiteID; 0)
									End if 
									If ($doDone=0)
										$canDisc:=(1-([OrderLine:49]discount:10*0.01))
										$canValue:=[OrderLine:49]unitPrice:9*[OrderLine:49]qtyBackLogged:8*$canDisc
										$canItems:=$canItems+[OrderLine:49]itemNum:4+"\t"+[OrderLine:49]description:5+"\t"+String:C10([OrderLine:49]qtyBackLogged:8)+"\t"+String:C10($canValue)+"\r"
										[OrderLine:49]qty:6:=[OrderLine:49]qtyShipped:7
										[OrderLine:49]extendedWt:21:=[OrderLine:49]unitWt:20*[OrderLine:49]qty:6
									Else 
										[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6
									End if 
									//
									[OrderLine:49]qtyBackLogged:8:=0  //[OrderLine]'QtyOrdered-[OrderLine]'QtyShipped
									//
									$discnt:=(1-([OrderLine:49]discount:10*0.01))
									[OrderLine:49]extendedPrice:11:=Round:C94(([OrderLine:49]qty:6*[OrderLine:49]unitPrice:9)*$discnt; <>tcDecimalTt)
									[OrderLine:49]salesTax:15:=Round:C94((Num:C11([OrderLine:49]taxJuris:14))*[OrderLine:49]extendedPrice:11*sTaxRate; <>tcDecimalTt)
									[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]qty:6*[OrderLine:49]unitCost:12; <>tcDecimalTt)
									If (<>tcSaleMar=1)  //Sales Amount
										[OrderLine:49]commSales:17:=Round:C94([OrderLine:49]extendedPrice:11*[OrderLine:49]commRateSales:29*0.01; <>tcDecimalTt)
										[OrderLine:49]commRep:16:=Round:C94([OrderLine:49]extendedPrice:11*[OrderLine:49]commRateRep:18*0.01; <>tcDecimalTt)
									Else 
										$ComAmt:=([OrderLine:49]extendedPrice:11-[OrderLine:49]extendedCost:13)
										[OrderLine:49]commSales:17:=Round:C94($ComAmt*[OrderLine:49]commRateSales:29*0.01; <>tcDecimalTt)
										[OrderLine:49]commRep:16:=Round:C94($ComAmt*[OrderLine:49]commRateRep:18*0.01; <>tcDecimalTt)
									End if 
									If ([OrderLine:49]qtyBackLogged:8>0)
										[OrderLine:49]backOrdAmount:26:=Round:C94([OrderLine:49]qtyBackLogged:8*[OrderLine:49]unitPrice:9*$discnt; <>tcDecimalTt)
									Else 
										[OrderLine:49]backOrdAmount:26:=0
									End if 
									SAVE RECORD:C53([OrderLine:49])
								End if 
								NEXT RECORD:C51([OrderLine:49])
							End for 
							If ($doDone=0)
								[Order:3]commentProcess:12:=$canItems+[Order:3]commentProcess:12
							End if 
							[Order:3]amountBackLog:54:=0
							OrderCalcArrays
							If ($doDone=0)  // closing, not canceling  
								[Order:3]status:59:="Cancel"
								SAVE RECORD:C53([Order:3])
							End if 
							// [Order]CompleteID should be 2
							
							VALIDATE TRANSACTION:C240
							
							If (False:C215)
								[Order:3]amountBackLog:54:=Sum:C1([OrderLine:49]backOrdAmount:26)
								[Order:3]amount:24:=Sum:C1([OrderLine:49]extendedPrice:11)
								[Order:3]totalCost:42:=Sum:C1([OrderLine:49]extendedCost:13)
								[Order:3]weightEstimate:49:=Sum:C1([OrderLine:49]extendedWt:21)
								[Order:3]repCommission:9:=Sum:C1([OrderLine:49]commRep:16)
								[Order:3]salesCommission:11:=Sum:C1([OrderLine:49]commSales:17)
								If ([Order:3]amount:24>0)
									[Order:3]grossMargin:47:=Trunc:C95(([Order:3]amount:24-[Order:3]totalCost:42)/[Order:3]amount:24*100; 1)
								Else 
									[Order:3]grossMargin:47:=0
								End if 
								[Order:3]shipTotal:30:=Round:C94([Order:3]shipMiscCosts:25+[Order:3]shipAdjustments:26+[Order:3]shipFreightCost:38+0.001; <>tcDecimalTt)
								[Order:3]total:27:=Round:C94([Order:3]amount:24+[Order:3]salesTax:28+[Order:3]shipTotal:30; <>tcDecimalTt)
								[Order:3]complete:83:=2
								
								SAVE RECORD:C53([Order:3])
							End if 
							
							If ($doDone=0)
								INVT_dInvtApply
							End if 
						End if 
						SET QUERY AND LOCK:C661(False:C215)
					End if 
				Else 
					If (allowAlerts_boo)
						ADD TO SET:C119([Order:3]; "OrdCurrent")
					End if 
				End if 
				If (allowAlerts_boo)
					NEXT RECORD:C51([Order:3])
				End if 
			End for 
			READ ONLY:C145([OrderLine:49])
			TallyInventory
			If (allowAlerts_boo)
				UNLOAD RECORD:C212([Order:3])
				USE SET:C118("OrdCurrent")
				CLEAR SET:C117("OrdCurrent")
				ARRAY TEXT:C222(aCurSets; 0)
				// ON EVENT CALL("")
				//Thermo_Close 
				Progress QUIT($viProgressID)
			End if 
		End if 
	End if 
End if 