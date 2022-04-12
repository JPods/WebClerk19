//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-08T00:00:00, 08:44:07
// ----------------------------------------------------
// Method: TallyVendSaleMo
// Description
// Modified: 11/08/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($2; $doMessage)
$doMessage:=True:C214

If (Count parameters:C259>0)
	vDate3:=$1
	OK:=1
	If (Count parameters:C259>1)
		$doMessage:=$2
	End if 
Else 
	vDate3:=Date:C102(Request:C163("Enter date; Monthly Vendor Sales"; String:C10(Current date:C33)))
End if 
If (OK=1)
	REDUCE SELECTION:C351([TallyResult:73]; 0)
	vDate1:=Date_ThisMon(vDate3; 0)
	vDate2:=Date_ThisMon(vDate3; 1)
	QUERY:C277([OrderLine:49]; [OrderLine:49]dateDocument:25>=vDate1; *)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]dateDocument:25<=vDate2; *)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]vendorID:42#"")
	$curVend:=[OrderLine:49]vendorID:42
	vi2:=Records in selection:C76([OrderLine:49])
	vi1:=0
	vR1:=0
	vR2:=0
	vR3:=0
	vR4:=0
	C_LONGINT:C283($i; $k)
	SELECTION TO ARRAY:C260([OrderLine:49]extendedPrice:11; aReal1; [OrderLine:49]extendedCost:13; aReal2)
	$k:=Size of array:C274(aReal1)
	For ($i; 1; $k)
		vR1:=vR1+aReal1{$i}
		vR2:=vR2+aReal2{$i}
	End for 
	vR3:=vR1-vR2
	ARRAY REAL:C219(aReal1; 0)
	ARRAY REAL:C219(aReal2; 0)
	ORDER BY:C49([OrderLine:49]; [OrderLine:49]vendorID:42; [OrderLine:49]repID:36)
	FIRST RECORD:C50([OrderLine:49])
	TRACE:C157
	If (vi2>0)
		$doMessage:=False:C215
		If ($doMessage)
			//ThermoInitExit ("Tally Sales By Vendor";vi2;True)
			$viProgressID:=Progress New
			
		End if 
		$dtOfRpt:=DateTime_Enter(vDate2; ?23:59:59?)
		$nameRpt:=Substring:C12(String:C10(Year of:C25(vDate1)); 3; 4)+String:C10(Month of:C24(vDate1); "00")
		Repeat 
			$curRep:=[OrderLine:49]repID:36
			$curVend:=[OrderLine:49]vendorID:42
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="VenRepMon"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=[OrderLine:49]vendorID:42; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]tableNum:3=Table:C252(->[Vendor:38]); *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]salesNameID:31=[OrderLine:49]repID:36; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=$dtOfRpt)
			If (Records in selection:C76([TallyResult:73])=0)
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]purpose:2:="VenRepMon"
				[TallyResult:73]name:1:=$nameRpt+":"+[OrderLine:49]vendorID:42
				[TallyResult:73]customerID:30:=[OrderLine:49]vendorID:42
				[TallyResult:73]tableNum:3:=Table:C252(->[Vendor:38])
				[TallyResult:73]salesNameID:31:=[OrderLine:49]repID:36
				[TallyResult:73]dtReport:12:=$dtOfRpt
			Else 
				[TallyResult:73]longint1:7:=0
				[TallyResult:73]longInt2:8:=0
				[TallyResult:73]real1:13:=0
				[TallyResult:73]real2:14:=0
				[TallyResult:73]real3:15:=0
				[TallyResult:73]real4:16:=0
				[TallyResult:73]real5:32:=0
				[TallyResult:73]real6:42:=0
				[TallyResult:73]real7:43:=0
			End if 
			[TallyResult:73]dtCreated:11:=DateTime_Enter
			[TallyResult:73]nameReal1:20:="Sales"
			[TallyResult:73]nameReal2:21:="Margins"
			[TallyResult:73]nameReal3:22:="% Margin"
			[TallyResult:73]nameReal4:23:="Costs"
			[TallyResult:73]nameReal5:33:="% of Sales"
			[TallyResult:73]nameReal6:37:="% of Margins"
			While (($curRep=[OrderLine:49]repID:36) & ($curVend=[OrderLine:49]vendorID:42) & (Record number:C243([OrderLine:49])>-1))
				vi1:=vi1+1
				//
				If ($doMessage)
					//Thermo_Update (vi1)
					ProgressUpdate($viProgressID; vi1; vi2; "Tally Sales By Vendor")
					
					If (<>ThermoAbort)
						vi1:=vi2
						$curRep:="   "
					End if 
				End if 
				[TallyResult:73]real1:13:=[TallyResult:73]real1:13+[OrderLine:49]extendedPrice:11
				[TallyResult:73]real2:14:=[TallyResult:73]real2:14+[OrderLine:49]extendedPrice:11-[OrderLine:49]extendedCost:13
				[TallyResult:73]real4:16:=[TallyResult:73]real4:16+[OrderLine:49]extendedCost:13
				If ([TallyResult:73]real1:13#0)
					[TallyResult:73]real3:15:=Round:C94([TallyResult:73]real2:14/[TallyResult:73]real1:13*100; 2)
				Else 
					[TallyResult:73]real3:15:=0
				End if 
				If (vR1#0)
					[TallyResult:73]real5:32:=Round:C94([TallyResult:73]real1:13/vR1*100; 2)
				Else 
					[TallyResult:73]real5:32:=0
				End if 
				If (vR2#0)
					[TallyResult:73]real6:42:=Round:C94([TallyResult:73]real2:14/vR2*100; 2)
				Else 
					[TallyResult:73]real6:42:=0
				End if 
				NEXT RECORD:C51([OrderLine:49])
			End while 
			SAVE RECORD:C53([TallyResult:73])
		Until (vi1>=vi2)
		If ($doMessage)
			//Thermo_Close 
			Progress QUIT($viProgressID)
			
		End if 
	End if 
End if 
UNLOAD RECORD:C212([TallyResult:73])
UNLOAD RECORD:C212([OrderLine:49])