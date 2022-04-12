//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/02/07, 09:28:58
// ----------------------------------------------------
// Method: ShipCosts_InLineItem
// Description
// 
//
// Parameters
// ----------------------------------------------------
[Order:3]shipFreightCost:38:=0
[Order:3]shipMiscCosts:25:=0
[Order:3]shipAdjustments:26:=0
[Order:3]shipTotal:30:=0
Case of 
	: ([Order:3]amount:24<=20)
		[Order:3]shipAdjustments:26:=7.5
	: ([Order:3]amount:24<=35)
		[Order:3]shipAdjustments:26:=8.5
	: ([Order:3]amount:24<=45)
		[Order:3]shipAdjustments:26:=9.5
	: ([Order:3]amount:24<=60)
		[Order:3]shipAdjustments:26:=10.5
	: ([Order:3]amount:24<=80)
		[Order:3]shipAdjustments:26:=11.5
	: ([Order:3]amount:24<=100)
		[Order:3]shipAdjustments:26:=12.5
	: ([Order:3]amount:24<=125)
		[Order:3]shipAdjustments:26:=14.5
	: ([Order:3]amount:24<=170)
		[Order:3]shipAdjustments:26:=17.5
	: ([Order:3]amount:24<=200)
		[Order:3]shipAdjustments:26:=19.5
	: ([Order:3]amount:24<=250)
		[Order:3]shipAdjustments:26:=21.5
	Else   //: ([Order]Amount<more than$250)
		[Order:3]shipAdjustments:26:=Round:C94(0.095*[Order:3]amount:24; 2)
End case 


