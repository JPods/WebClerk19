//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/04/18, 18:16:37
// ----------------------------------------------------
// Method: WC_Returnlatlng
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $address)
C_OBJECT:C1216($0; $voResult)
C_OBJECT:C1216($voSynRecRelate)
$address:=$1
$voSynRecRelate:=New object:C1471
$voSynRecRelate:=RP_SyncRelateFillVars("maps.googleapis.com")
$path:=HTTP_HOST+HTTP_Path+Replace string:C233($address; " "; "+")+"&key="+HTTP_APIKey
C_LONGINT:C283($viSocket)
$viSocket:=WC_RequestReceive("GET"; $path)
C_OBJECT:C1216($voLatLng; $voReturn)
C_TEXT:C284($vtReply)
If (voState.request.parameters.results.length=0)
	$voResult:=New object:C1471
Else 
	C_LONGINT:C283($viInc; $viCnt)
	$viCnt:=voState.request.parameters.results.length
	C_COLLECTION:C1488($vcList)
	$vcList:=voState.request.parameters.results
	If ($viCnt>1)
		$voResult:=GoogleMap_ChooseReturnAddress(voState.request.parameters.results)
	Else 
		$voResult:=$vcList[0].geometry.location
		// $result:=voState.request.parameters.results
	End if 
End if 
$0:=$voResult

//WC_Request("GET")
