//%attributes = {"publishedWeb":true}
If (False:C215)
	TCMod_606_67_03_04_Trans
	//Method: SOAP_ItemPriceUpdate
End if 

TRACE:C157
C_TEXT:C284(srDomain)
C_LONGINT:C283(srPort)
srPort:=8080
srDomain:="67.50.14.233"
srItemMfgItemNum:=""
srItemMfgID:=""
srUserName:="name"
srPassword:="pass"
<>vSoapTrack:=2
jCenterWindow(460; 150; 1)  //;"Get Item";"Wind_CloseBox")
DIALOG:C40([Control:1]; "SoapUpdate")
CLOSE WINDOW:C154
If (OK=1)
	MESSAGE:C88("Processing...")
	KeyModifierCurrent
	
	$theSite:=srDomain
	//$getPriceUpdate:="http://"+$theSite+"/B2B_Update?UserName="+srUserName+"&password="+srPassword
	//B2BRequests ($getPriceUpdate;"B2B_Update";srUserName;srPassword;"0";srPort)
	ALERT:C41(vResponse+"\r"+"\r"+"Review Document: "+document)
End if 


//B2BRequests ("http://67.50.14.233/B2B_Update?UserName=name&password=pass";
//"B2B_Update";"name";"pass";"67.50.14.233")