//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/11/20, 22:19:43
// ----------------------------------------------------
// Method: MapMultiple
// Description
// \\ACFS1\ACTshare\CommerceExpert\
//   \\ACFS1\ACTshare\CommerceExpert\Customers\A10010875
//
// Parameters
// ----------------------------------------------------

//  https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
// & markers=color:blue%7Clabel:S%7C40.702147,-74.015794 & markers=color:green%7Clabel:G%7C40.711614,-74.012318
// & markers=color:red%7Clabel:C%7C40.718217,-73.998284
// &key=YOUR_API_KEY
If (False:C215)  // testing
	ARRAY REAL:C219($aLng; 3)
	ARRAY REAL:C219($aLat; 3)
	$aLng{1}:=40.702147
	$aLat{1}:=-74.015794
	
	$aLng{2}:=40.711614
	$aLat{2}:=-74.012318
	
	$aLng{3}:=40.718217
	$aLat{3}:=-73.998284
Else 
	ARRAY REAL:C219($aLng; 0)
	ARRAY REAL:C219($aLat; 0)
	C_POINTER:C301($1; $2)
	COPY ARRAY:C226($1->; $aLat)
	COPY ARRAY:C226($2->; $aLng)
End if 
C_LONGINT:C283($i; $k)
C_TEXT:C284($vtMarkers; $vtKey)
$k:=Size of array:C274($aLat)
C_REAL:C285($vrLat; $vrLng)

READ ONLY:C145([SyncRelation:103])
QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="maps.googleapis.com")
$vtKey:=[SyncRelation:103]pin:40
READ WRITE:C146([SyncRelation:103])
REDUCE SELECTION:C351([SyncRelation:103]; 0)

If ($vtKey="")
	ConsoleLog("There is no [SyncRelation]Pin for maps.googleapis.com")
	$0:="Error, There is no [SyncRelation]Pin for maps.googleapis.com"
Else 
	$vtMarkers:="&zoom=13&size=600x300&maptype=roadmap"
	If (Size of array:C274($aLng)#$k)
		ConsoleLog("Lat and Lng arrays are different sizes")
		$0:="Error, Lat and Lng arrays are different sizes"
	Else 
		For ($i; 1; $k)
			$vrLat:=$vrLat+$aLat{$i}
			$vrLng:=$vrLng+$aLng{$i}
			$vtMarkers:=$vtMarkers+"&markers=color:red%7Clabel:C%7C"+String:C10($aLat{$i})+","+String:C10($aLng{$i})
			
		End for 
		$vrLat:=Round:C94($vrLat/$k; 8)
		$vrLng:=Round:C94($vrLng/$k; 8)
		//
		
		$vtMarkers:="https://maps.googleapis.com/maps/api/staticmap?center="+String:C10($vrLat)+","+String:C10($vrLng)+$vtMarkers
		$vtMarkers:=$vtMarkers+"&key="+$vtKey
		// & key=YOUR_API_KEY
		$0:=$vtMarkers
		
	End if 
End if 