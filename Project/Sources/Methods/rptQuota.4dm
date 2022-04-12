//%attributes = {"publishedWeb":true}
//Procedure: rptQuota
//October 25, 1995
If (False:C215)
	//02/03/03.prf  
	//moved method ThermoInitExit to fix hang when $k=0
	VERSION_9919_VAN
	VERSION_9919
End if 
C_LONGINT:C283($Mon; $Yr; $i; $k)
C_REAL:C285($Total; $Cost)
vdDateBeg:=Current date:C33-30
vdDateEnd:=Current date:C33
vComName:=""
vDiaCom:="Performance will be prepared for All unless you select One below:"
v1:=""
COPY ARRAY:C226(<>aReps; aComNames)
jCenterWindow(218; 264; 1)
DIALOG:C40([Rep:8]; "DiaRptRepCom")
CLOSE WINDOW:C154
vDiaCom:=""
If (OK=1)
	QUERY:C277([Order:3]; [Order:3]dateDocument:4>=vdDateBeg; *)
	QUERY:C277([Order:3];  & [Order:3]dateDocument:4<=vdDateEnd)
	If (Length:C16(vComName)#0)
		QUERY SELECTION:C341([Order:3]; [Order:3]repID:8=vComName)
	End if 
	$k:=Records in selection:C76([Order:3])
	//ThermoInitExit ("Updating Items";$k;True)  //02/03/03.prf  
	If ($k>0)
		//ThermoInitExit ("Updating Items";$k;True)  //02/03/03.prf     
		$viProgressID:=Progress New
		ORDER BY:C49([Order:3]; [Order:3]repID:8; >; [Order:3]dateDocument:4; >)
		FIRST RECORD:C50([Order:3])
		$Rep:=[Order:3]repID:8
		While (($Rep=[Order:3]repID:8) & (Month of:C24([Order:3]dateDocument:4)#0))
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Updating Items")
			If (<>ThermoAbort)
				$Rep:="4234234fgdfg"
			End if 
			$Mon:=Month of:C24([Order:3]dateDocument:4)
			$Yr:=Year of:C25([Order:3]dateDocument:4)
			$Period:=Date:C102(String:C10($Mon)+"/1/"+String:C10($Yr))
			$Total:=0
			$Cost:=0
			$Comm:=0
			While (($Mon=Month of:C24([Order:3]dateDocument:4)) & ($Yr=Year of:C25([Order:3]dateDocument:4)) & (Month of:C24([Order:3]dateDocument:4)#0))
				$i:=$i+1
				$Total:=$Total+[Order:3]amount:24
				$Cost:=$Cost+[Order:3]totalCost:42
				$Comm:=$Comm+([Order:3]amount:24*[Order:3]repCommission:9*0.01)
				NEXT RECORD:C51([Order:3])
			End while 
			QUERY:C277([Quota:9]; [Quota:9]repID:1=$Rep; *)
			QUERY:C277([Quota:9];  & [Quota:9]period:3=$Period)
			If (Records in selection:C76([Quota:9])=0)
				CREATE RECORD:C68([Quota:9])
				
				[Quota:9]period:3:=$Period
				[Quota:9]repID:1:=$Rep
			End if 
			[Quota:9]orderActual:5:=$Total
			[Quota:9]orderMargin:6:=$Cost
			[Quota:9]comOrders:8:=$Comm
			[Quota:9]calculatedOn:10:=Current date:C33
			[Quota:9]calculatedAt:11:=Current time:C178
			SAVE RECORD:C53([Quota:9])
			$Rep:=[Order:3]repID:8
		End while 
		//Thermo_Close 
		Progress QUIT($viProgressID)
	End if 
	If ((ptCurTable=(->[Rep:8])) & (vHere>1))
		QUERY:C277([Quota:9]; [Quota:9]repID:1=[Rep:8]RepID:1)
	End if 
End if 