//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/24/13, 23:45:23
// ----------------------------------------------------
// Method: PKShippingCost
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_BOOLEAN:C305(vb_InsureShipping; vbContinue)
C_TEXT:C284(vtCarrierID; vtZip)
C_REAL:C285(vrWeight; vrValue; vrCost; vrFuelFactor; vrInsurance; insure)

//Initialize Variables:
vtCarrierID:=[LoadTag:88]carrierid:8
vtZip:=[Invoice:26]zip:12
vrWeight:=[LoadTag:88]weightExtended:2
vrWeight:=Round:C94((vrWeight+0.499); 0)
vrValue:=[LoadTag:88]value:24
vb_InsureShipping:=[LoadTag:88]upsInsureShipping:30
vbContinue:=True:C214
vrCost:=0
vrInsurance:=0
Insure:=0

QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=vtCarrierID; *)
QUERY:C277([Carrier:11];  & [Carrier:11]active:6=True:C214; *)
QUERY:C277([Carrier:11])
C_BOOLEAN:C305(<>vbCarrierRelated)

vtZip:=Substring:C12(vtZip; 1; [Carrier:11]zipLength:19)

QUERY:C277([CarrierZone:143]; [CarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44; *)
QUERY:C277([CarrierZone:143];  & [CarrierZone:143]zipHigh:2>=vtZip; *)
QUERY:C277([CarrierZone:143];  & [CarrierZone:143]zipLow:1<=vtZip; *)

If ([Invoice:26]siteid:86#"")  // ### jwm ### 20171018_1458
	QUERY:C277([CarrierZone:143]; [CarrierZone:143]siteid:8=[Invoice:26]siteid:86; *)  // ### jwm ### 20160307_1425 there can be multiple zone siteID's for each Carrier
End if 

QUERY:C277([CarrierZone:143])

If (Records in selection:C76([CarrierZone:143])=0)
	viZone:=-1
Else 
	FIRST RECORD:C50([CarrierZone:143])
	
	viZone:=[CarrierZone:143]zone:3
End if 
vtZone:=String:C10(viZone)
If (viZone=-1)
	vrCost:=0
Else 
	QUERY:C277([CarrierWeight:144]; [CarrierWeight:144]idNumCarrier:13=[Carrier:11]idNum:44; *)
	QUERY:C277([CarrierWeight:144];  & [CarrierWeight:144]weight:1>=vrWeight)  //  ### jwm ### 20131207_2202
	ORDER BY:C49([CarrierWeight:144]; [CarrierWeight:144]weight:1)
	FIRST RECORD:C50([CarrierWeight:144])
	If ([Carrier:11]script:37="")
		Case of   //find shipping cost for the defined wt and zone
			: (viZone=[Carrier:11]zone2:12)
				vrCost:=[CarrierWeight:144]cost2:2
			: (viZone=[Carrier:11]zone3:13)
				vrCost:=[CarrierWeight:144]cost3:3
			: (viZone=[Carrier:11]zone4:14)
				vrCost:=[CarrierWeight:144]cost4:4
			: (viZone=[Carrier:11]zone5:15)
				vrCost:=[CarrierWeight:144]cost5:5
			: (viZone=[Carrier:11]zone6:16)
				vrCost:=[CarrierWeight:144]cost6:6
			: (viZone=[Carrier:11]zone7:17)
				vrCost:=[CarrierWeight:144]cost7:7
			: (viZone=[Carrier:11]zone8:18)
				vrCost:=[CarrierWeight:144]cost8:8
			: (viZone=[Carrier:11]zone9:29)
				vrCost:=[CarrierWeight:144]cost9:9
			: (viZone=[Carrier:11]zone10:30)
				vrCost:=[CarrierWeight:144]cost10:10
			: (viZone=[Carrier:11]zone11:31)
				vrCost:=[CarrierWeight:144]cost11:11
		End case 
	Else 
		//set the value of vrCost
		ExecuteText(0; [Carrier:11]script:37)
	End if 
End if 

//test hundred weight ### jwm ### 20110413
If (vrWeight>150)
	vrCost:=vrWeight*vrCost
	//### jwm ### 20110309 hundred weight value listed in chart above 150 (ie 99999 lbs) 
	//needs to be greater than weight of entire Shipment and above hundred weight Limit
End if 

If (([Carrier:11]insureIncrement:23#0) & (vrValue>[Carrier:11]insureAt:27) & (vb_InsureShipping))
	insure:=Round:C94([Carrier:11]insuranceRate:24*((vrValue-0.001)\[Carrier:11]insureIncrement:23); <>tcDecimalTt)
	If ((insure>0) & (insure<[Carrier:11]insureMinumumCharge:39))
		insure:=[Carrier:11]insureMinumumCharge:39
	End if 
	vrInsurance:=insure
End if 

[LoadTag:88]costInsurance:15:=vrInsurance
[LoadTag:88]costShipment:13:=vrCost
vrFuelFactor:=(vrCost*[Carrier:11]fuelFactor:35)
vrFuelFactor:=Round:C94(vrFuelFactor; 2)
[LoadTag:88]costFuelCharge:45:=vrFuelFactor
vrCost:=vrCost+vrFuelFactor
vrFreight:=vrCost
[LoadTag:88]costEstimate:38:=vrFreight
vrCost:=vrCost+[Carrier:11]handlingCharge:9
vrCost:=vrCost+vrInsurance
vrHandlingCharge:=Round:C94([Carrier:11]handlingCharge:9; 2)
[LoadTag:88]costOther:33:=vrHandlingCharge
vrCost:=Round:C94(vrCost; 2)
[LoadTag:88]costTotal:47:=vrCost

UNLOAD RECORD:C212([Carrier:11])
