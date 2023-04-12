//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKWtScaleRead
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
//TRACE
//<>vrWeightTare:=-77777//verify scale communication did not work

C_TEXT:C284($1; $cmdString)
C_LONGINT:C283($0; <>serialDelay)
C_REAL:C285(<>vrWeightScale)
C_TEXT:C284($strFromScale)
C_BOOLEAN:C305(<>vbPKScaleRead)

If (<>wtPrecision=0)
	<>wtPrecision:=3
End if 
//<>pkScaleComment:=""//clear any existing error message
pkReadScale:=True:C214
If (<>serialDelay=0)
	C_LONGINT:C283(<>serialDelay)
	<>serialDelay:=5
End if 
ON ERR CALL:C155("jOECNoAction")
C_TEXT:C284(pkScaleText; $pkScaleTextInc; $strFromScale)  //accumulated serial input
error:=0
$p:=0
OK:=1
<>vbPKScaleRead:=False:C215
<>scaleReturn:=""
SET CHANNEL:C77(21; 19466)
//SET CHANNEL(MacOS Serial Port ;Speed 9600 +Data bits 8 +Stop bits One +Parity None)


// Modified by: Bill James (2017-04-24T00:00:00)

If (OK=1)
	<>vtjwmError:=("OK = 1 and Error = "+String:C10(error))
	SET TIMEOUT:C268(10)  //set the length of the system error for timeout
	pkScaleText:=""
	SEND PACKET:C103("H"+"\r")  // SEND get weight command
	If (error#0)
		
		// Modified by: Bill James (2017-04-24T00:00:00)
		ConsoleLog("Scale: OK = 1 and Send Packet H Error = "+String:C10(error))
		<>pkScaleComment:="Scale: OK = 1, Error = "+String:C10(error)
	Else 
		$p:=0
		DELAY PROCESS:C323(Current process:C322; <>serialDelay)
		While ($p<10)
			RECEIVE BUFFER:C172($strFromScale)
			<>scaleReturn:=$strFromScale
			If ($strFromScale#"")  //&($strFromScale#"H@"))
				$strFromScale:=Substring:C12($strFromScale; 1; 100)  // chunk off status code and cr 
				$vrWeightScaleLast:=<>vrWeightScale
				$vrWeightScaleNow:=Round:C94(Num:C11(Substring:C12($strFromScale; 1; 12)); <>wtPrecision)
				
				Case of 
					: (Abs:C99($vrWeightScaleNow)<<>wtDitherFactor)
						<>vrWeightScale:=0
					: ((Abs:C99(Abs:C99($vrWeightScaleLast)-Abs:C99($vrWeightScaleNow)))><>wtDitherFactor)
						<>vrWeightScale:=$vrWeightScaleNow
				End case 
				
				If (False:C215)
					If ((Abs:C99(Abs:C99($vrWeightScaleLast)-Abs:C99($vrWeightScaleNow)))><>wtDitherFactor)
						<>vrWeightScale:=$vrWeightScaleNow
					End if 
				End if 
				<>vbPKScaleRead:=True:C214
				$p:=100000+15
			Else 
				$p:=$p+1
			End if 
		End while 
	End if 
Else 
	<>pkScaleComment:="Scale: OK = 0, Error = "+String:C10(error)
	<>vtjwmError:=("OK = 0 and Error = "+String:C10(error))
	ConsoleLog("Scale: OK = 0 and Error = "+String:C10(error))
End if 
//MESSAGE(String(<>vrWeightScale)+"; Error:  "+String(error)+"\r"+$strFromScale)
If ((error#0) | (OK=0) | ($p<1500))  //err
	$0:=1
Else 
	$0:=0
End if 