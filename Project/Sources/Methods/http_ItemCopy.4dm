//%attributes = {"publishedWeb":true}
//http_ItemCopy
C_LONGINT:C283($1; $c; vbSaleLevel; $k; $i; $offSet)
C_BOOLEAN:C305($doThis)
C_TEXT:C284(vResponse; $fldValue; $recordData)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=False:C215
vResponse:=""
$mfgItemNum:=WCapi_GetParameter("nc_itemNum"; "")
$mfgID:=WCapi_GetParameter("nc_Publisher"; "")
$userName:=WCapi_GetParameter("userName"; "")
$password:=WCapi_GetParameter("password"; "")
//
$recordData:="<MfgItemNum>"+$mfgItemNum+"</MfgItemNum>"
$recordData:=$recordData+"\r"+"<MfgID>"+$mfgID+"</MfgID>"
$recordData:=$recordData+"\r"+"<userName>"+$userName+"</userName>"
$recordData:=$recordData+"\r"+"<password>"+$password+"</password>"

If (($userName="") | ($password=""))  //(Records in selection([RemoteUser])=0)
	$recordData:=$recordData+"\r"+"<Error>Error:  UserName or Password missing</Error>"
Else 
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName; *)
	QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$password)
	If (Records in selection:C76([RemoteUser:57])#1)
		$recordData:=$recordData+"\r"+"<Error>Error:  UserName or Password missing</Error>"
	Else 
		QUERY:C277([Item:4]; [Item:4]mfrID:53=$mfgID; *)
		QUERY:C277([Item:4];  & [Item:4]mfrItemNum:39=$mfgItemNum)
		If (Records in selection:C76([Item:4])#1)
			$recordData:=$recordData+"\r"+"<Error>Error:  UserName or Password missing</Error>"
		Else 
			If ([Item:4]retired:64)
				$recordData:=$recordData+"\r"+"<Error>Error: Item Retired</Error>"
			Else 
				If (([Item:4]publish:60<1) | ([Item:4]publish:60>[RemoteUser:57]securityLevel:4))
					$recordData:=$recordData+"\r"+"<Error>Error: Not Authorized at your Security Level</Error>"
				Else 
					$recordData:=$recordData+"\r"+"<Error>Valid Item</Error>"
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
					$k:=Get last field number:C255(->[Item:4])
					C_LONGINT:C283($fldType)
					C_TEXT:C284($recordData; $fldValue)
					C_POINTER:C301($ptField)
					TRACE:C157
					For ($i; 1; $k)
						$fldValue:=""
						$doThis:=False:C215
						$ptField:=Field:C253(4; $i)
						$theType:=Type:C295($ptField->)
						Case of 
							: (($theType=0) | ($theType=2) | ($theType=24))
								If (Field:C253(4; $i)->#"")
									$fldValue:=Field:C253(4; $i)->
									$doThis:=True:C214
								End if 
							: ($theType=4)
								If (Field:C253(4; $i)->#!00-00-00!)
									$fldValue:=String:C10(Field:C253(4; $i)->)
									$doThis:=True:C214
								End if 
							: (($theType=1) | ($theType=8))
								If (Field:C253(4; $i)->#0)
									$fldValue:=String:C10(Field:C253(4; $i)->)
									$doThis:=True:C214
								End if 
							: ($theType=9)
								If (Field:C253(4; $i)->#0)
									$fldValue:=String:C10(Field:C253(4; $i)->)
									$doThis:=True:C214
								End if 
							: ($theType=6)
								If (Field:C253(4; $i)->=True:C214)
									$fldValue:="true"
									$doThis:=True:C214
								End if 
							: ($theType=11)
								//        
						End case 
						If ($doThis)
							$recordData:=$recordData+"\r"+"<"+Field name:C257(4; $i)+">"+$fldValue+"</"+Field name:C257(4; $i)+">"
							If (False:C215)  //fixThis
								TEXT TO BLOB:C554("\r"+"<"+Field name:C257(4; $i)+">"+$fldValue+"</"+Field name:C257(4; $i)+">"; $myBlob; UTF8 text without length:K22:17; *)  //* to append instead of $offSet
							End if 
						End if 
					End for 
					TRACE:C157
				End if 
			End if 
		End if 
	End if 
End if 

Http_SendWWWHd($1; "text/html")
$0:=TCP Send($1; $recordData+Storage:C1525.char.crlf+Storage:C1525.char.crlf)
//
If (False:C215)  //fixThis
	$0:=TCP Send Blob($1; $myBlob)
End if 
