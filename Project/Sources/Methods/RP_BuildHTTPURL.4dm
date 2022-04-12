//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-06T00:00:00, 11:53:30
// ----------------------------------------------------
// Method: RP_BuildHTTPURL
// Description
// Modified: 10/06/13
// 
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $path)
C_LONGINT:C283(HTTP_TimeOut)

TRACE:C157  // this is junky. Require this be completed in getting the SyncRelate variables

If (False:C215)  // users are in complete control base so they can match to the partner
	If (Count parameters:C259=1)
		HTTP_Path:=$1+"&userName="+vUsername+"&password="+vPassword
	Else 
		HTTP_Path:="RP_Receive?TableName=SyncRecord&userName="+vUsername+"&password="+vPassword
	End if 
End if 


If (HTTP_TimeOut=0)
	HTTP_TimeOut:=10
End if 
HTTP_URL:=HTTP_Protocol
C_TEXT:C284($portAdd)
Case of 
	: ((HTTP_Protocol="http") & (HTTP_Port=80))
		$portAdd:=""
	: ((HTTP_Protocol="https") & (HTTP_Port=443))
		$portAdd:=""
	Else 
		$portAdd:=":"+String:C10(HTTP_Port)
End case 
HTTP_URL:=HTTP_URL+"://"+HTTP_Host
HTTP_URL:=HTTP_URL+$portAdd
// HTTP_URL:=HTTP_URL+"/"+HTTP_Path