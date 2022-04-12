C_POINTER:C301($tempPt)
C_BOOLEAN:C305($doPopVend; $doPopCust)
C_TEXT:C284($srTemp; $srPhone; $srAcct; $srZip)
If ([ItemSerial:47]vendorID:5="")
	CONFIRM:C162("Identify a vendor for this serial number.")
	If (OK=1)
		If (((ptCurTable=(->[PO:39])) | (ptCurTable=(->[POLine:40])) | (ptCurTable=(->[Vendor:38]))) & (vHere>1))
			PUSH RECORD:C176([Vendor:38])
			$doPopVend:=True:C214
			$srTemp:=srCustomer
			$srPhone:=srPhone
			$srAcct:=srAcct
			$srZip:=srZip
			If (Records in selection:C76([Customer:2])>1)
				PUSH RECORD:C176([Customer:2])
				$doPopCust:=True:C214
			End if 
		Else 
			If ((Records in selection:C76([Customer:2])>0) & (vHere>1))
				PUSH RECORD:C176([Customer:2])
				$doPopCust:=True:C214
				$srTemp:=srCustomer
				$srPhone:=srPhone
				$srAcct:=srAcct
				$srZip:=srZip
			End if 
		End if 
		$tempPt:=ptCurTable
		ptCurTable:=(->[Vendor:38])
		jSrchCustLoad(->[Vendor:38]; ->[Vendor:38]company:2; ->srCustomer; False:C215)
		ptCurTable:=$tempPt
		If ((Records in selection:C76([Vendor:38])>0) & (myOK#0))
			[ItemSerial:47]vendorID:5:=[Vendor:38]vendorID:1
			SAVE RECORD:C53([ItemSerial:47])
			UNLOAD RECORD:C212([Vendor:38])
		End if 
		If ($doPopCust)
			POP RECORD:C177([Customer:2])
			srCustomer:=$srTemp
			srPhone:=$srPhone
			srAcct:=$srAcct
			srZip:=$srZip
		End if 
		If ($doPopVend)
			POP RECORD:C177([Vendor:38])
			srCustomer:=$srTemp
			srPhone:=$srPhone
			srAcct:=$srAcct
			srZip:=$srZip
		End if 
	End if 
Else 
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[ItemSerial:47]vendorID:5)
	ProcessTableOpen(Table:C252(->[Vendor:38])*-1)
End if 