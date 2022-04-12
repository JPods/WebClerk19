//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/10/12, 11:26:17
// ----------------------------------------------------
// Method: Find Ship Zone
// Description
// 
//
// Parameters
// $1 = zip $2 = zone $3 = ShipVia $4 = Country $5 = siteID
// ----------------------------------------------------
//  ### jwm ### 20140612_1317 updated to allow zone by country to have empty zip code
// returns -1 if Zone By country and country empty
// returns -1 if Zone By zip and zip empty
// ### jwm ### 20150603_1153 test parameter count first

C_POINTER:C301($1; $2; $3; $4; $5)
C_TEXT:C284($shipZip; $shipVia; $shipCountry; $siteID)
C_LONGINT:C283($shipZone)
If (Count parameters:C259>4)
	$shipZip:=$1->
	$shipZone:=$2->
	$shipVia:=$3->
	$shipCountry:=$4->
	$siteID:=$5->
	
	If (($shipVia="") | (($shipZip="") & ($shipCountry="")))  // shipVia = "" or ( zip = "" & country = "")  //  ### jwm ### 20140612_1317
		If ($shipVia="")
			If (Count parameters:C259<4)
				$shipZone:=-1
				If (allowAlerts_boo)
					BEEP:C151
				End if 
			Else 
				$shipZone:=-1
				If (allowAlerts_boo)
					BEEP:C151
				End if 
			End if 
		End if 
	Else 
		READ ONLY:C145([Carrier:11])
		QUERY:C277([Carrier:11]; [Carrier:11]active:6=True:C214; *)
		QUERY:C277([Carrier:11];  & [Carrier:11]carrierid:10=$shipVia)
		If (Records in selection:C76([Carrier:11])=1)
			
			If (([Carrier:11]zoneByCountry:46) & (Count parameters:C259>3))
				If ($shipCountry#"")
					$ShipZip:=Substring:C12($shipCountry; 1; [Carrier:11]zipLength:19)
				Else 
					$shipZone:=-1  //  ### jwm ### 20140612_1317
				End if 
			Else 
				If ($shipZip#"")
					$ShipZip:=Substring:C12($shipZip; 1; [Carrier:11]zipLength:19)
				Else 
					$shipZone:=-1  //  ### jwm ### 20140612_1317
				End if 
			End if 
			
			C_LONGINT:C283($i; $k)
			$i:=0
			QUERY:C277([CarrierZone:143]; [CarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44; *)
			
			If (Count parameters:C259>4)  // ### jwm ### 20150603_1153 test parameter count first
				If ($siteID#"")  //  ### jwm ### 20140603_2318 test for siteID
					//QUERY([CarrierZone];[CarrierZone]siteID=[Carrier]siteID;*)
					QUERY:C277([CarrierZone:143]; [CarrierZone:143]siteID:8=$siteID; *)  // ### jwm ### 20160307_1425 there can be multiple zone siteID's for each Carrier
				End if 
			End if 
			
			QUERY:C277([CarrierZone:143])
			ORDER BY:C49([CarrierZone:143]; [CarrierZone:143]zipLow:1; >)  //### jwm ### 20120110_1126 Make sure that zone records are sorted in ascending order
			FIRST RECORD:C50([CarrierZone:143])
			$k:=Records in selection:C76([CarrierZone:143])
			While ($i<$k)
				$i:=$i+1
				Case of 
					: (($ShipZip>=[CarrierZone:143]zipLow:1) & ($ShipZip<=[CarrierZone:143]zipHigh:2))
						$shipZone:=[CarrierZone:143]zone:3
						$i:=$k
					: ($i=$k)
						$shipZone:=-1
						If (allowAlerts_boo)
							//MESSAGE("No approved Zone for "+$shipVia+" and Zip Code "+$shipZip+".")
						End if 
				End case 
				NEXT RECORD:C51([CarrierZone:143])
			End while 
			REDUCE SELECTION:C351([Carrier:11]; 0)
		Else 
			If (Count parameters:C259<4)
				If (allowAlerts_boo)
					//ALERT("There is no approved Carrier Record for "+$shipVia+".")
				End if 
			End if 
			$shipZone:=-1
		End if 
		READ WRITE:C146([Carrier:11])
	End if 
	vMod:=True:C214
	$2->:=$shipZone
End if 

