//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/16/18, 12:51:39
// ----------------------------------------------------
// Method: pkCheckWeight
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	//Method: b51 #Ship button packing form
	Version_0501
	//Date: 08/19/05
	//Who: Jim Medlen
	//Description: 
End if 
// ### jwm ### 20141211_1017 tare weight over 40%
//PKWtScaleCalc 
//TRACE

C_TEXT:C284($vtTarePC)

// ### jwm ### 20141211_1054
// Trigger capture of Tare Weight
<>vrWeightTare:=-77777
C_LONGINT:C283($TickStart; $ticks)
$TickStart:=Tickcount:C458
$ticks:=Tickcount:C458-$TickStart
// Wait 3 seconds or until resets
While ((<>vrWeightTare=-77777) & ($ticks<180))
	// wait for PkScaleProcess to update Tare Weight
	DELAY PROCESS:C323(Current process:C322; 6)  // test length 1/10 second 6 ticks
	$ticks:=Tickcount:C458-$TickStart
End while 

Case of 
	: (iLoInteger1=1)  // ignore Weight over ride
		OBJECT SET ENABLED:C1123(b3; True:C214)
		//: (<>wtPrecisionPC><>wtPrecisionLimit)//What is this ???
		//<>pkScaleComment:="FULLY SHIPPED"
	: ((<>vrWeightTare<-0.07) & (<>vrWeightTare#-77777))
		<>pkScaleComment:="Negative Tare, Box Doubling?"
		PKAlertWindow
		OBJECT SET ENABLED:C1123(b3; False:C215)
		
	: (<>vrWeightErrPC><>wtPrecisionFinalPC)  //###jwm Final weight check
		<>pkScaleComment:="Weight Mismatch"
		PKAlertWindow
		OBJECT SET ENABLED:C1123(b3; False:C215)
		
	: (<>vrWeightTare=-77777)
		<>pkScaleComment:="Scale Missing, Click Tare"
		PKAlertWindow
		OBJECT SET ENABLED:C1123(b3; False:C215)
		
	: ((<>vrWeightTare/<>vrWeightScale*100)><>wtTarePC)  // ### jwm ### 20141211_1017 tare weight over <>wtTarePC
		$vtTarePC:=String:C10(Round:C94(<>vrWeightTare/<>vrWeightScale*100; 0))
		<>pkScaleComment:="Tare "+$vtTarePC+"%  > "+String:C10(<>wtTarePC)+"% Limit"
		PKAlertWindow
		OBJECT SET ENABLED:C1123(b3; False:C215)
		
	Else 
		If (<>pkScaleComment="OK")
			If (Size of array:C274(aLiItemNum)>0)
				OBJECT SET ENABLED:C1123(b3; True:C214)
				// PKBoxItemsTags 
			End if 
		Else 
			
			If (<>barcodeErrorSound#"")
				PLAY:C290(<>barcodeErrorSound)
			Else 
				BEEP:C151
				BEEP:C151
				BEEP:C151
			End if 
		End if 
		
End case 