//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: http_POStatusGet
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(1; $viProcess; *)
Process_InitLocal
C_POINTER:C301($ptOrgFile)
myOK:=0
$ptOrgFile:=<>ptCurTable
ptCurTable:=<>ptCurTable
//
USE SET:C118("<>curSelSet")
CLEAR SET:C117("<>curSelSet")
myOK:=1
<>prcControl:=0




MESSAGES OFF:C175
C_BLOB:C604(HTTP_IncomingBlob)
C_TEXT:C284(vText11; $testText)
C_TEXT:C284($MIMEtype)
C_LONGINT:C283($streamStatus; $i; $k; $iArray; $kArray)
C_LONGINT:C283($streamStatus; $stream)

vlBeenHere:=0  //changed in item searching, used in Http_PostOrd
vBeenHere:=0
//
viEndUserSecurityLevel:=1
//
viWebOrder:=1
//

C_LONGINT:C283(viRemoteIP)
//vText11 is the request
//vText12 is the value of pages t
allowAlerts_boo:=False:C215  //block all 
$stream:=0
//
viRemoteIP:=0
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([PO:39])
If ($k>0)
	//Prs_ListActive 
	C_LONGINT:C283($w)
	C_BOOLEAN:C305($killWhenDone)
	//  
	C_LONGINT:C283($stream)
	C_TEXT:C284($vendorIP; $vendorDomain)
	READ WRITE:C146([PO:39])
	FIRST RECORD:C50([PO:39])
	For ($i; 1; $k)
		LOAD RECORD:C52([PO:39])
		If (False:C215)  //(Locked([PO]))
			BEEP:C151
			BEEP:C151
			MESSAGE:C88("PO "+String:C10([PO:39]poNum:5)+" is locked.")
		Else 
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
			Case of 
				: (Records in selection:C76([Vendor:38])#1)
					[PO:39]statusVendor:70:="No Vendor"
				: ([Vendor:38]domain:68="")
					[PO:39]statusVendor:70:="Missing site"
				: ([Vendor:38]userName:78="")
					[PO:39]statusVendor:70:="Missing UserName"
				: ([Vendor:38]password:79="")
					[PO:39]statusVendor:70:="Missing Password"
				: ([Vendor:38]customerIDAtVend:67="")
					[PO:39]statusVendor:70:="Missing customerID at Vendor"
				Else 
					TRACE:C157
					
					
					//$vendorDomain:=[PO]lng+"/Status_POAsk?PONum="+String([PO]uniqueId)+"&SONum="+[PO]vendorInvoice+"&customerID="+[Vendor]customerIDAtVend+"&UserName="+[Vendor]UserName+"&Password="+[Vendor]Password
					
					NTK_SetURL($vendorDomain)  //this is a good procedure for parsing a complete URL.  Set each variable here.
					//HTTP_TimeOut:=10//seconds
					//HTTP_Protocol:="https"//process as SSL
					//HTTP_Path:=<>tcCCVerURL//Server command
					//HTTP_Host:=<>tcCCVerHost//Server manchine
					//HTTP_Port:=<>tcCCVerPort//the Port
					C_BLOB:C604(HTTP_IncomingBlob)
					$error:=WC_Request("GET")
					//          
					C_TEXT:C284($1; $doc; $crlf; $machine; $m; $temp; $theText)
					C_LONGINT:C283($stream; $streamStatus; $streamStatus)
					
					ARRAY TEXT:C222(aText1; 0)
					//
					MESSAGES OFF:C175
					// open stream with the HTTP server
					vText11:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
					
					SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
					//
					TRACE:C157
					If (vText11#"")
						$poNum:=WCapi_GetParameter("PONum"; "")
						$soNum:=WCapi_GetParameter("SONum"; "")
						$userName:=WCapi_GetParameter("OrderStatus"; "")
						$password:=WCapi_GetParameter("OrderComment"; "")
					Else 
						$userName:="NoUD_"+[PO:39]statusVendor:70
						$password:=[PO:39]commentVendor:71
					End if 
					[PO:39]statusVendor:70:=$userName
					[PO:39]commentVendor:71:=$password
					SAVE RECORD:C53([PO:39])
			End case 
		End if 
		NEXT RECORD:C51([PO:39])
	End for 
End if 

REDRAW WINDOW:C456