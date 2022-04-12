//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Method: WccInshipGoods
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($txtPage; $txtPart)
C_REAL:C285($runQty; $qty; $runPrice; pUnitPrice; pExtPrice; addDiscount)
C_TEXT:C284(vText1; vText2; vText3; vText4; vText5; vText6; vText7; vText8; vText9; vText10)
C_LONGINT:C283($err; $pTest; $vlBeenHere; vlBeenHere)
C_LONGINT:C283($1; $4; $tableNum)
C_POINTER:C301($2)
C_TEXT:C284($3; $tableName)
If (Count parameters:C259=4)
	$tableName:=$3
	$tableNum:=$4
Else 
	$tableName:=WCapi_GetParameter("TableName"; "")
	$tableNum:=STR_GetTableNumber($tableName)
End if 
$pageDo:=WC_DoPage("Error.html"; "")
vResponse:="No valid table."
vText9:=""
$madeBy:=[RemoteUser:57]customerID:10
$madeByTable:=[RemoteUser:57]tableNum:9
$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
If ($recordNum>0)
	GOTO RECORD:C242(Table:C252($tableNum)->; $recordNum)
	QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
	If ((Record number:C243([Vendor:38])>-1) & (Record number:C243([PO:39])>-1))
		vlReceiptID:=Num:C11(WCapi_GetParameter("ReceiptID"; ""))
		If (vlReceiptID<10)
			vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1; True:C214)
		End if 
		If ($vendPackList="")
			$vendorPackList:=WCapi_GetParameter("VendorPackList"; "")
			If ($vendorPackList="")
				$vendorPackList:=$madeBy
			End if 
		End if 
		$vendorPackList:=WCapi_GetParameter("VendorPackList"; "")
		
		If ($vendorPackDate=!00-00-00!)
			$vendorPackDate:=Date:C102(WCapi_GetParameter("VendorPackList"; ""))
			If ($vendorPackDate=!00-00-00!)
				$vendorPackDate:=Current date:C33
			End if 
		End if 
		QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
		PoLnFillRays(Records in selection:C76([POLine:40]))
		
		IVNT_dRayInit
		//    
		//
		vResponse:="No RecordNum Delimiters."
		If (Position:C15("RecordNum"; $2->)>0)
			$pageDo:=WCapi_GetParameter("jitPageOne"; "")
			$pageDo:=WC_DoPage("CWS"+$tableName+"One.html"; $pageDo)
			// $pageDo:=WCapi_GetParameter("jitPageList";"")
			If ($2->="Get@")  //must be here to catch the last item or it gets zeroed
				$p:=Position:C15(Storage:C1525.char.crlf; $2->)
				If ($p>0)
					$2->:=Substring:C12($2->; 1; $p-1)
				End if 
			End if 
			//
			
			C_LONGINT:C283($p; $pEqual; $pEnd; $pCR; $pEndSeg)
			$endLoop:=False:C215
			Repeat 
				vText7:=""
				$p:=Position:C15("RecordNum"; $2->)  //do the lines  
				$2->:=Substring:C12($2->; $p+4)  //clip off thru the "&" string     
				$pNext:=Position:C15("RecordNum"; $2->)  //do the lines
				If ($pNext=0)
					vText7:="Get /Reco"+$2->
					$endLoop:=True:C214
					$2->:=""
				Else 
					vText7:="Get /Reco"+Substring:C12($2->; 1; $pNext-1)+" HTTP/"  //clip incoming to a single item record
					
				End if 
				// $saveMe:=WCapi_GetParameter(->vText7;"SaveMe";"")
				//If ($saveMe="on")
				$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
				READ WRITE:C146(Table:C252($tableNum)->)
				If ($recordNum>0)  //must have at least one record
					GOTO RECORD:C242(Table:C252($tableNum)->; $recordNum)
					$newRec:=False:C215
				End if 
				vResponse:="Changes Posted."
				//WC_Parse ($tableNum;->vText7;False)
				//
				$w:=Find in array:C230(aPoUniqueID; [POLine:40]idNum:32)
				If ($w>0)
					aPOLineAction:=$w
					$dRec:=Num:C11(WCapi_GetParameter("QtyReceived"; ""))
					If ($dRec#0)
						aPOQtyNow{$w}:=$dRec
						aPOQtyRcvd{$w}:=aPOQtyRcvd{$w}+$dRec
						aPoQtyBL{aPOLineAction}:=aPoQtyBL{aPOLineAction}-$dRec
						If (((aPOQtyOrder{aPOLineAction}>=0) & (aPOQtyRcvd{aPOLineAction}>=aPOQtyOrder{aPOLineAction})) | ((aPOQtyOrder{aPOLineAction}<0) & (aPOQtyRcvd{aPOLineAction}<=aPOQtyOrder{aPOLineAction})))
							aPOLnCmplt{aPOLineAction}:="x"
						End if 
						PoLnExtend(aPOLineAction)
					End if 
					$receivingNote:=WCapi_GetParameter("ReceivingNote"; "")
					$serialNums:=WCapi_GetParameter("SerialNums"; "")
					If ($receivingNote#"")
						aPoLComment{$w}:=String:C10(Current date:C33; 1)+":  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "+$madeBy+$receivingNote+"\r"+aPoLComment{$w}
					End if 
					If ($serialNums#"")
						aPoLComment{$w}:="<serialNumbers>"+$serialNums+"</serialNumbers>"+"\r"+aPoLComment{$w}
					End if 
				End if 
				//  End if 
			Until ($endLoop)
			
			vMod:=True:C214
			booAccept:=True:C214
			acceptPO
			
			
			
			
			QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
		End if 
	End if 
End if 

$err:=WC_PageSendWithTags($1; $pageDo; 0)
//  
vlReceiptID:=0
