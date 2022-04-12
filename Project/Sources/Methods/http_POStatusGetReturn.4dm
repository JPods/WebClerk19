//%attributes = {"publishedWeb":true}

If (False:C215)
	//Method: http_POStatusGetReturn
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($header; $theMessage)
C_LONGINT:C283($1; $err)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0
vResponse:="Password or UserName not submitted."
C_LONGINT:C283($i; $k; $p; $pLines; $pLineEnd)
C_TEXT:C284($lineBreak)
$poNum:=WCapi_GetParameter("PONum"; "")
$soNum:=WCapi_GetParameter("SONum"; "")
$userName:=WCapi_GetParameter("UserName"; "")
$password:=WCapi_GetParameter("Password"; "")
$customerID:=WCapi_GetParameter("customerID"; "")
//
C_TEXT:C284($poNum; $userName; $password; $customerID)
//
$failedStatus:=True:C214
If (($userName#"") & ($password#""))  //|(viEndUserSecurityLevel-<>vlSecurityBump>1))
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName; *)
	QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$password)
	If ((Records in selection:C76([RemoteUser:57])=1) & ($customerID=[RemoteUser:57]customerID:10))
		QUERY:C277([Order:3]; [Order:3]customerPO:3=$poNum; *)
		QUERY:C277([Order:3];  & [Order:3]customerID:1=$customerID)
		If (Records in selection:C76([Order:3])=1)
			$failedStatus:=False:C215
			vResponse:=[Order:3]comment:33
			$status:=[Order:3]status:59
			$produceBy:=[Order:3]actionBy:55
		Else 
			vResponse:="No matching Order for customerID: "+$customerID+" and PO: "+$poNum
			$status:="Err CustID/PONum"
		End if 
	Else 
		vResponse:="No matching Remote User for Password: "+$password+" and UserName: "+$userName
		$status:="Err No User/Pass"
	End if 
Else 
	$status:="Err Miss User/Pass"
	vResponse:="Incomplete combination for UserName: "+$userName+" or Password: "+$password
End if 
$theMessage:="DirectReply&PONum="+$poNum+"&SONum="+$soNum+"+&OrderStatus="+$status+"&OrderComment="+vResponse+Storage:C1525.char.crlf+Storage:C1525.char.crlf
Http_SendWWWHd($1; "text/html"; Length:C16($theMessage))
$err:=TCP Send($1; $theMessage)
//