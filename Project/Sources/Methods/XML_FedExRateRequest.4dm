//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-11-28T00:00:00, 15:25:47
// ----------------------------------------------------
// Method: XML_FedExRateRequest
// Description
// Modified: 11/28/16
// 
// 
//
// Parameters
// ----------------------------------------------------

QUERY:C277([SyncRelation:103]; [SyncRelation:103]Name:8="FedEx Rate Request"; *)
QUERY:C277([SyncRelation:103]; [SyncRelation:103]Active:17=True:C214)
If (Records in selection:C76([SyncRelation:103])=1)
	
	WebClientTest
	
	
	
	
	//  based on value of:  XML_Response
	
	C_TEXT:C284($Struct_Ref)
	
	$Struct_Ref:=DOM Parse XML variable:C720(XML_Response)
	
	
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523(XML_Response)
	End if 
	
	C_TEXT:C284($optionTag; $optionValue; $childTag; $childValue; $childBreak)
	C_TEXT:C284($foundTag; $foundChild)
	ARRAY TEXT:C222($aParameters; 0)
	ARRAY TEXT:C222($aValues; 0)
	
	$optionTag:="SOAP-ENV:Envelope/SOAP-ENV:Body/RateReply"
	$optionValue:=""
	
	
	$foundTag:=DOM Find XML element:C864($Struct_Ref; $optionTag)
	
	$fullPathtoChild:="SOAP-ENV:Envelope/SOAP-ENV:Body/RateReply/RateReplyDetails"
	
	If (OK=1)
		DOM GET XML ELEMENT NAME:C730($foundTag; $optionValue)
		//ALERT("The name of the element is: \""+value+"\"")
		//Count the number of Service Summaries in the Transit Response
		
		C_LONGINT:C283($countChild)
		$foundChild:=DOM Find XML element:C864($foundTag; "RateReply/RateReplyDetails")
		$countChild:=DOM Count XML elements:C726($foundTag; "RateReplyDetails")  // just the name of the child
		
		// $countChild:=DOM Count XML elements($foundTag;$fullPathtoChild)  fail
		// $countChild:=DOM Count XML elements($foundChild;"RateReplyDetails")  fail
		
		C_TEXT:C284($serviceType; $serviceAmount)
		
		
		
		For ($incChild; 1; $countChild)
			$dataTag:="RateReplyDetails/ServiceType"
			$foundData:=DOM Find XML element:C864($foundChild; $dataTag)
			DOM GET XML ELEMENT VALUE:C731($foundData; $serviceType)
			
			If (($serviceType="Standard_Overnight") | ($serviceType="FedEx_2_Day") | ($serviceType="FedEx_Ground"))
				$dataTag:="RateReplyDetails/RatedShipmentDetails/ShipmentRateDetail/TotalNetChargeWithDutiesAndTaxes/Amount"
				$foundData:=DOM Find XML element:C864($foundChild; $dataTag)
				DOM GET XML ELEMENT VALUE:C731($foundData; $serviceAmount)
				C_REAL:C285($handleFee; $shipfee)
				$shipfee:=Num:C11($serviceAmount)
				$handleFee:=Round:C94(($shipfee*0.1); 2)
				$shipfee:=Round:C94($shipfee+$handleFee-0.49; 0)
				$serviceAmount:="$"+String:C10($shipfee; "###,###,###.00")
				APPEND TO ARRAY:C911($aValues; $serviceAmount)
				C_TEXT:C284(vtNextDay; vtNextDayValue; vt2Day; vt2DayValue; vtGround; vtGroundValue)
				Case of 
					: ($serviceType="Standard_Overnight")
						APPEND TO ARRAY:C911($aParameters; "Next Day: "+$serviceAmount)
						vtNextDay:="Next Day: "+$serviceAmount
						vtNextDayValue:=$serviceAmount
					: ($serviceType="FedEx_2_Day")
						APPEND TO ARRAY:C911($aParameters; "Second Day: "+$serviceAmount)
						vt2Day:="Second Day: "+$serviceAmount
						vt2DayValue:=$serviceAmount
					: ($serviceType="FedEx_Ground")
						APPEND TO ARRAY:C911($aParameters; "Ground: "+$serviceAmount)
						vtGround:="Ground: "+$serviceAmount
						vtGroundValue:=$serviceAmount
				End case 
				
			End if 
			
			$foundChild:=DOM Get next sibling XML element:C724($foundChild)
			
		End for 
		
	End if 
	If ([Order:3]shipFreightCost:38=0)
		[Order:3]shipFreightCost:38:=Num:C11(vtGroundValue)
		
	End if 
	
Else 
	
	
End if 
// 
// Modified by: Bill James (2017-01-20T00:00:00)
REDUCE SELECTION:C351([SyncRelation:103]; 0)
