//%attributes = {"publishedWeb":true}
//Procedure: TallyCustSaleMo
C_DATE:C307($1)
READ ONLY:C145([Invoice:26])
READ ONLY:C145([Customer:2])
READ WRITE:C146([TallyResult:73])
If (Count parameters:C259=0)
	CONFIRM:C162("Tally Sales by Customer")
	C_TEXT:C284($dateStrRpt)
	$dateStrRpt:=Request:C163("Enter date in Month to Tally"; String:C10(Current date:C33))
	If (OK=1)
		vDate3:=Date:C102($dateStrRpt)
	End if 
Else 
	vDate3:=$1
	OK:=1
End if 
If (OK=1)
	vDate1:=Date_ThisMon(vDate3; 0)
	vDate2:=Date_ThisMon(vDate3; 1)
	C_LONGINT:C283($dtReport; $dtCalc)
	C_TEXT:C284($ReportName)
	$dtCalc:=DateTime_DTTo
	$dtReport:=DateTime_DTTo(vDate2; ?23:59:59?)
	$ReportName:="MonSales"+Substring:C12(String:C10(Year of:C25(vDate1)); 3; 4)+String:C10(Month of:C24(vDate1); "00")
	QUERY:C277([Invoice:26]; <>ptInvoiceDateFld->>=vDate1; *)
	QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=vDate2)
	SELECTION TO ARRAY:C260([Invoice:26]customerID:3; aTmp10Str1; [Invoice:26]company:7; aQueryFieldNames; [Invoice:26]salesNameID:23; aTmp25Str1; [Invoice:26]amount:14; aTmpReal1; [Invoice:26]totalCost:37; aTmpReal2)
	MULTI SORT ARRAY:C718(aTmp10Str1; >; aTmp25Str1; >; aQueryFieldNames; aTmpReal1; >; aTmpReal2)
	$k:=Size of array:C274(aTmp10Str1)
	vR1:=0
	vR2:=0
	For ($i; 1; $k)
		vR1:=vR1+aTmpReal1{$i}
		vR2:=vR2+aTmpReal2{$i}
	End for 
	$i:=1
	While ($i<=$k)
		QUERY:C277([TallyResult:73]; [TallyResult:73]customerID:30=aTmp10Str1{$i}; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=aTmp25Str1{$i}; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="SalesMonthly"; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]tableNum:3=2; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=$dtReport; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$ReportName)
		If ([Customer:2]customerID:1#aTmp10Str1{$i})
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=aTmp10Str1{$i})
		End if 
		If (Records in selection:C76([TallyResult:73])=0)
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]customerID:30:=aTmp10Str1{$i}
			[TallyResult:73]salesNameID:31:=aTmp25Str1{$i}
			[TallyResult:73]purpose:2:="SalesMonthly"
			[TallyResult:73]tableNum:3:=2
			[TallyResult:73]dtReport:12:=$dtReport
			[TallyResult:73]name:1:=$ReportName
			[TallyResult:73]dtCreated:11:=$dtCalc
			[TallyResult:73]nameReal1:20:="Sales"
			[TallyResult:73]nameReal2:21:="Cost of Sales"
			[TallyResult:73]nameReal3:22:="Margins"
			[TallyResult:73]nameReal4:23:="Margin %"
			[TallyResult:73]nameReal5:33:="% Mon Sale"
			[TallyResult:73]nameReal6:37:="% Mon Cost"
			[TallyResult:73]nameReal8:39:="1Q Sales"
			[TallyResult:73]nameReal8:39:="2Q Sales"
			[TallyResult:73]nameReal9:40:="3Q Sales"
			[TallyResult:73]nameReal10:41:="4Q Sales"
			[TallyResult:73]nameProfile1:26:="Date Last Sale"
			[TallyResult:73]nameProfile2:27:="Amount Last Sale"
		Else 
			[TallyResult:73]real1:13:=0
			[TallyResult:73]real2:14:=0
			[TallyResult:73]real3:15:=0
			[TallyResult:73]real4:16:=0
			[TallyResult:73]real5:32:=0
			[TallyResult:73]real6:42:=0
			[TallyResult:73]real7:43:=0
			[TallyResult:73]real8:44:=0
			
			// Modified by: Bill James (2022-12-09T06:00:00Z)
			// must fix and adjust to changed data type
			//[TallyResult]dataRaw:=0
			[TallyResult:73]real10:46:=0
		End if 
		[TallyResult:73]real8:44:=[Customer:2]lastSaleAmount:50
		//[TallyResult]dataRaw:=[Customer]salesLastYr
		[TallyResult:73]real10:46:=[Customer:2]salesYTD:47
		Repeat 
			[TallyResult:73]real1:13:=[TallyResult:73]real1:13+aTmpReal1{$i}
			[TallyResult:73]real2:14:=[TallyResult:73]real2:14+aTmpReal2{$i}
			
			[TallyResult:73]real1:13:=Sum:C1([Invoice:26]amount:14)
			vR2:=Sum:C1([Invoice:26]totalCost:37)
			[TallyResult:73]real2:14:=[TallyResult:73]real1:13-vR2
			[TallyResult:73]real3:15:=Round:C94([TallyResult:73]real3:15/vR1*100; 2)
			$i:=$i+1
		Until (([TallyResult:73]customerID:30#aTmp10Str1{$i}) | ([TallyResult:73]salesNameID:31#aTmp25Str1{$i}))
		$i:=$i-1
		[TallyResult:73]profile1:17:=String:C10([Customer:2]lastSaleDate:49)
		[TallyResult:73]profile2:18:=String:C10([Customer:2]lastSaleAmount:50)
		[TallyResult:73]longint1:7:=Round:C94([Customer:2]salesLastYr:48; 0)
		// Modified by: Bill James (2022-12-09T06:00:00Z)
		// mush fix and adjust to data type and object
		
		//[TallyResult]report:=Round([Customer]salesYTD; 0)
		[TallyResult:73]real3:15:=aTmpReal1{$i}-aTmpReal2{$i}
		[TallyResult:73]real4:16:=Round:C94(([TallyResult:73]real1:13-[TallyResult:73]real2:14)/[TallyResult:73]real1:13*100; 2)
		If (vR1#0)
			[TallyResult:73]real5:32:=Round:C94([TallyResult:73]real1:13/vR1*100; 4)
		End if 
		If (vR2#0)
			[TallyResult:73]real6:42:=Round:C94([TallyResult:73]real2:14/vR2*100; 4)
		End if 
		SAVE RECORD:C53([TallyResult:73])
		$i:=$i+1
	End while 
End if 
Temp_RayInit
READ WRITE:C146([Invoice:26])
READ WRITE:C146([Customer:2])
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([Customer:2])
UNLOAD RECORD:C212([TallyResult:73])
READ ONLY:C145([TallyResult:73])

//PUSH RECORD([TallyResult])
//SEARCH([TallyResult];[TallyResult]custVendID=[Customer]customerID;*
//)
//SEARCH([TallyResult];&[TallyResult]FileID=File([Customer]);*)
//SEARCH([TallyResult];&[TallyResult]Purpose="CustomerMonthly";*)
//SEARCH([TallyResult];&[TallyResult]DTReport=(DateTime_DTTo (
//(vDate1-1))))
//[TallyResult]Real4:=[TallyResult]Real4
//[TallyResult]Real5:=[TallyResult]Real5
//POP RECORD([TallyResult])