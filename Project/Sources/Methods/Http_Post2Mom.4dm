//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2; <>hcHomeAddress)
C_LONGINT:C283($3; $4; <>lPort_mom)  //;<>vEoF
C_LONGINT:C283(<>viUseMom; $sentBytes)
C_BLOB:C604($myBlob)
//
C_LONGINT:C283($stream)
If (<>viUseMom=1)
	$myDoc:=Open document:C264($1)
	If (OK=1)
		CLOSE DOCUMENT:C267($myDoc)
		DOCUMENT TO BLOB:C525(document; $myBlob)
		BASE64 ENCODE:C895($myBlob)
		TRACE:C157
		<>vTicDelay:=30
		C_LONGINT:C283($stream)
		$stream:=TCP Open(<>hcHomeAddress; <>lPort_mom)  // open FTP control stream on port 21
		If ($stream#0)
			//
			C_LONGINT:C283($streamStatus)
			$debut:=Current time:C178  // wait connection for 30s
			Repeat 
				$streamStatus:=TCP Get State($stream)
				IDLE:C311
			Until (($streamStatus=8) | ($streamStatus=0) | (Current time:C178>($debut+?00:00:30?)))
			//
			If ($streamStatus=8)
				$forceStop:=False:C215
				Repeat 
					$sentBytes:=TCP Send($stream; "_jitDoc_"+Storage:C1525.char.crlf)
					KeyModifierCurrent
					If (OptKey=1)
						$forceStop:=True:C214
						TRACE:C157
					End if 
				Until ($forceStop)
				$sentBytes:=TCP Send Blob($stream; $myBlob)
				$sentBytes:=TCP Send($stream; "_jitDocEnd_"+Storage:C1525.char.crlf)
			End if 
		End if 
		TCP Close($stream)
	End if 
End if 