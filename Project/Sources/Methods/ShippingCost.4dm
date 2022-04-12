//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/24/13, 23:58:55
// ----------------------------------------------------
// Method: ShippingCost
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($doEst)
C_REAL:C285($stdPackCost; $packWt; $TotalWt; $variPackCos; $grndTrak; $insure)
C_LONGINT:C283($packCnt; $sign; $doCOD)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)  //July 11, 1993 added 7th for invoices with multiple boxes
//ShippingCost (->[Invoice]ShipVia;->[Invoice]Zone;->[Invoice]WeightEstimate;
//->[Invoice]ShipFreightCost;->[Invoice]ShipMiscCosts;
//->[Invoice]ShipAdjustments;->[Invoice]Terms;->[Invoice]Amount;->[Invoice]LabelCount)
//### jwm ### 20110215_1055 deleted call to TallyMaster ShippingCalc
If ($1->#"")
	If (($2->=-1) | ($2->=0))
		//do nothing    
	Else 
		//should this also be Orders
		Case of 
			: ((ptCurTable=(->[Invoice:26])) & (Records in selection:C76([LoadTag:88])>0))
				$doEst:=False:C215
			: ((ptCurTable=(->[Order:3])) & (Records in selection:C76([LoadTag:88])>0))  //### jwm ### 20120102_1311 calculate actual cost for an order for Proforma Invoice
				$doEst:=False:C215
			Else 
				$doEst:=True:C214
		End case 
		READ ONLY:C145([Carrier:11])
		QUERY:C277([Carrier:11]; [Carrier:11]active:6=True:C214; *)
		QUERY:C277([Carrier:11];  & [Carrier:11]carrierid:10=$1->)
		If (Records in selection:C76([Carrier:11])=1)
			Case of 
				: ([Carrier:11]script:37#"")  //### jwm ### 20110215
					ExecuteText(0; [Carrier:11]script:37)
					// Modified by: Bill James (2015-02-17T00:00:00 moved this to the first condition)
				: (([Carrier:11]status:45="Web based") | ([Carrier:11]status:45="Webbased") | ([Carrier:11]status:45="SOAP"))
					C_LONGINT:C283($error)
					C_BLOB:C604(HTTP_IncomingBlob)
					C_LONGINT:C283($sizeResponse)
					SET BLOB SIZE:C606(HTTP_Data; 0)
					$sizeResponse:=WC_Request("GET"; HTTP_URL+"/heart_beat"; "")  //Sends empth 
					//  process
					SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
					
				: ([Carrier:11]factor:5<0)
					//[Order]ShipFreightCost;[Order]ShipMiscCosts;[Order]ShipAdjustments   
					$4->:=Round:C94(Abs:C99([Carrier:11]factor:5)*$8->; <>tcDecimalTt)
					$5->:=Round:C94(Abs:C99([Carrier:11]cODCharge:7)*$8->; <>tcDecimalTt)
					$6->:=Round:C94(Abs:C99([Carrier:11]handlingCharge:9)*$8->; <>tcDecimalTt)
				: (($2->=[Carrier:11]zone2:12) | ($2->=[Carrier:11]zone3:13) | ($2->=[Carrier:11]zone4:14) | ($2->=[Carrier:11]zone5:15) | ($2->=[Carrier:11]zone6:16) | ($2->=[Carrier:11]zone7:17) | ($2->=[Carrier:11]zone8:18) | ($2->=[Carrier:11]zone9:29) | ($2->=[Carrier:11]zone10:30) | ($2->=[Carrier:11]zone11:31))
					//TRACE
					$doCOD:=Num:C11($7->=<>tcCODTerm)
					$TotalWt:=Abs:C99($3->)*[Carrier:11]factor:5
					If ($3-><0)
						$sign:=-1
					Else 
						$sign:=1
					End if 
					$avgBoxWt:=Round:C94([Carrier:11]avgBoxWt:8; 0)  //Rounded avg Box wt
					If ($doEst)
						If (($TotalWt>[Carrier:11]avgBoxWt:8) & ([Carrier:11]avgBoxWt:8>0))
							$packCnt:=Trunc:C95(($TotalWt/[Carrier:11]avgBoxWt:8); 0)  //Number of boxes
							$packWt:=Round:C94($TotalWt-([Carrier:11]avgBoxWt:8*$packCnt); 0)  //remaining box wt    
							$stdPackCost:=shipWtCost($avgBoxWt; $2)  //cost per box  
						Else   //Invoices
							$packCnt:=0
							$packWt:=$TotalWt
							$stdPackCost:=0
						End if 
						$variPackCos:=shipWtCost($packWt; $2)  //cost left over box or cost of one box  
						//### jwm ### 20110309 Add Fuel Factor to Estimate
						If (([Carrier:11]fuelFactor:35>0) & ([Carrier:11]fuelFactor:35<=1))
							$variPackCos:=$variPackCos*([Carrier:11]fuelFactor:35+1)
						End if 
						If ([Carrier:11]costType:20)
							$4->:=Round:C94(($packCnt*$stdPackCost)+$variPackCos; <>tcDecimalTt)*$sign
						Else 
							$4->:=Round:C94(($avgBoxWt*$stdPackCost*$packCnt)+($variPackCos*$packWt); <>tcDecimalTt)*$sign
						End if 
						$packCnt:=$packCnt+1  //add in the left over box or the one box          
						$5->:=(Round:C94($packCnt*[Carrier:11]cODCharge:7*$doCOD; <>tcDecimalTt)+(Num:C11([Invoice:26]shipInstruct:40="Call Tag")*[Carrier:11]callTagRate:26))*$sign
						If ($6->=0)
							$6->:=Round:C94($packCnt*[Carrier:11]handlingCharge:9; <>tcDecimalTt)*$sign  //handling charges
						End if 
						If (Count parameters:C259=9)
							$9->:=$packCnt
						End if 
					Else   //                             // // // //Invoices with multiple boxes defined.
						
						If (Records in selection:C76([LoadTag:88])>0)
							$packCnt:=Records in selection:C76([LoadTag:88])
							FIRST RECORD:C50([LoadTag:88])
							$variPackCos:=0
							$TotalWt:=0
							$sumPackCost:=0
							$grndTrak:=0
							$insure:=0
							$insureTotal:=0
							$otherCharge:=0
							$codCharge:=0
							For ($i; 1; $packCnt)
								$variPackCos:=shipWtCost(Round:C94(Abs:C99([LoadTag:88]weightExtended:2)+0.4999; 0); $2)  //cost left over box   
								If ([Carrier:11]costType:20)  // true = per shipment / package
									[LoadTag:88]costShipment:13:=Round:C94($variPackCos; <>tcDecimalTt)*$sign
								Else   // false = per weight (total weight of shipment / all packages)
									[LoadTag:88]costShipment:13:=Round:C94($variPackCos*[LoadTag:88]weightExtended:2; <>tcDecimalTt)*$sign
								End if 
								
								// multiply [Invoice]MultipleFreight'Charges*([Carrier]Fuelfactor+1)
								If (([Carrier:11]fuelFactor:35>0) & ([Carrier:11]fuelFactor:35<=1))
									[LoadTag:88]costShipment:13:=[LoadTag:88]costShipment:13*([Carrier:11]fuelFactor:35+1)
								End if 
								
								$grndTrak:=$grndTrak+((Num:C11([LoadTag:88]trackThis:31>0))*[Carrier:11]trackingRate:25)*$sign
								C_REAL:C285($insureAmt)
								//$insureAmt:=[LoadTag]Value-[Carrier]InsureAt
								$insureAmt:=[LoadTag:88]value:24
								//(Not(([Carrier]InsureIncrement=0)|($insureAmt<=[Carrier]InsureIncrement)|([LoadTag]UPS_InsureShipping)))
								
								If (([Carrier:11]insureIncrement:23#0) & ($insureAmt>[Carrier:11]insureAt:27) & ([LoadTag:88]upsInsureShipping:30))
									$insure:=Round:C94([Carrier:11]insuranceRate:24*(($insureAmt-0.001)\[Carrier:11]insureIncrement:23); <>tcDecimalTt)*$sign
									If (($insure>0) & ($insure<[Carrier:11]insureMinumumCharge:39))
										$insure:=[Carrier:11]insureMinumumCharge:39
									End if 
									$insureTotal:=$insureTotal+$insure
								End if 
								
								$codCharge:=$codCharge+(Num:C11([LoadTag:88]callTag:32)*[Carrier:11]callTagRate:26)
								$codCharge:=$codCharge+Round:C94(Num:C11([LoadTag:88]value:24#0)*$doCOD*[Carrier:11]cODCharge:7; <>tcDecimalTt)*$sign
								$TotalWt:=$TotalWt+[LoadTag:88]weightExtended:2
								$sumPackCost:=$sumPackCost+[LoadTag:88]costShipment:13
								// Modified by: Bill James (2015-12-29T00:00:00 Subrecord eliminated, [Invoice]MultipleFreight'OtherCharges)
								$otherCharge:=$otherCharge+[LoadTag:88]costOther:33
								If ((Substring:C12([Carrier:11]carrierid:10; 1; 3)="UPS") & ([LoadTag:88]trackingid:7=""))
									[LoadTag:88]trackingid:7:=Ship_UPSBarCode([Invoice:26]shipVia:5; $i)
								End if 
								NEXT RECORD:C51([LoadTag:88])
							End for 
							$3->:=$TotalWt
							$4->:=Round:C94($sumPackCost; <>tcDecimalTt)*$sign
							//$5->:=Round($grndTrak+$insureTotal+$codCharge+$otherCharge;<>tcDecimalTt)*$sign
							$5->:=Round:C94($grndTrak+$insureTotal+$codCharge; <>tcDecimalTt)*$sign  // ### jwm ### 20171128_1120
							If ($6->=0)
								If ($otherCharge=0)
									$6->:=Round:C94(($packCnt*[Carrier:11]handlingCharge:9)*$sign; <>tcDecimalTt)*$sign  //handling charges
								Else 
									$6->:=$otherCharge  //handling charges
								End if 
							End if 
							If (Count parameters:C259=9)
								$9->:=$packCnt
							End if 
						End if 
					End if 
				Else 
					If (allowAlerts_boo)
						jAlertMessage(9282)
					End if 
					$2->:=-1
			End case 
		Else 
			If (allowAlerts_boo)
				jAlertMessage(9283)
			End if 
			$2->:=-1
		End if 
		READ WRITE:C146([Carrier:11])
	End if 
Else 
	$2->:=-1
End if 




UNLOAD RECORD:C212([Carrier:11])
