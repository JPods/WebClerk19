//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/27/06, 20:44:51
// ----------------------------------------------------
// Method: Auth_ParseReturn
// Description
// 
//
// Parameters
// ----------------------------------------------------
//
C_TEXT:C284($1)
XMLParseTags($1)
pDescript:=""
pCardApprv:="Declined"
pvProcessorTransID:="zzz"
//
QUERY:C277([TallyMaster:60]; [TallyMaster:60]Name:8="VerisignApproval")
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Purpose:3="CC")
If (Records in selection:C76([TallyMaster:60])=1)
	//execute script to harvest value
	ExecuteText(0; [TallyMaster:60]Build:6)
Else 
	$theText:=""
	C_LONGINT:C283($w)
	
	vsRspnText:=XMLReturnTagValue("message")
	pvProcessorTransID:=XMLReturnTagValue("PNRef")
	pvStatus:=XMLReturnTagValue("status")
	pvError:=XMLReturnTagValue("Result")
	pCardApprv:=XMLReturnTagValue("AuthCode")
	
	
	If (False:C215)
		$w:=XMLFindInArray("Message"; ->aXMLTag)
		If ($w>0)
			If (aXMLValue{$w}="Approved")
				pDescript:="Approved"
				$w:=XMLFindInArray("AuthCode"; ->aXMLTag)
				If ($w>0)
					pCardApprv:=aXMLValue{$w}
				End if 
				$w:=XMLFindInArray("PNRef"; ->aXMLTag)
				If ($w>0)
					pvProcessorTransID:=aXMLValue{$w}
				End if 
			End if 
		End if 
	End if 
End if 

