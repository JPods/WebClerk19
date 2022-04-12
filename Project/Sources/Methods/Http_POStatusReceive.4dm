//%attributes = {"publishedWeb":true}
//Method: http_POStatusSend
C_TEXT:C284($header; $theMessage)
C_LONGINT:C283($1; $err)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0
vResponse:="Password or UserName not submitted."
C_LONGINT:C283($i; $k; $p; $pLines; $pLineEnd)
C_TEXT:C284($lineBreak)

C_TEXT:C284($poNum; $userName; $password; $vendorStatus; $vendorComment)
$poNum:=WCapi_GetParameter("PONum"; "")
$userName:=WCapi_GetParameter("UserName"; "")
$password:=WCapi_GetParameter("Password"; "")
$vendorStatus:=WCapi_GetParameter("OrderStatus"; "")
$vendorComment:=WCapi_GetParameter("OrderComment"; "")
//
C_TEXT:C284($poNum; $userName; $password; $customerID)
//
$failedStatus:=True:C214
If (($userName#"") & ($password#""))
	QUERY:C277([PO:39]; [PO:39]poNum:5=Num:C11($poNum))
	If (Records in selection:C76([PO:39])=1)
		QUERY:C277([Vendor:38]; [Vendor:38]vendorid:1=[PO:39]vendorid:1)
	Else 
		UNLOAD RECORD:C212([Vendor:38])
	End if 
	//If (<>viDoHttpLog>10)
	//http_SendLog ($1;"/POStatus/?userName="+$userName+"&password="
	//+$password)
	//End if 
	If ((Records in selection:C76([Vendor:38])=1) & ($userName=[Vendor:38]userName:78) & ([Vendor:38]password:79=$password))
		[PO:39]statusVendor:70:=$vendorStatus
		[PO:39]commentVendor:71:=$vendorComment
		SAVE RECORD:C53([PO:39])
		UNLOAD RECORD:C212([PO:39])
	End if 
End if 
Http_ReduceSelection
REDUCE SELECTION:C351([PO:39]; 0)
