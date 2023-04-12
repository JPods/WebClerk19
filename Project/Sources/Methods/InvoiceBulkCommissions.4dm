//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-26T00:00:00, 21:48:37
// ----------------------------------------------------
// Method: InvoiceBulkCommissions
// Description
// Modified: 01/26/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// single hash set are comments from the TallyMaster. //  // are comments from within the TallyMasters
// If (variable1#"")
//  QUERY([Order];[Order]OrderNum=Num(variable1))
//If (Records in selection([Order])=1)  //  & ([RemoteUser]customerID=[Order]mfrID))
If ((Record number:C243([Order:3])>-1) & (Not:C34(Locked:C147([Order:3]))))
	//
	READ ONLY:C145([zzzManufacturerTerm:111])
	QUERY:C277([zzzManufacturerTerm:111]; [zzzManufacturerTerm:111]customerID:1=[Order:3]mfrID:52)
	//
	C_LONGINT:C283($cntMfrTerms)
	$cntMfrTerms:=Records in selection:C76([zzzManufacturerTerm:111])
	If ($cntMfrTerms#1)
		If (allowAlerts_boo)
			ALERT:C41("[Order]mfrID of "+[Order:3]mfrID:52+" has "+String:C10($cntMfrTerms)+" ManufactureTerms Records")
		End if 
	Else 
		vR7:=[Order:3]amount:24
		//Round(([Order]SalesCommission+[Order]RepCommission/[Order]Amount*100);2)
		
		vR8:=Round:C94((([Order:3]repCommission:9/([Order:3]salesCommission:11+[Order:3]repCommission:9))*100); 2)
		
		vR9:=Round:C94((([Customer:2]discount:36/100)*[Order:3]amountBackLog:54); 2)
		
		
		C_LONGINT:C283($1; $pathManage; $7; $inTest)
		C_REAL:C285($2; $backlog; $3; $valueInvoiced; $8; $commission; $9; $split)
		C_DATE:C307($4; $lastDate)
		C_TEXT:C284($5; $lastInvoice; $6; $lastCriteria)
		
		
		v4:="Com"+[Order:3]mfrID:52
		srOrd:=[Order:3]idNum:2
		vAmount:=[Order:3]amountBackLog:54  //Num(Variable4)
		v2:=[Order:3]typeSale:22
		vR6:=[Order:3]amountBackLog:54  //  Num(Variable4)
		vR5:=Round:C94(vR6*([Customer:2]discount:36*0.01); 2)  // Round(vR6*(Num(Variable7)*0.01);2)  //  variable 7 = 2_36  [Customer]Discount
		//  vR7:=[Order]Amount
		v6:=Variable10  //Mfr Order
		v7:=Variable11  //Mfr Invoice
		vDate6:=Current date:C33  // Date(Variable6)  //date shipped
		vR2:=Round:C94(vR7; 2)  // [ManufacturerTerm]CommissionBase//  Num(Variable7)  //default commission %  15  
		vR4:=vR8  // Num(Variable8)  //commission Split    40
		vR1:=Round:C94(vR6*vR2*0.01; 2)  // commission rate
		vR3:=Round:C94(vR1*vR4*0.01; 2)
		
		If ([Order:3]flow:134=0)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			//  //$backlog:=OrdersFlowToCommission (4)//Item record must already be the selection
			$backlog:=OrdersFlowToCommission(4)  //Item record must already be the selection
			//  //[Order]Flow:=4
			
			
			// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
			//CMANewCommOrderLine(-1; $backlog; $backlog; Current date; "CommWindow"; "exact"; 0; vR2; vR4)
			//CMAComOrderOneLine(4)
			
			
			// Modified by: Bill James (2015-12-16T00:00:00 Convert_2_v14)
			//[Order]Flow:=4
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			// should only be one line.
			[Order:3]amount:24:=[OrderLine:49]extendedPrice:11
			[Order:3]repCommission:9:=Round:C94([Order:3]amount:24*[OrderLine:49]commRateRep:18*0.01; 2)
			[Order:3]salesCommission:11:=Round:C94([Order:3]amount:24*[OrderLine:49]commRateSales:29*0.01; 2)
			[Order:3]total:27:=[OrderLine:49]extendedPrice:11
			[Order:3]amountBackLog:54:=[OrderLine:49]backOrdAmount:26
			[Order:3]lng:34:=DateTime_DTTo
			SAVE RECORD:C53([Order:3])
		End if 
		// CMAComInvoiceOneLine (1)  
		// Modified by: William James (2014-03-18T00:00:00 Invoice in a seperate step)
		
		OrdLnFillRays
		If (eOrdList#0)
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
		End if 
		
		
		
		//  zzzz Why is this here. Looks like a work around to automatically link invoices.
		// setting it to faulse until we find what it is for
		If (False:C215)
			C_TEXT:C284(variable13)
			If (variable13#"")
				[Invoice:26]dateLinked:31:=Date:C102(variable13)
			End if 
		End if 
		SAVE RECORD:C53([Invoice:26])
		READ WRITE:C146([zzzManufacturerTerm:111])
	End if 
End if 
//  //End if 
// End if 