//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 12:23:13
// ----------------------------------------------------
// Method: shipWtCost
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285($1; $0)
C_POINTER:C301($2)
C_LONGINT:C283(viZone)
C_BOOLEAN:C305(<>vbCarrierRelated)

vrWeight:=$1
viZone:=$2->
vrCost:=0
vtZone:=String:C10(viZone)


QUERY:C277([CarrierWeight:144]; [CarrierWeight:144]idNumCarrier:13=[Carrier:11]idNum:44; *)
QUERY:C277([CarrierWeight:144];  & [CarrierWeight:144]weight:1>=vrWeight)
If (Records in selection:C76([CarrierWeight:144])=0)
	If (allowAlerts_boo)
		jAlertMessage(9280)
	End if 
Else 
	ORDER BY:C49([CarrierWeight:144]; [CarrierWeight:144]weight:1)
	FIRST RECORD:C50([CarrierWeight:144])
	If ([Carrier:11]script:37#"")
		//set the value of vrCost
		ExecuteText(0; [Carrier:11]script:37)
	Else 
		Case of   //find shipping cost for the defined wt and zone
			: ($2->=[Carrier:11]zone2:12)
				$0:=[CarrierWeight:144]cost2:2
			: ($2->=[Carrier:11]zone3:13)
				$0:=[CarrierWeight:144]cost3:3
			: ($2->=[Carrier:11]zone4:14)
				$0:=[CarrierWeight:144]cost4:4
			: ($2->=[Carrier:11]zone5:15)
				$0:=[CarrierWeight:144]cost5:5
			: ($2->=[Carrier:11]zone6:16)
				$0:=[CarrierWeight:144]cost6:6
			: ($2->=[Carrier:11]zone7:17)
				$0:=[CarrierWeight:144]cost7:7
			: ($2->=[Carrier:11]zone8:18)
				$0:=[CarrierWeight:144]cost8:8
			: ($2->=[Carrier:11]zone9:29)
				$0:=[CarrierWeight:144]cost9:9
			: ($2->=[Carrier:11]zone10:30)
				$0:=[CarrierWeight:144]cost10:10
			: ($2->=[Carrier:11]zone11:31)
				$0:=[CarrierWeight:144]cost11:11
		End case 
	End if 
	If (($0=0) & (allowAlerts_boo))
		// Modified by: William James (2013-12-09T00:00:00)
		// changed zero to an acceptable answer
		// jAlertMessage (9281)
	End if 
End if 