//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/31/21, 16:02:33
// ----------------------------------------------------
// Method: GoogleMap_ChooseReturnAddress
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_COLLECTION:C1488($1; $vcChoices)
$vcChoices:=$1
C_OBJECT:C1216($0; $voResult)
$0:=New object:C1471
C_OBJECT:C1216($voChoice)
C_LONGINT:C283($viTotal; $viCount)
C_BOOLEAN:C305($vbContinue)
$vbContinue:=True:C214
$viCount:=0
$viTotal:=$vcChoices.length
For each ($voChoice; $vcChoices) While ($vbContinue)
	$viCount:=$viCount+1
	CONFIRM:C162("Choice "+String:C10($viCount)+" of "+String:C10($viTotal)+": "+$voChoice.formatted_address)
	If (OK=1)
		$voResult:=$voChoice.geometry.location
		$0:=$voResult
		$vbContinue:=False:C215
	End if 
End for each 
