//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKWtScaleCalc
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
KeyModifierCurrent
If (CapKey=1)
	TRACE:C157
End if 
C_REAL:C285(<>vrWeightScale)
C_LONGINT:C283(viWtPrecision)
If (viWtPrecision=0)
	viWtPrecision:=3
End if 
<>pkScaleComment:=""  //clear any existing error message
pkReadScale:=True:C214
//Procedure: CC_ZonGetText
//Procedure polls the serial port
//TRACE
ON ERR CALL:C155("jOECNoAction")
C_TEXT:C284(pkScaleText; $pkScaleTextInc; $ZonJrText)  //accumulated serial input
C_LONGINT:C283($p)
SET CHANNEL:C77(21; 19466)
If (OK=1)
	//SET CHANNEL(MacOS Printer Port;Speed 9600+Data bits 7+Stop bits One+Parity Even)
	SET TIMEOUT:C268(10)  //set the length of the system error for timeout
	pkScaleText:=""
	SEND PACKET:C103("W"+"\r")  // SEND get weight command
	$p:=0
	While ($p<1000)
		RECEIVE BUFFER:C172($ZonJrText)
		If ($ZonJrText#"")
			pkScaleText:=$ZonJrText
			pkScaleText:=Substring:C12(pkScaleText; 1; 11)  // chunk off status code and cr
			//      
			<>vrWeightScale:=Round:C94(Num:C11(pkScaleText); viWtPrecision)
			REDRAW WINDOW:C456
			$p:=100000+15
		Else 
			$p:=$p+1
		End if 
	End while 
	If ($p<10000)
		<>pkScaleComment:="No reading from scale"
		PKAlertWindow
	Else 
		$varianceAllowed:=Round:C94(<>vrWeightScale*<>wtPrecisionPC*0.01; 2)
		$scaleDiff:=<>vrWeightScale-<>vrWeightProduct
		If (<>vrWeightScale#0)
			$perCentDiff:=Round:C94(((<>vrWeightScale-<>vrWeightProduct)/<>vrWeightScale)*100; 1)
		Else 
			$perCentDiff:=100
		End if 
		If (Abs:C99($scaleDiff)>$varianceAllowed)  //let pass a good weight
			If ($scaleDiff>0)
				<>pkScaleComment:="Scale Over By: "+String:C10(Abs:C99($scaleDiff))+" Per Cent: "+String:C10(Abs:C99($perCentDiff))+"\r"+"Scale: "+String:C10(<>vrWeightScale)+"\r"+"Expected: "+String:C10(<>vrWeightProduct)
			Else 
				<>pkScaleComment:="Scale Under By: "+String:C10(Abs:C99($scaleDiff))+" Per Cent: "+String:C10(Abs:C99($perCentDiff))+"\r"+"Scale: "+String:C10(<>vrWeightScale)+"\r"+"Expected: "+String:C10(<>vrWeightProduct)
			End if 
			PKAlertWindow
		End if 
	End if 
	vtZonJrText:=""
Else 
	<>pkScaleComment:="No reading from scale"
	PKAlertWindow
End if 


