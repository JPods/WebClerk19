// (FM) [Dialog];"WebClerkMonitor"

C_TEXT:C284($numberFormat)
$formEvent:=Form event code:C388
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		If (Position:C15(","; String:C10(1/2))>0)
			$numberFormat:="###.###.###.###.###.###"
		Else 
			$numberFormat:="###,###,###,###,###,###"
		End if 
		
		OBJECT SET FORMAT:C236(HTTPD_BytesSend; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_BytesReceived; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_AttemptedConn; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_AcceptedConn; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_FailedConn; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_ClosedConn; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_ActiveConn; $numberFormat)
		OBJECT SET FORMAT:C236(HTTPD_MaxConn; $numberFormat)
		
		C_TEXT:C284(vDebugDisplay; vDebugMessage)
		vDebugMessage:=""
		vDebugDisplay:=""
		//SET TIMER(2*60)
		SET TIMER:C645(2*60)
		WC_UpdateMonitor
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(aREQHANDLERSTATE)
		$i:=0
		If ($k>0)
			While ($i<$k)
				$i:=$i+1
				If (aREQHANDLERSTATE{$i}="Pau@")
					OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; Yellow:K11:2)
					$i:=$k
				End if 
			End while 
		End if 
		
	: (Form event code:C388=On Timer:K2:25)
		WC_UpdateMonitor
		
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		
		C_TEXT:C284(vDebugText)
		vDebugDisplay:=vDebugMessage+vDebugDisplay
		vDebugMessage:=""
		If (<>vbWCstop)
			CANCEL:C270
		End if 
End case 

