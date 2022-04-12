//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: PkScaleProcess
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
	// ### jwm ### 20141210_2345 <>vrWeightDeviation alternate calculation if no reading from scale 
	// ### jwm ### 20141210_2241 added dither percent of total weight
	// ### jwm ### 20141210_2241 added percentage of dither to allowed deviation
End if 
//
C_LONGINT:C283($procNum; $err; $cntStable; $cntChange)
C_REAL:C285(<>closeScale; <>vrWeightStable; <>vrWeightChange)
<>closeScale:=1
$procNum:=Prs_CheckRunnin("Packing")
//TRACE
$cnt:=0

Repeat 
	DELAY PROCESS:C323(Current process:C322; 10)  //tics_jwm_changed from 20 to 10
	//PKWtScaleCalc 
	$err:=PKWtScaleRead
	//MESSAGE(String(<>vrWeightScale)+"; Error:  "+string(error))
	
	//###jwm check weight change
	If (<>vrWeightStable=<>vrWeightScale)
		If ($cntStable<6)
			$cntStable:=$cntStable+1
		End if 
		If ($cntStable=6)
			$cntChange:=0
			<>vrWeightStable:=<>vrWeightScale
		End if 
	Else 
		If ($cntChange<3)
			$cntChange:=$cntChange+1
		End if 
		If ($cntChange=3)
			$cntStable:=0
			<>vrWeightChange:=<>vrWeightStable-<>vrWeightScale
		End if 
	End if 
	//<>vrWeightErrPC
	If ($err=0)
		If (<>vrWeightTare=-77777)  // Tare Button Clicked
			<>vrWeightTare:=<>vrWeightScale-<>vrWeightProduct
			// ### jwm ### 20141210_2345 calculate <>vrWeightDeviation 
			<>vrWeightDeviation:=<>vrWeightProduct+<>vrWeightTare-<>vrWeightScale
		Else 
			<>vrWeightDeviation:=<>vrWeightProduct+<>vrWeightTare-<>vrWeightScale
			If (<>vrWeightScale#0)
				<>vrWeightErrPC:=Abs:C99(Round:C94((<>vrWeightProduct+<>vrWeightTare-<>vrWeightScale)/<>vrWeightScale*100; 1))
				<>wtDitherPC:=Abs:C99(Round:C94(<>wtDitherFactor/<>vrWeightScale*100; 1))  // ### jwm ### 20141210_2241 added dither percent of total weight
			Else 
				<>wtDitherPC:=0  // ### jwm ### 20141210_2301
				If (<>vrWeightProduct=0)
					<>vrWeightErrPC:=0
				Else 
					<>vrWeightErrPC:=100
				End if 
			End if 
		End if 
		Case of 
			: ((<>vrWeightTare<(-<>wtDitherFactor-(<>vrWeightScale*<>wtPrecisionPC*0.01))) & (<>vrWeightTare#-77777))
				//: ((<>vrWeightTare<(-<>wtDitherFactor))&(<>vrWeightTare#-77777))
				//zzzCheck_bj 070920 
				<>pkScaleComment:="Negative Tare"
				_O_OBJECT SET COLOR:C271(<>pkScaleComment; -(White:K11:1+(256*Red:K11:4)))
				// : (<>vrWeightErrPC><>wtPrecisionPC)  // (<>vrWeightErrPC><>wtPrecisionPC)
			: (<>vrWeightErrPC>(<>wtPrecisionPC+<>wtDitherPC))  // ### jwm ### 20141210_2241 added percentage of dither to allowed deviation
				If (<>vrWeightScale><>wtDitherFactor)
					<>pkScaleComment:="Weight Mismatch"
					_O_OBJECT SET COLOR:C271(<>pkScaleComment; -(White:K11:1+(256*Red:K11:4)))
				End if 
				//SET COLOR($1->;-(Black+(256*Yellow)))
				//SET COLOR (bInfo;  (vForeground + (256 * vBackground)))
				
			Else 
				<>pkScaleComment:="OK"
				_O_OBJECT SET COLOR:C271(<>pkScaleComment; -(White:K11:1+(256*Green:K11:9)))
		End case 
		C_REAL:C285(<>scanItemPC; <>scanScaleItemWt; <>itemWt; <>itemDeltaWt)
		<>itemDeltaWt:=Round:C94(<>vrWeightScale-<>scanScaleItemWt; 2)
		<>scanItemPC:=Round:C94(<>itemDeltaWt/<>itemWt*100; 2)
		
		
		POST OUTSIDE CALL:C329(-1)
		//SET PROCESS VARIABLE($procNum;<>vrWeightScale;<>vrWeightScale
		//;<>pkScaleComment;<>pkScaleComment;pkScaleText;pkScaleText)
	Else 
		
		If (<>vbPKScaleRead=False:C215)  //jwm If no reading from scale
			//ALERT("No Reading From Scale")
		End if 
		
	End if 
	$cnt:=$cnt+1
Until ((<>closeScale=0) | (<>vbDoQuit))
