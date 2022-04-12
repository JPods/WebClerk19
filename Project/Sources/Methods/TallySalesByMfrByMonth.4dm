//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-05T00:00:00, 16:19:39
// ----------------------------------------------------
// Method: TallySalesByMfrByMonth
// Description
// Modified by: William James (2013-06-05T00:00:00)
// 
// 
//
// Parameters
// ----------------------------------------------------



vDate3:=!2013-01-01!

C_TEXT:C284(vcustomerID; vVendorID; vMessage)
C_LONGINT:C283(dtReport; dtYearBegin)
C_TEXT:C284(reportName)

QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByMonth")
ARRAY TEXT:C222(aText1; 0)
DISTINCT VALUES:C339([TallyResult:73]customerID:30; aText1)

vDate1:=Date_ThisYear(vDate3; 0)  // date begin of the year
vDate2:=Date_ThisYear(vDate3; 1)  // date of the year end
dtYearBegin:=DateTime_Enter(vDate1; ?00:00:00?)
dtReport:=DateTime_Enter(vDate2; ?23:59:59?)

C_TEXT:C284(vcustomerID; vVendorID; vMessage)
vi2:=Size of array:C274(aText1)
For (vi1; 1; vi2)
	vcustomerID:=aText1{vi1}
	QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByMonth"; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12>=dtYearBegin; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12<=dtReport; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID)
	vi4:=Records in selection:C76([TallyResult:73])
	If (vi4>1)
		
		
	End if 
	
	vi13:=111
	If (vi4>0)
		ORDER BY:C49([TallyResult:73]; [TallyResult:73]salesNameID:31)
		FIRST RECORD:C50([TallyResult:73])
		vVendorID:=[TallyResult:73]salesNameID:31
		vi3:=0
		//
		vR1:=0
		vR2:=0
		vR3:=0
		vR4:=0
		vR5:=0
		Repeat 
			vi3:=vi3+1
			vR1:=vR1+[TallyResult:73]real1:13
			vR2:=vR2+[TallyResult:73]real2:14
			vR3:=vR3+[TallyResult:73]real3:15
			vR4:=vR4+[TallyResult:73]real4:16
			vR5:=vR5+[TallyResult:73]real5:32
			
			
			
			vi7:=-1
			If (vi3<vi4)  // if there are multiple records, get the next record
				NEXT RECORD:C51([TallyResult:73])
				vi7:=Record number:C243([TallyResult:73])
			Else 
				vi13:=1
			End if 
			If (vVendorID#[TallyResult:73]salesNameID:31)  // if the next record has a different VendorID, make a new record
				vi13:=1
			End if 
			
			If (vi13=1)
				//
				QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByYear"; *)  // build a yearly summary for 
				QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID; *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]tableNum:3=Table:C252(->[Customer:2]); *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=vVendorID; *)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=dtReport)
				
				If (Records in selection:C76([TallyResult:73])=0)
					CREATE RECORD:C68([TallyResult:73])
					
					[TallyResult:73]purpose:2:="CustMfrByYear"
					[TallyResult:73]customerID:30:=vcustomerID
					[TallyResult:73]itemNum:34:=[Customer:2]company:2
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
				[TallyResult:73]real1:13:=vR1  // save the values accumulated
				[TallyResult:73]real2:14:=vR2
				[TallyResult:73]real3:15:=vR3
				[TallyResult:73]real4:16:=vR4
				[TallyResult:73]real5:32:=vR5
				SAVE RECORD:C53([TallyResult:73])
				
				If (vi7>-1)
					GOTO RECORD:C242([TallyResult:73]; vi7)
					vi13:=111  // set a flat to store n
					vVendorID:=[TallyResult:73]salesNameID:31
				End if 
				vR1:=0
				vR2:=0
				vR3:=0
				vR4:=0
				vR5:=0
			End if 
		Until (vi3>=vi4)
	End if 
End for 
UNLOAD RECORD:C212([TallyResult:73])


If (False:C215)
	
	
	
	
	
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
	
	
	
	If (False:C215)
		
		vDate3:=!2011-01-01!
		
		C_TEXT:C284(vcustomerID; vVendorID; vMessage)
		C_LONGINT:C283(dtReport)
		C_TEXT:C284(reportName)
		
		
		QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByMonth")
		ARRAY TEXT:C222(aText1; 0)
		DISTINCT VALUES:C339([TallyResult:73]customerID:30; aText1)
		
		vDate1:=Date_ThisYear(vDate3; 1)
		dtReport:=DateTime_Enter(vDate2; ?23:59:59?)
		C_TEXT:C284(vcustomerID; vVendorID; vMessage)
		vi2:=Size of array:C274(aText1)
		For (vi1; 1; vi2)
			vcustomerID:=aText1{vi1}
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByMonth"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID)
			vi4:=Records in selection:C76([TallyResult:73])
			vi13:=111
			If (vi4>0)
				ORDER BY:C49([TallyResult:73]; [TallyResult:73]dtReport:12; [TallyResult:73]salesNameID:31)
				FIRST RECORD:C50([TallyResult:73])
				vVendorID:=[TallyResult:73]salesNameID:31
				vi3:=0
				vi1:=0
				vR1:=0
				vR2:=0
				vR3:=0
				vR4:=0
				vR5:=0
				Repeat 
					vi3:=vi3+1
					vR1:=vR1+[TallyResult:73]real1:13
					vR2:=vR2+[TallyResult:73]real2:14
					vR3:=vR3+[TallyResult:73]real3:15
					vR4:=vR4+[TallyResult:73]real4:16
					vR5:=vR5+[TallyResult:73]real5:32
					
					If (vi3<vi4)
						NEXT RECORD:C51([TallyResult:73])
					Else 
						vi13:=1
					End if 
					If (vVendorID#[TallyResult:73]salesNameID:31)
						vi13:=1
					End if 
					
					If (vi13=1)
						vi13:=111
						vVendorID:=[TallyResult:73]salesNameID:31
						//
						QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByYear"; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]tableNum:3=Table:C252(->[Customer:2]); *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=vVendorID; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=dtReport)
						
						If (Records in selection:C76([TallyResult:73])=0)
							CREATE RECORD:C68([TallyResult:73])
							
							[TallyResult:73]purpose:2:="CustMfrByYear"
							[TallyResult:73]customerID:30:=vcustomerID
							[TallyResult:73]itemNum:34:=[Customer:2]company:2
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
						[TallyResult:73]real1:13:=vR1  // save the values accumulated
						[TallyResult:73]real2:14:=vR2
						[TallyResult:73]real3:15:=vR3
						[TallyResult:73]real4:16:=vR4
						[TallyResult:73]real5:32:=vR5
						vR1:=0
						vR2:=0
						vR3:=0
						vR4:=0
						vR5:=0
					End if 
				Until (vi3>=vi4)
			End if 
		End for 
		UNLOAD RECORD:C212([TallyResult:73])
	End if 
	
	
	
	
	
	If (False:C215)
		
		vDate3:=!2011-01-01!
		
		C_TEXT:C284(vcustomerID; vVendorID; vMessage)
		C_LONGINT:C283(dtReport)
		C_TEXT:C284(reportName)
		
		ARRAY TEXT:C222(aText1; 0)
		DISTINCT VALUES:C339([TallyResult:73]customerID:30; aText1)
		
		vDate1:=Date_ThisYear(vDate3; 1)
		dtReport:=DateTime_Enter(vDate2; ?23:59:59?)
		C_TEXT:C284(vcustomerID; vVendorID; vMessage)
		ALL RECORDS:C47([Customer:2])
		vi2:=Records in selection:C76([Customer:2])
		FIRST RECORD:C50([Customer:2])
		For (vi1; 1; vi2)
			vcustomerID:=[Customer:2]customerID:1
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByMonth"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID)
			vi4:=Records in selection:C76([TallyResult:73])
			vi13:=111
			If (vi4>0)
				ORDER BY:C49([TallyResult:73]; [TallyResult:73]dtReport:12; [TallyResult:73]salesNameID:31)
				FIRST RECORD:C50([TallyResult:73])
				vVendorID:=[TallyResult:73]salesNameID:31
				vi3:=0
				vi1:=0
				vR1:=0
				vR2:=0
				vR3:=0
				vR4:=0
				vR5:=0
				Repeat 
					vi3:=vi3+1
					vR1:=vR1+[TallyResult:73]real1:13
					vR2:=vR2+[TallyResult:73]real2:14
					vR3:=vR3+[TallyResult:73]real3:15
					vR4:=vR4+[TallyResult:73]real4:16
					vR5:=vR5+[TallyResult:73]real5:32
					
					If (vi3<vi4)
						NEXT RECORD:C51([TallyResult:73])
					Else 
						vi13:=1
					End if 
					If (vVendorID#[TallyResult:73]salesNameID:31)
						vi13:=1
					End if 
					
					If (vi13=1)
						vi13:=111
						vVendorID:=[TallyResult:73]salesNameID:31
						//
						QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="CustMfrByYear"; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=vcustomerID; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]tableNum:3=Table:C252(->[Customer:2]); *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=vVendorID; *)
						QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=dtReport)
						
						If (Records in selection:C76([TallyResult:73])=0)
							CREATE RECORD:C68([TallyResult:73])
							
							[TallyResult:73]purpose:2:="CustMfrByYear"
							[TallyResult:73]customerID:30:=vcustomerID
							[TallyResult:73]itemNum:34:=[Customer:2]company:2
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
						[TallyResult:73]real1:13:=vR1  // save the values accumulated
						[TallyResult:73]real2:14:=vR2
						[TallyResult:73]real3:15:=vR3
						[TallyResult:73]real4:16:=vR4
						[TallyResult:73]real5:32:=vR5
						vR1:=0
						vR2:=0
						vR3:=0
						vR4:=0
						vR5:=0
					End if 
				Until (vi3>=vi4)
			End if 
			NEXT RECORD:C51([Customer:2])
		End for 
	End if 
	
	
	
End if 
