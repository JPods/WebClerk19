//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_ReturnOS
	//Date: 07/01/02
	//Who: Bill
	//Description: Return the OS to the Http server
	
	// ### jwm ### 20160405_1027  find cookie OperatingSystem if found set to cookie value
End if 

If (False:C215)  //for testing
	ARRAY TEXT:C222(<>aUserAgent; 0)
	ARRAY TEXT:C222(<>aUserAgentRoot; 0)
	C_TEXT:C284($uaName; $uaAccept; $uaRoot)
	If (HFS_Exists(<>WebFolder+"jitUserAgent.txt")=1)
		myDoc:=Open document:C264(<>WebFolder+"jitUserAgent.txt")
		If (OK=1)
			C_TEXT:C284($theSite; $thePage)
			Repeat 
				$uaRoot:=""
				$uaName:=""
				RECEIVE PACKET:C104(myDoc; $uaName; "\t")
				RECEIVE PACKET:C104(myDoc; $uaRoot; "\r")
				$uaName:=TxtStripLineFeed($uaName)
				$uaRoot:=TxtStripLineFeed($uaRoot)
				If (($uaRoot#"") & ($uaName#""))
					INSERT IN ARRAY:C227(<>aUserAgent; 1; 1)
					INSERT IN ARRAY:C227(<>aUserAgentRoot; 1; 1)
					<>aUserAgent{1}:=$uaName
					<>aUserAgentRoot{1}:=$uaRoot
				End if 
			Until (OK=0)
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
	
	
End if 
C_TEXT:C284($0; $testPath)
$theUserDevice:=""
// ### jwm ### 20160405_1027  find cookie OperatingSystem if found set to cookie value
$p:=Find in array:C230(aCookieName; "OperatingSystem")
If ($p>0)
	$theUserDevice:=aCookieValue{$p}
Else 
	$find:=Find in array:C230(aHeaderNameIn; "User-Agent@")
	If ($find>0)
		$testDevice:=aHeaderValueIn{$find}
		$endDeviceCheck:=False:C215
		C_LONGINT:C283($cntRay; $incRay; $foundRay)
		$cntRay:=Size of array:C274(<>aUserAgent)
		$incRay:=0
		$foundRay:=0
		If ($cntRay>0)
			Repeat 
				$incRay:=$incRay+1
				Case of 
					: ($cntRay<$incRay)
						$endDeviceCheck:=True:C214
					: (Position:C15(<>aUserAgent{$incRay}; $testDevice)>0)
						$foundRay:=$incRay
						$endDeviceCheck:=True:C214
						//$theUserDevice:=<>aUserAgentRoot{$incRay}
						$theUserDevice:=<>aUserAgent{$incRay}
				End case 
			Until ($endDeviceCheck)
		End if 
	End if 
End if 
$0:=$theUserDevice