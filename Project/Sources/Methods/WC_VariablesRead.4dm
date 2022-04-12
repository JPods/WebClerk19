//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-17T00:00:00, 18:40:49
// ----------------------------------------------------
// Method: WC_VariablesRead
// Description
// Modified: 09/17/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($doPageVariables; jitVariable1; jitVariable2; jitVariable3; jitVariable4; jitVariable5; jitVariable6; jitVariable7; jitVariable8; jitVariable9; jitVariable10; jitVariable11; jitVariable12)
C_TEXT:C284(Variable1; Variable2; Variable3; Variable4; Variable5; Variable6; Variable7; Variable8; Variable9; Variable10; Variable11; Variable12)
// ### bj ### 20200314_0029
C_TEXT:C284(vtLocked)
vtLocked:=""

jsonPage:=WCapi_GetParameter("jsonPage"; "")

// removed the need to have the page metatag 
If (Find in array:C230(aParameterName; "customerID@")>0)  // ### Bill ### 20171025 added so customer can register serialized items to other customers
	customerID:=WCapi_GetParameter("customerID"; "")
	customerID1:=WCapi_GetParameter("customerID1"; "")
	customerID2:=WCapi_GetParameter("customerID2"; "")
	customerID3:=WCapi_GetParameter("customerID3"; "")
	customerID4:=WCapi_GetParameter("customerID4"; "")
	customerIDRep:=WCapi_GetParameter("customerIDRep"; "")
	customerIDVendor:=WCapi_GetParameter("customerIDVendor"; "")
	customerIDRetailer:=WCapi_GetParameter("customerIDRetailer"; "")
	customerIDEndUser:=WCapi_GetParameter("customerIDEndUser"; "")
End if 

If (Find in array:C230(aParameterName; "vUUIDKey@")>0)
	vUUIDKeywo:=WCapi_GetParameter("vUUIDKeywo"; "")  // workOrders
	vUUIDKeyor:=WCapi_GetParameter("vUUIDKeyor"; "")  // Orders
	vUUIDKeycu:=WCapi_GetParameter("vUUIDKeycu"; "")  // Customer
	vUUIDKeyco:=WCapi_GetParameter("vUUIDKeyco"; "")  // Contact
	vUUIDKeyin:=WCapi_GetParameter("vUUIDKeyin"; "")  // invoice
	vUUIDKeypo:=WCapi_GetParameter("vUUIDKeypo"; "")  // PO
	vUUIDKeypr:=WCapi_GetParameter("vUUIDKeypr"; "")  // Project
	vUUIDKeypu:=WCapi_GetParameter("vUUIDKeypu"; "")  // Purposal
End if 

If (Find in array:C230(aParameterName; "contactID@")>0)  // ### Bill ### 20171025 added so contact can register serialized items to other contacts
	contactID:=WCapi_GetParameter("contactID"; "")
	contactID1:=WCapi_GetParameter("contactID1"; "")
	contactID2:=WCapi_GetParameter("contactID2"; "")
	contactID3:=WCapi_GetParameter("contactID3"; "")
	contactID4:=WCapi_GetParameter("contactID4"; "")
	contactIDRep:=WCapi_GetParameter("contactIDRep"; "")
	contactIDVendor:=WCapi_GetParameter("contactIDVendor"; "")
	contactIDRetailer:=WCapi_GetParameter("contactIDRetailer"; "")
	contactIDEndUser:=WCapi_GetParameter("contactIDEndUser"; "")
End if 

If (Find in array:C230(aParameterName; "jitVariable@")>0)  // ### AZM ### 20170927_1429
	jitVariable1:=WCapi_GetParameter("jitVariable1"; "")
	jitVariable2:=WCapi_GetParameter("jitVariable2"; "")
	jitVariable3:=WCapi_GetParameter("jitVariable3"; "")
	jitVariable4:=WCapi_GetParameter("jitVariable4"; "")
	jitVariable5:=WCapi_GetParameter("jitVariable5"; "")
	jitVariable6:=WCapi_GetParameter("jitVariable6"; "")
	jitVariable7:=WCapi_GetParameter("jitVariable7"; "")
	jitVariable8:=WCapi_GetParameter("jitVariable8"; "")
	jitVariable9:=WCapi_GetParameter("jitVariable9"; "")
	jitVariable10:=WCapi_GetParameter("jitVariable10"; "")
	jitVariable11:=WCapi_GetParameter("jitVariable11"; "")
	jitVariable12:=WCapi_GetParameter("jitVariable12"; "")
End if 

If (Find in array:C230(aParameterName; "variable@")>0)  // ### AZM ### 20170927_1429
	variable1:=WCapi_GetParameter("variable1"; "")
	variable2:=WCapi_GetParameter("variable2"; "")
	variable3:=WCapi_GetParameter("variable3"; "")
	variable4:=WCapi_GetParameter("variable4"; "")
	variable5:=WCapi_GetParameter("variable5"; "")
	variable6:=WCapi_GetParameter("variable6"; "")
	variable7:=WCapi_GetParameter("variable7"; "")
	variable8:=WCapi_GetParameter("variable8"; "")
	variable8:=WCapi_GetParameter("variable9"; "")
	variable10:=WCapi_GetParameter("variable10"; "")
	variable11:=WCapi_GetParameter("variable11"; "")
	variable12:=WCapi_GetParameter("variable12"; "")
	variable13:=WCapi_GetParameter("variable13"; "")
	variable14:=WCapi_GetParameter("variable14"; "")
	variable15:=WCapi_GetParameter("variable15"; "")
	variable16:=WCapi_GetParameter("variable16"; "")
	variable17:=WCapi_GetParameter("variable17"; "")
	variable18:=WCapi_GetParameter("variable18"; "")
	variable19:=WCapi_GetParameter("variable19"; "")
	variable20:=WCapi_GetParameter("variable20"; "")
End if 