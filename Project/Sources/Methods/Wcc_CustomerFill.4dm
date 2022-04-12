//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-02-07T00:00:00, 11:21:54
// ----------------------------------------------------
// Method: Wcc_CustomerFill
// Description
// Modified: 02/07/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($customerID; $0; $billToID; $shipToID; $textOfNothing)
C_LONGINT:C283($1)
C_POINTER:C301($2; $ptToNothing)

// Modified by: Bill James (2015-03-20T00:00:00 no parameters are required for this procedure)
// fix the WCapi_GetParameter to not need the first parameters

$textOfNothing:=""
$ptToNothing:=(->$textOfNothing)


$customerID:=WCapi_GetParameter("customerID"; "")
$billToID:=WCapi_GetParameter("BillToID"; "")
$shipToID:=WCapi_GetParameter("ShipToID"; "")
// $customerID:=WCapi_GetParameter($ptToNothing;"customerID";"")
C_LONGINT:C283($documentID)
$documentID:=Num:C11(returnValue)
If ($customerID="")
	vResponse:="No valid document ID: "+returnValue
Else 
	// Alert(variable4)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=$customerID)
	Case of 
		: (returnTable="Order")
			// ### bj ### 20200309_2214  Change these to a json
			QUERY:C277([Order:3]; [Order:3]idNum:2=$documentID)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Order:3]customerID:1)
			//  CHOPPED FillContactArrays(Records in selection([Contact]))
			LoadCustOrder
			SAVE RECORD:C53([Order:3])
		: (returnTable="Invoice")
			// ### bj ### 20200309_2214  Change these to a json
			QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=$documentID)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Invoice:26]customerID:3)
			//  CHOPPED FillContactArrays(Records in selection([Contact]))
			IvcLoadCust
			SAVE RECORD:C53([Invoice:26])
		: (returnTable="Proposal")
			// ### bj ### 20200309_2214  Change these to a json
			QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=$documentID)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Proposal:42]customerID:1)
			//  CHOPPED FillContactArrays(Records in selection([Contact]))
			ProposalLoadCus
			SAVE RECORD:C53([Proposal:42])
		Else 
			vResponse:="No valid ReturnTable."
	End case 
	
	$pageDo:=WC_DoPage("Error.html"; "")
	$jitPageReturn:=WCapi_GetParameter("ReturnPage"; "")
	If ($jitPageReturn="")
		$jitPageReturn:=WCapi_GetParameter("PageReturn"; "")
		If ($jitPageReturn="")
			$jitPageReturn:=WCapi_GetParameter("jitPageReturn"; "")
		End if 
	End if 
	If ($jitPageReturn="")
		vResponse:="No valid ReturnTable."
	End if 
End if 
$0:=WC_DoPage($jitPageReturn; $jitPageOne)
