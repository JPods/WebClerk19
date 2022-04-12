//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-24T00:00:00, 06:33:47
// ----------------------------------------------------
// Method: TallySalesByCustomerByMonth
// Description
// Modified: 07/24/13
// 
// 
//
// Parameters
// ----------------------------------------------------



vDate3:=!2011-01-01!
vi16:=24
vi15:=0
vi13:=111  // set a flat to store n
vi14:=222  //set a flag to hunt for the last record
C_TEXT:C284(vcustomerID; vVendorID; vMessage)
For (vi15; 1; vi16)
	REDUCE SELECTION:C351([TallyResult:73]; 0)
	vDate1:=Date_ThisMon(vDate3; 0)
	vDate2:=Date_ThisMon(vDate3; 1)
	vDate3:=vDate2+2
	vcustomerID:=""
	vVendorID:=""
	QUERY:C277([OrderLine:49]; [OrderLine:49]dateDocument:25>=vDate1; *)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]dateDocument:25<=vDate2; *)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]vendorID:42#"")  // orderlines in a month
	vi2:=Records in selection:C76([OrderLine:49])  //number of records to processed
	If (vi2>0)
		ORDER BY:C49([OrderLine:49]; [OrderLine:49]customerID:2; [OrderLine:49]vendorID:42)
		FIRST RECORD:C50([OrderLine:49])
		vi1:=0
		vR1:=0
		vR2:=0
		vR3:=0
		vR4:=0
		vR5:=0
		vVendorID:=[OrderLine:49]vendorID:42
		vcustomerID:=[OrderLine:49]customerID:2  //start with the first record being accepted for its values
		Repeat 
			vi1:=vi1+1  //increment a counter of the number of records processed
			
			
			If ((vDate2=!2012-05-31!) & ([OrderLine:49]customerID:2="wc_5715"))
				
				
			End if 
			
			
			If ((vVendorID=[OrderLine:49]vendorID:42) & (vcustomerID=[OrderLine:49]customerID:2))  // same customer and vendor
				vR1:=vR1+[OrderLine:49]extendedPrice:11
				vR2:=vR2+[OrderLine:49]extendedCost:13
				vR3:=vR3+[OrderLine:49]backOrdAmount:26
				vR4:=vR4+[OrderLine:49]qty:6
				vR5:=vR5+[OrderLine:49]qtyBackLogged:8
				
				If (vi1=vi2)  // save TallyResults on last record
					vi13:=1
				End if 
			Else 
				If (vi1>1)  // save TallyResults
					vi13:=1
				End if 
			End if 
			
			If (vi13=1)
				vi13:=111
				// change in either a customer or a vendor
				C_LONGINT:C283(dtReport)
				C_TEXT:C284(reportName)
				dtReport:=DateTime_Enter(vDate2; ?23:59:59?)
				QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByMonth"; *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID; *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]tableNum:3=Table:C252(->[Customer:2]); *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=vVendorID; *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=dtReport)
				If (Records in selection:C76([TallyResult:73])=0)
					CREATE RECORD:C68([TallyResult:73])
					
					[TallyResult:73]purpose:2:="CustMfrByMonth"
					[TallyResult:73]customerID:30:=vcustomerID
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=vcustomerID)
					[TallyResult:73]itemNum:34:=[Customer:2]company:2
					UNLOAD RECORD:C212([Customer:2])
					[TallyResult:73]tableNum:3:=Table:C252(->[Customer:2])
					[TallyResult:73]salesNameID:31:=vVendorID
					[TallyResult:73]nameProfile1:26:="mfrID"
					[TallyResult:73]profile1:17:=vVendorID
					[TallyResult:73]dtReport:12:=dtReport
					[TallyResult:73]name:1:=[TallyResult:73]customerID:30+Substring:C12(String:C10(Year of:C25(vDate1)); 3; 4)+String:C10(Month of:C24(vDate1); "00")
					
					[TallyResult:73]nameReal1:20:="Amount"
					[TallyResult:73]nameReal2:21:="Cost"
					[TallyResult:73]nameReal3:22:="Backlog"
					[TallyResult:73]nameReal4:23:="QtyOrdered"
					[TallyResult:73]nameReal5:33:="QtyBacklog"
				End if 
				If (False:C215)  // put in to fix existing records
					vi2:=Records in selection:C76([TallyResult:73])
					FIRST RECORD:C50([TallyResult:73])
					For (vi1; 1; vi2)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[TallyResult:73]customerID:30)
						[TallyResult:73]itemNum:34:=[Customer:2]company:2
						[TallyResult:73]nameProfile1:26:="mfrID"
						[TallyResult:73]profile1:17:=[TallyResult:73]salesNameID:31
						SAVE RECORD:C53([TallyResult:73])
						NEXT RECORD:C51([TallyResult:73])
					End for 
					UNLOAD RECORD:C212([TallyResult:73])
				End if 
				
				
				[TallyResult:73]real1:13:=vR1  // save the values accumulated
				[TallyResult:73]real2:14:=vR2
				[TallyResult:73]real3:15:=vR3
				[TallyResult:73]real4:16:=vR4
				[TallyResult:73]real5:32:=vR5
				SAVE RECORD:C53([TallyResult:73])
			End if 
			vVendorID:=[OrderLine:49]vendorID:42  // Reset values to be accumulated
			vcustomerID:=[OrderLine:49]customerID:2
			vR1:=[OrderLine:49]extendedPrice:11
			vR2:=[OrderLine:49]extendedCost:13
			vR3:=[OrderLine:49]backOrdAmount:26
			vR4:=[OrderLine:49]qty:6
			vR5:=[OrderLine:49]qtyBackLogged:8
			NEXT RECORD:C51([OrderLine:49])
			KeyModifierCurrent
		Until ((vi1=vi2) | (OptKey=1))
		UNLOAD RECORD:C212([TallyResult:73])
		UNLOAD RECORD:C212([OrderLine:49])
	End if 
End for 