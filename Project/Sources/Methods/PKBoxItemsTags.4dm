//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKBoxItemsTags
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description:
	// ### jwm ### 20141211_1122 define vrWeightTare and vrWeightProduct
	// ### jwm ### 20141211_1123 capture tare weight
	// ### jwm ### 20141211_1124 capture product weight
	// ### jwm ### 20141217_0009 weight percent limit needs to be a variable.
	// ### jwm ### 20150120_1257 added <>wtTarePC
End if 
//
//KeyModifierCurrent 
$err:=1
//TRACE
// ### jwm ### 20141211_1122 define vrWeightTare and vrWeightProduct
C_REAL:C285(<>vrWeightProduct; $deviationWt; <>vrWeightTare; <>vrWeightScale; vrWeightScale; vrWeightTare; vrWeightProduct)
//PKWtScaleCalc

vrWeightScale:=<>vrWeightScale  //scale wt
vrWeightTare:=<>vrWeightTare  // ### jwm ### 20141211_1123 capture tare weight
vrWeightProduct:=<>vrWeightProduct  // ### jwm ### 20141211_1124 capture product weight

// ### jwm ### 20150122_1701 DEBUG
If (Caps lock down:C547)
	C_TEXT:C284($message)
	$message:="vrWeightScale = "+String:C10(vrWeightScale)+"\r"
	$message:=$message+"vrWeightTare = "+String:C10(vrWeightTare)+"\r"
	$message:=$message+"vrWeightProduct = "+String:C10(vrWeightProduct)+"\r"
	ALERT:C41($message)
End if 

//
If ((iLoInteger1=0) | (vbBuildCarton=True:C214))  //ignor button not checked
	
	//If (<>vbPKScaleRead=True)//jwm if reading scale
	$err:=0
	//End if 
	
	//jwm comment out pkWtScaleRead can't be called by
	//more than one process at the same time
	//$cntLoop:=0
	//Repeat
	//$cntLoop:=$cntLoop+1
	//$err:=PKWtScaleRead
	//Until (($err=0) | ($cntLoop>=10))  //JWM CHANGED 5 TO 10
	<>vrWeightTare:=<>vrWeightScale-<>vrWeightProduct
	vrWeightTare:=<>vrWeightTare  // ### jwm ### 20141211_1123 capture tare weight
	
Else 
	$strWt:=Request:C163("Enter Weight"; String:C10(<>vrWeightProduct))
	If (OK=1)
		$err:=0
		vrWeightScale:=Num:C11($strWt)
		vrWeightTare:=vrWeightScale-<>vrWeightProduct  // ### jwm ### 20141211_1123 capture tare weight
		
		// ### jwm ### 20141217_0009 weight percent limit needs to be a variable
		// ### jwm ### 20150120_1257 added <>wtTarePC
		If ((vrWeightTare/vrWeightScale)>(<>wtTarePC*0.01))  // ### jwm ### 20141211_1017 tare weight over 40%
			<>pkScaleComment:="Tare Weight Over "+String:C10(<>wtTarePC)+"%"
			PKAlertWindow
			OBJECT SET ENABLED:C1123(b3; False:C215)
			$err:=1
		End if 
		
	End if 
End if 

If ($err=0)
	C_BOOLEAN:C305($doPass)
	$doPass:=allowAlerts_boo
	allowAlerts_boo:=False:C215  //keep from alert on every box pack.
	
	LT_FillArrayLoadItems(-5)
	
	
	allowAlerts_boo:=$doPass
	<>vrWeightTare:=0
	iLoReal3:=0
	iLoReal4:=0
	iLoReal5:=0
	<>vrWeightProduct:=0
Else 
	ALERT:C41("No Reading From Scale")
End if 
