//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/05/14, 15:46:55
// ----------------------------------------------------
// Method: FindShipZoneSite
// Description
// 
//
// Parameters
// ----------------------------------------------------

//[Invoice]Zone:=FindShipZoneSite ([Invoice]Zip;[Invoice]ShipVia;[Invoice]Country;[Invoice]siteID)

//Find Ship Zone

C_TEXT:C284($siteID; $zipCode; $shipVia; $shipCountry)
C_LONGINT:C283($shipZone)
C_TEXT:C284($shipZip)

$shipZone:=-1  // default return value

$shipZip:=""
$shipVia:=""
$shipCountry:=""
$siteID:=""
If (Count parameters:C259>0)
	$shipZip:=$1
	If (Count parameters:C259>1)
		$shipVia:=$2
		If (Count parameters:C259>2)
			$shipCountry:=$3
			If (Count parameters:C259>3)
				$siteID:=$4
			End if 
		End if 
	End if 
End if 

If (($shipVia#"") & ($shipZip#""))
	READ ONLY:C145([Carrier:11])
	READ ONLY:C145([CarrierZone:143])
	QUERY:C277([Carrier:11]; [Carrier:11]active:6=True:C214; *)
	QUERY:C277([Carrier:11];  & [Carrier:11]carrierid:10=$shipVia)
	If (Records in selection:C76([Carrier:11])=1)
		
		// if zip length <= 0 use Country
		If ([Carrier:11]zipLength:19>0)
			$ShipZip:=Substring:C12($shipZip; 1; [Carrier:11]zipLength:19)
		Else 
			$ShipZip:=$shipCountry  // lookup zone by Country
		End if 
		
		C_LONGINT:C283($i; $k)
		$i:=0
		
		QUERY:C277([CarrierZone:143]; [CarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44; *)
		If ($shipCountry#"")
			QUERY:C277([CarrierZone:143];  & ; [CarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44; *)
		End if 
		If ($siteID#"")
			QUERY:C277([CarrierZone:143];  & ; [CarrierZone:143]siteid:8=$siteID; *)  // search using siteID  (Both blank will match)
		End if 
		QUERY:C277([CarrierZone:143];  & ; [CarrierZone:143]zipLow:1<=$ShipZip; *)
		QUERY:C277([CarrierZone:143];  & ; [CarrierZone:143]zipHigh:2>=$ShipZip; *)
		QUERY:C277([CarrierZone:143])
		
		
		Case of 
			: (Records in selection:C76([CarrierZone:143])=1)  // No Zones found
				$shipZone:=[CarrierZone:143]zone:3
				
			: (Records in selection:C76([CarrierZone:143])>1)  // No Zones found
				ORDER BY:C49([CarrierZone:143]; [CarrierZone:143]zipLow:1; >)  //### jwm ### 20120110_1126 Make sure that zone records are sorted in ascending order
				FIRST RECORD:C50([CarrierZone:143])
				$shipZone:=[CarrierZone:143]zone:3
		End case 
	End if 
End if 
vMod:=True:C214
$0:=$shipZone

REDUCE SELECTION:C351([Carrier:11]; 0)
REDUCE SELECTION:C351([CarrierZone:143]; 0)
READ WRITE:C146([Carrier:11])
READ WRITE:C146([CarrierZone:143])
