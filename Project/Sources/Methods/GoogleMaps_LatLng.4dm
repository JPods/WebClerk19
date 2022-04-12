//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/31/21, 00:24:59
// ----------------------------------------------------
// Method: GoogleMaps_LatLng
// Description
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($voSel : Object)
C_OBJECT:C1216($voRec)
C_TEXT:C284($vtaddress)
C_OBJECT:C1216($voResult)
C_LONGINT:C283($viCounter; $viCountRecords)
C_BOOLEAN:C305($vbProgress)
$vbProgress:=False:C215
If ($voSel.length>3)
	
End if 
TRACE:C157
If ($voSel=Null:C1517)
	
Else 
	If ($vbProgress)
		$viProgressID:=Progress New
		Progress SET TITLE($viProgressID; "LatLng: "+String:C10($voSel.length); 0; ("Initializing..."))
		Progress SET BUTTON ENABLED($viProgressID; True:C214)
	End if 
	
	For each ($voRec; $voSel)
		If ($voRec.address1#"")
			$voResult:=New object:C1471
			$vtaddress:=$voRec.address1+((Num:C11($voRec.address2#""))*(", "+$voRec.address2))+", "+$voRec.city+", "+$voRec.state+", "+$voRec.zip+((Num:C11($voRec.country#""))*(", "+$voRec.country))
			//  $vtaddress:=$voRec.address1+", "+$voRec.city+", "+$voRec.state
			
			// https://maps.googleapis.com/maps/api/geocode/json?address=
			//1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyCrWDbG1zAXJI6ii-epujB-0E6kq5CUREw
			
			$vtaddress:=Replace string:C233($vtaddress; " "; "+")
			$voResult:=WC_Returnlatlng($vtaddress)
			$voRec.lat:=$voResult.lat
			$voRec.lng:=$voResult.lng
			$result_o:=$voRec.save()
		End if 
		If ($vbProgress)
			$viCounter:=$viCounter+1
			Progress SET PROGRESS($viProgressID; ($viCounter/$voSel.length); "Currently on record "+String:C10($viCounter)+" out of "+String:C10($voSel.length)+".")
		End if 
	End for each 
	If ($vbProgress)
		Progress QUIT($viProgressID)
	End if 
End if 

