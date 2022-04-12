//%attributes = {"publishedWeb":true}
//SOAP_ItemGet

ON ERR CALL:C155("jOECNoAction")
// zzzqqq URL_Cleanup zzzqqq //  $urladdress:=URL_Cleanup ($urladdress)
//  what was this here for ???

$theURL:=$theURL+"/item_Copy?nc_itemNum="+srItemMfgItemNum+"&nc_Publisher="+srItemMfgID+"&UserName="+srUserName+"&Password="+srPassword+"&"  //+Storage.char.crlf+Storage.char.crlf
ARRAY TEXT:C222(aText1; 0)
//
MESSAGES OFF:C175
NTK_SetURL($vendorDomain)  //this is a good procedure for parsing a complete URL.  Set each variable here.
//HTTP_TimeOut:=10//seconds
//HTTP_Protocol:="https"//process as SSL
//HTTP_Path:=<>tcCCVerURL//Server command
//HTTP_Host:=<>tcCCVerHost//Server manchine
//HTTP_Port:=<>tcCCVerPort//the Port
C_LONGINT:C283($error)
$error:=WC_Request("POST")

$theText:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)

SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
//
If ($theText#"")
	TRACE:C157
	XMLParseTags($theText)
	
	Case of 
		: (<>vSoapTrack=1)
			SET TEXT TO PASTEBOARD:C523($theText)
		: (<>vSoapTrack=2)
			SET TEXT TO PASTEBOARD:C523($theText)
			Repeat 
				XMLEditor
				C_LONGINT:C283($found)
				$found:=Prs_CheckRunnin("XML Editor")
				If ($found<1)
					DELAY PROCESS:C323(Current process:C322; 30)
				End if 
			Until ($found>0)
			POST OUTSIDE CALL:C329(<>aPrsNum{$found})
		: (<>vSoapTrack=1)
			
			
		: (<>vSoapTrack=1)
			
			
	End case 
	
	TRACE:C157
	//
	C_POINTER:C301($ptField)
	$w:=Find in array:C230(aXMLTag; "Error")
	If ($w>0)
		If (aXMLValue{$w}="Valid Item")
			$w:=Find in array:C230(aXMLTag; "ItemNum")
			If ($w>0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aXMLValue{$w})  //aXMLValue{$w})
				If (Records in selection:C76([Item:4])=0)
					CREATE RECORD:C68([Item:4])
					[Item:4]itemNum:1:=aXMLValue{$w}
				End if 
				srItemNum:=aXMLValue{$w}
				iLoText1:="Item Received"
				$k:=Get last field number:C255(->[Item:4])
				For ($i; 1; $k)
					$ptField:=Field:C253(4; $i)
					$w:=Find in array:C230(aXMLTag; Field name:C257($ptField))
					If ($w>0)
						If (aXMLTag{$w}="ItemNum")
							[Item:4]itemNum:1:=aXMLValue{$w}  //+String(Time)
						Else 
							$w:=Find in array:C230(aXMLTag; Field name:C257($ptField))
							If ($w>0)
								PackMakeTyped($ptField; aXMLValue{$w})
							End if 
						End if 
					End if 
				End for 
				SAVE RECORD:C53([Item:4])
			End if 
		End if 
	End if 
End if 
