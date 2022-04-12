//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/20/12, 19:37:12
// ----------------------------------------------------
// Method: MfrXRefCreate
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($CustIDatMfr; $CustNameAtMfr; $mfrID; $customerIDLocal)
Case of 
	: (Count parameters:C259=0)
		$CustIDatMfr:=aText2{6}
		$CustNameAtMfr:=aText2{7}
		$mfrID:=vText3
		$customerIDLocal:=[Customer:2]customerID:1
	: (Count parameters:C259=0)
		$customerIDLocal:=$1
		$mfrID:=$2
		$CustIDatMfr:=$3
		$CustNameAtMfr:=$4
		
		//
End case 
//be better at passing values
QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]customerID:2=$customerIDLocal; *)
QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrid:3=$mfrID)
If ((Records in selection:C76([MfrCustomerXRef:110])=0) & ($CustIDatMfr#""))
	QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]mfrAccountNum:37=$CustIDatMfr; *)
	QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrid:3=$mfrID)
End if 

If ([Customer:2]customerID:1#$customerIDLocal)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=$customerIDLocal)
End if 
If ([ManufacturerTerm:111]customerID:1#$mfrID)
	QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=$mfrID)
End if 

Case of 
	: (Records in selection:C76([MfrCustomerXRef:110])>1)
		SELECTION TO ARRAY:C260([MfrCustomerXRef:110]; aLongInt1)
		$cntRay:=Records in selection:C76([MfrCustomerXRef:110])
		For ($incRay; 2; $cntRay)
			GOTO RECORD:C242([MfrCustomerXRef:110]; aLongInt1{$incRay})
			DELETE RECORD:C58([MfrCustomerXRef:110])
		End for 
		GOTO RECORD:C242([MfrCustomerXRef:110]; aLongInt1{1})
	: (Records in selection:C76([MfrCustomerXRef:110])=0)
		CREATE RECORD:C68([MfrCustomerXRef:110])
		
		[MfrCustomerXRef:110]mfrAccountNum:37:=$CustIDatMfr
		[MfrCustomerXRef:110]customerNameAtMfr:39:=$CustNameAtMfr
		[MfrCustomerXRef:110]mfrid:3:=$mfrID
		[MfrCustomerXRef:110]zipCustomer:8:=[Customer:2]zip:8
		[MfrCustomerXRef:110]customerName:6:=[Customer:2]company:2
		[MfrCustomerXRef:110]customerID:2:=[Customer:2]customerID:1
		[MfrCustomerXRef:110]manufacturerName:5:=[ManufacturerTerm:111]company:9
		[MfrCustomerXRef:110]division:36:=[ManufacturerTerm:111]division:8
		[MfrCustomerXRef:110]dateLastOrder:14:=Current date:C33
		[MfrCustomerXRef:110]dateLastUpdate:7:=Current date:C33
		[MfrCustomerXRef:110]manufacturerName:5:=[ManufacturerTerm:111]company:9
		[MfrCustomerXRef:110]terms:32:=[ManufacturerTerm:111]terms:7
		[MfrCustomerXRef:110]typeSale:31:=[Customer:2]typeSale:18
		[MfrCustomerXRef:110]statusRelationship:12:="violation"
		SAVE RECORD:C53([MfrCustomerXRef:110])
End case 

If (False:C215)
	iloText12:="WCC_Execute?variable1="+[Order:3]customerID:1+"&variable2="+[Order:3]mfrid:52+"&TableName=TallyMasters&ReportName=MfrCustomerXRefs&Purpose=webscript&jitPageOne="+"WccMfrCustomerXRefsOne.html"
	
	
	QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]customerID:2=variable1; *)
	QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrid:3=variable2)
	If ([Customer:2]customerID:1#variable1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=variable1)
	End if 
	If ([ManufacturerTerm:111]customerID:1#variable2)
		QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=variable2)
	End if 
	If (Records in selection:C76([MfrCustomerXRef:110])=0)
		CREATE RECORD:C68([MfrCustomerXRef:110])
		
		[MfrCustomerXRef:110]customerID:2:=variable1
		[MfrCustomerXRef:110]mfrid:3:=variable2
		[MfrCustomerXRef:110]mfrAccountNum:37:="NEED TO ENTER"
		[MfrCustomerXRef:110]customerNameAtMfr:39:=[Customer:2]company:2
		[MfrCustomerXRef:110]zipCustomer:8:=[Customer:2]zip:8
		[MfrCustomerXRef:110]customerName:6:=[Customer:2]company:2
		[MfrCustomerXRef:110]manufacturerName:5:=[ManufacturerTerm:111]company:9
		[MfrCustomerXRef:110]division:36:=[ManufacturerTerm:111]division:8
		[MfrCustomerXRef:110]dateLastOrder:14:=Current date:C33
		[MfrCustomerXRef:110]dateLastUpdate:7:=Current date:C33
		[MfrCustomerXRef:110]manufacturerName:5:=[ManufacturerTerm:111]company:9
		[MfrCustomerXRef:110]terms:32:=[ManufacturerTerm:111]terms:7
		[MfrCustomerXRef:110]typeSale:31:=[Customer:2]typeSale:18
		[MfrCustomerXRef:110]statusRelationship:12:="violation"
		SAVE RECORD:C53([MfrCustomerXRef:110])
	End if 
End if 
