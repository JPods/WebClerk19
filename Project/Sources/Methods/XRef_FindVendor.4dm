//%attributes = {"publishedWeb":true}
//Procedure: XRef_FindVendor
C_POINTER:C301($1; $2; $3; $4)
C_BOOLEAN:C305($doPop; $popCust)
//September 6, 1995
If ($2->=$1->)
	$2->:=$1->
	$4->:=$3->
Else 
	If (Record number:C243([Vendor:38])#-1)
		$doPop:=True:C214
		PUSH RECORD:C176([Vendor:38])
	End if 
	If (Record number:C243([Customer:2])#-1)
		$popCust:=True:C214
		PUSH RECORD:C176([Customer:2])
	End if 
	$ptFile:=ptCurTable
	ptCurTable:=(->[ItemXRef:22])
	jSrchCustLoad(->[Vendor:38]; $1; $2)
	//SEARCH([Vendor];$1=$2+"@")
	ptCurTable:=$ptFile
	Case of 
		: (Records in selection:C76([Vendor:38])=1)
			$2->:=$1->
			$4->:=$3->
		: (Records in selection:C76([Vendor:38])>1)
			C_POINTER:C301($ptFile)
			$ptFile:=ptCurTable
			ptCurTable:=(->[ItemXRef:22])
		Else 
			BEEP:C151
			BEEP:C151
	End case 
	UNLOAD RECORD:C212([Vendor:38])
	If ($doPop)
		POP RECORD:C177([Vendor:38])
	End if 
	If ($popCust)
		POP RECORD:C177([Customer:2])
	End if 
	If ((ptCurTable=(->[Vendor:38])) | (ptCurTable=(->[ItemXRef:22])) | (ptCurTable=(->[PO:39])) | (ptCurTable=(->[POLine:40])))
		srPhone:=[Vendor:38]phone:10
		//  Put  the formating in the form  jFormatPhone(->srPhone)
		srZip:=[Vendor:38]zip:8
		srCustomer:=[Vendor:38]attention:55
		srAcct:=[Vendor:38]vendorID:1
	Else 
		srPhone:=[Customer:2]phone:13
		//  Put  the formating in the form  jFormatPhone(->srPhone)
		srZip:=[Customer:2]zip:8
		srCustomer:=[Customer:2]company:2
		srAcct:=[Customer:2]customerID:1
	End if 
End if 