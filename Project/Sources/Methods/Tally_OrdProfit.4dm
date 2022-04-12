//%attributes = {"publishedWeb":true}
CONFIRM:C162("Tally costs and profits from an order.")
If (OK=1)
	QUERY:C277([QQQTime:56]; [QQQTime:56]orderNum:3=[Order:3]orderNum:2)
	QUERY:C277([WOdraw:68]; [WOdraw:68]orderNum:1=[Order:3]orderNum:2)
	//SEARCH([WorkOrder];[WorkOrder]SaleOrderNum=[Order]OrderNum)
	//
	//SEARCH([Invoice];[Invoice]OrderNum=[Order]OrderNum)
	//SEARCH([Service];[Service]OrderNum=[Order]OrderNum)
	//SEARCH([POLine];[POLine]RefOrderNum=[Order]OrderNum)
	//SEARCH([Payment];[Payment]OrderNum=[Order]OrderNum)
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([QQQTime:56])
	ORDER BY:C49([QQQTime:56]; [QQQTime:56]Activity:10)
	$i:=0
	C_TEXT:C284($theTest)
	FIRST RECORD:C50([QQQTime:56])
	//ThermoInitExit ("Tally Times";$k;True)
	$viProgressID:=Progress New
	
	While ($i<$k)
		$theTest:=[QQQTime:56]Activity:10
		$theChange:=0
		$theTime:=0
		$theCost:=0
		Repeat 
			$i:=$i+1
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Tally Times")
			
			If (<>ThermoAbort)
				$i:=$k
				$k:=-100
			End if 
			$theChange:=Round:C94((([QQQTime:56]LapseTime:8/3600)*([QQQTime:56]PerCentActive:18*0.01)); 2)
			$theTime:=$theTime+$theChange
			$theCost:=$theCost+Round:C94(($theChange*[QQQTime:56]Rate:9); 2)
			NEXT RECORD:C51([QQQTime:56])
		Until (($i=$k) | ($theTest#[QQQTime:56]Activity:10))
		QUERY:C277([TallyResult:73]; [TallyResult:73]tableNum:3=Table:C252(->[Order:3]); *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]Name:1=String:C10([Order:3]orderNum:2; "0000-0000"); *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]Name:1="Cost Analysis"; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]Profile1:17=[QQQTime:56]Activity:10)
		If (Records in selection:C76([TallyResult:73])=0)
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]tableNum:3:=Table:C252(->[Order:3])
			[TallyResult:73]Name:1:="Cost Analysis"
			[TallyResult:73]Name:1:=String:C10([Order:3]orderNum:2; "0000-0000")
			[TallyResult:73]Purpose:2:="Cost Analysis"
			[TallyResult:73]Profile1:17:=[QQQTime:56]Activity:10
			[TallyResult:73]Profile2:18:="Labor"
		End if 
		[TallyResult:73]Real1:13:=$theTime
		[TallyResult:73]Real2:14:=$theCost
		SAVE RECORD:C53([TallyResult:73])
	End while 
	//
	If ($k#-100)
		$k:=Records in selection:C76([WOdraw:68])
		//ThermoInitExit ("Tally Materials";$k;False)
		ORDER BY:C49([WOdraw:68]; [WOdraw:68]ItemNum:2)
		$i:=0
		FIRST RECORD:C50([WOdraw:68])
		While ($i<$k)
			$theTest:=[WOdraw:68]ItemNum:2
			$theChange:=0
			$theTime:=0
			$theCost:=0
			Repeat 
				$i:=$i+1
				//Thermo_Update ($i)
				ProgressUpdate($viProgressID; $i; $k; "Tally Materials")
				If (ThermoAbort)
					$i:=$k
				End if 
				$theChange:=$theChange+[WOdraw:68]QtyTaken:5
				$theCost:=$theCost+Round:C94([WOdraw:68]Cost:7*[WOdraw:68]QtyTaken:5; <>tcDecimalTt)
				NEXT RECORD:C51([WOdraw:68])
			Until (($i=$k) | ($theTest#[QQQTime:56]Activity:10))
			QUERY:C277([TallyResult:73]; [TallyResult:73]tableNum:3=Table:C252(->[WOdraw:68]); *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]Name:1=[WOdraw:68]ItemNum:2; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]Purpose:2="Cost Analysis"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]Profile1:17=[WOdraw:68]ItemNum:2)
			If (Records in selection:C76([WOdraw:68])=0)
				CREATE RECORD:C68([WOdraw:68])
				
				[TallyResult:73]tableNum:3:=Table:C252(->[WOdraw:68])
				[TallyResult:73]Name:1:="Cost Analysis"
				[TallyResult:73]Name:1:=[WOdraw:68]ItemNum:2
				[TallyResult:73]Purpose:2:="Cost Analysis"
				[TallyResult:73]Profile1:17:=[WOdraw:68]ItemNum:2
				[TallyResult:73]Profile2:18:="Materials"
			End if 
			[TallyResult:73]Real1:13:=$theChange
			[TallyResult:73]Real2:14:=$theCost
			SAVE RECORD:C53([TallyResult:73])
		End while 
		UNLOAD RECORD:C212([TallyResult:73])
	End if 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	
End if 