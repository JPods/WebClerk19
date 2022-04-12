// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 04/20/10, 13:57:40
// ----------------------------------------------------
// Method: Object Method: <>aShipVia
// Description
// Form: [Order]iOrders_9
//
// Parameters
// ----------------------------------------------------

If (<>FreightService=2)
	If (bCalcNow=1)
		
	End if 
	If (Undefined:C82(aShipVia))  // interpretted only avoild undefined
		ARRAY TEXT:C222(aShipVia; 0)
		If (False:C215)
			ARRAY TEXT:C222(aShipVia; 4)
			aShipVia{1}:="Ship Cost Request"
			
			
			vtGroundValue:="5"
			vtGround:="Ground: "+vtGroundValue
			aShipVia{2}:=vtGround
			
			vt2DayValue:="10"
			vt2Day:="Second Day: "+vt2DayValue
			aShipVia{3}:=vt2Day
			
			vtNextDayValue:="20"
			vtNextDay:="Next Day: "+vtNextDayValue
			aShipVia{4}:=vtNextDay
		End if 
	End if 
	If (Size of array:C274(aShipVia)=0)
		ARRAY TEXT:C222(aShipVia; 1)
		aShipVia:=1
		aShipVia{1}:="Ship Cost Request"
	End if 
	If (Self:C308->=1)
		C_TEXT:C284(vtGround; vt2Day; vtNextDay)
		If (vtGround="")
			vtGround:="ground"
		End if 
		If (vt2Day="")
			vt2Day:="2day"
		End if 
		If (vtNextDay="")
			vtNextDay:="nextday"
		End if 
		XML_FedExRateRequest
		ARRAY TEXT:C222(aShipVia; 4)
		aShipVia{1}:="ShipVia Request"
		aShipVia{2}:=vtGround
		aShipVia{3}:=vt2Day
		aShipVia{4}:=vtNextDay
		
		If (False:C215)
			ARRAY TEXT:C222(aShipVia; 4)
			aShipVia{1}:="ShipVia Request"
			
			
			vtGroundValue:="5"
			vtGround:="Ground: "+vtGroundValue
			aShipVia{2}:=vtGround
			
			vt2DayValue:="10"
			vt2Day:="Second Day: "+vt2DayValue
			aShipVia{3}:=vt2Day
			
			vtNextDayValue:="20"
			vtNextDay:="Next Day: "+vtNextDayValue
			aShipVia{4}:=vtNextDay
			
			
		End if 
	Else 
		[Order:3]shipVia:13:=(Self:C308->{Self:C308->})
		Case of 
			: (aShipVia=2)
				[Order:3]shipFreightCost:38:=Num:C11(vtGroundValue)
			: (aShipVia=3)
				[Order:3]shipFreightCost:38:=Num:C11(vt2DayValue)
			: (aShipVia=4)
				[Order:3]shipFreightCost:38:=Num:C11(vtNextDayValue)
		End case 
		bCalcNow:=1
	End if 
End if 