//%attributes = {"publishedWeb":true}
//If (False)
//	//Method: http_POStatusGet
//	//Date: 03/11/03
//	//Who: Bill
//	//Description: 
//End if 
//C_LONGINT($viProcess)
//$viProcess:=Current process
//MENU BAR(1;$viProcess;*)
//Process_InitLocal 
//C_POINTER($ptOrgFile)
//myOK:=0
//$ptOrgFile:=<>ptCurTable
//ptCurTable:=<>ptCurTable
////
//USE SET("<>curSelSet")
//CLEAR SET("<>curSelSet")
//myOK:=1
//<>prcControl:=0
//
//
//
//
//MESSAGES OFF
//C_TEXT(vText11;$temp;$testText;$orderStatus;$orderComment)
//C_TEXT($MIMEtype)
//C_LONGINT($s;$i;$k;$iArray;$kArray)
//C_LONGINT($err;$stream)
//
//vlBeenHere:=0//changed in item searching, used in Http_PostOrd
//vBeenHere:=0
////
//viEndUserSecurityLevel:=1
////
//viWebOrder:=1
////
//ON ERR CALL("jOECNoAction")
//C_LONGINT(viRemoteIP)
////vText11 is the request
////vText12 is the value of pages t
//allowAlerts_boo:=False//block all 
//$stream:=0
////
//
//viRemoteIP:=0
//C_LONGINT($i;$k)
//$k:=Records in selection([PO])
//If ($k>0)
//	//Process_ListActive 
//	C_Longint($w)
//	C_BOOLEAN($killWhenDone)
//	//  
//	C_LONGINT($stream)
//	C_TEXT($vendorIP;$vendorDomain)
//	READ WRITE([PO])
//	FIRST RECORD([PO])
//	For ($i;1;$k)
//		LOAD RECORD([PO])
//		If (False)//(Locked([PO]))
//			BEEP
//			BEEP
//			MESSAGE("PO "+String([PO]PONum)+" is locked.")
//		Else 
//			QUERY([Vendor];[Vendor]VendorID=[PO]VendorID)
//			Case of 
//				: (Records in selection([Vendor])#1)
//					[PO]StatusVendor:="No Vendor"
//				: ([PO]Post2SODomain="")
//					[PO]StatusVendor:="Missing site"
//				: ([PO]Post2SOPort<80)
//					[PO]StatusVendor:="Port set below 80"
//				: ([Vendor]UserName="")
//					[PO]StatusVendor:="Missing UserName"
//				: ([Vendor]Password="")
//					[PO]StatusVendor:="Missing Password"
//				: ([Vendor]customerIDAtVend="")
//					[PO]StatusVendor:="Missing customerID at Vendor"
//				Else 
//					TRACE
//					$vendorDomain:=[PO]Post2SODomain
//					$vendorDomain:=Replace string($vendorDomain;"http://";"")
//					$w:=Position("/";$vendorDomain)
//					If ($w>0)
//						$vendorDomain:=Substring($vendorDomain;1;$w-1)
//					End if 
//					//$vendorDomain
//					$vRequest:="https://"+$vendorDomain+"/Status_POAsk&PONum="+String([PO]PONum)+"&SONum="+[PO]VendorInvoice+"&customerID="+[Vendor]customerIDAtVend+"&UserName="+[Vendor]UserName+"&Password="+[Vendor]Password
//					
//					//          
//					C_TEXT($1;$doc;$crlf;$machine;$m;$temp;$theText)
//					C_LONGINT($stream;$s;$err)
//					ON ERR CALL("jOECNoAction")
//					ARRAY TEXT(aText1;0)
//					//
//					MESSAGES OFF
//					
//					NTK_SetURL ($vRequest)//this is a good procedure for parsing a complete URL.  Set each variable here.
//					
//					//HTTP_TimeOut:=10//seconds
//					//HTTP_Protocol:="https"//process as SSL
//					//HTTP_Path:=<>tcCCVerURL//Server command
//					//HTTP_Host:=<>tcCCVerHost//Server manchine
//					//HTTP_Port:=<>tcCCVerPort//the Port
//					
//					C_BLOB($incomingBlob)
//					$error:=WC_Request ("GET";->$incomingBlob)
//					
//					vText11:=BLOB to text($incomingBlob;Text without length)
//					
//					If (vText11#"")
//						TRACE
//						If (vText11#"")
//							$poNum:=WCapi_GetParameter(->vText11;"PONum";"")
//							$soNum:=WCapi_GetParameter(->vText11;"SONum";"")
//							$orderStatus:=WCapi_GetParameter(->vText11;"OrderStatus";"")
//							$orderComment:=WCapi_GetParameter(->vText11;"OrderComment";"")
//						Else 
//							$userName:="NoUD_"+[PO]StatusVendor
//							$orderComment:=[PO]CommentVendor
//						End if 
//						[PO]StatusVendor:=$orderStatus
//						[PO]CommentVendor:=$orderComment+"\r"+"VendorStatus"+[PO]CommentVendor
//						SAVE RECORD([PO])
//					End if 
//					
//			End case 
//		End if 
//		NEXT RECORD([PO])
//	End for 
//End if 
//
//REDRAW WINDOW
//
//
//
//
//