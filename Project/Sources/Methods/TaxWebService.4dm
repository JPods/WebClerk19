//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TaxWebService
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//
If (<>vSoapTrack=3)
	CREATE RECORD:C68([EventLog:75])
	[EventLog:75]dtEvent:1:=DateTime_DTTo
	
	[EventLog:75]groupid:3:="WebTaxTest"  // -4
End if 
C_TEXT:C284(pvTaxRate; pvTaxStatus; pvrTaxCost; pvTax; pvrTaxCostRate)
QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SOAP@"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="SOAP_SalesTax")
If (Records in selection:C76([TallyMaster:60])=1)
	
	Case of 
		: ([Customer:2]taxExemptid:56="DETERMINE")
			vsTaxExempt:="DETERMINE"
		: ([Customer:2]taxExemptid:56="Internal")
			vsTaxExempt:="EXEMPT"
		: ([Customer:2]taxExemptid:56#"")
			vsTaxExempt:="EXEMPT"
		Else 
			vsTaxExempt:="DETERMINE"
	End case 
	
	vText4:=[TallyMaster:60]script:9
	$thePath:=[TallyMaster:60]path:28
	If ([TallyMaster:60]build:6#"")
		ExecuteText(0; [TallyMaster:60]build:6)
	End if 
	theText:=[TallyMaster:60]after:7
	If (<>vSoapTrack=3)
		EventLogsMessage(UtilFillMarkerLine("Path")+$thePath+UtilFillMarkerLine("Start Input")+vText4+UtilFillMarkerLine("End Procedure")+theText)
	End if 
	UNLOAD RECORD:C212([TallyMaster:60])
	C_LONGINT:C283($err)
	vText4:=TagsToText(vText4)
	If (<>vSoapTrack=3)
		EventLogsMessage(UtilFillMarkerLine("Converted Input")+vText4)
	End if 
	SoapProcess($thePath; vText4)
	$Linecomment:="no connection"
	If (theText#"")
		ExecuteText(0; theText)
		If (<>vSoapTrack=3)
			EventLogsMessage(UtilFillMarkerLine("After End Script")+vText4)
		End if 
	Else 
		If (Size of array:C274(aXMLTag)>0)
			$w:=Find in array:C230(aXMLTag; "taxRate")
			If ($w>0)
				pvTaxRate:=aXMLValue{$w}
			End if 
			$w:=Find in array:C230(aXMLTag; "taxAmount")
			If ($w>0)
				pvTax:=aXMLValue{$w}
			End if 
			$w:=Find in array:C230(aXMLTag; "errorMessage")
			If ($w>0)
				pvLnProfile1:=aXMLValue{$w}
			End if 
			$w:=Find in array:C230(aXMLTag; "geocode")
			If ($w>0)
				pvLnProfile2:=aXMLValue{$w}
			End if 
		End if 
	End if 
	XMLArrayManagement(0)
End if 
C_TEXT:C284($Linecomment)
UNLOAD RECORD:C212([TallyMaster:60])
vText4:=""
theText:=""
If (<>vSoapTrack=3)
	If ([EventLog:75]idNum:5#0)
		SAVE RECORD:C53([EventLog:75])
	End if 
	ProcessTableOpen(Table:C252(->[EventLog:75]))
End if 