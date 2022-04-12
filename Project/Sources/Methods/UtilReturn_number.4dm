//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/06/12, 14:48:09
// ----------------------------------------------------
// Method: UtilReturn_number
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $isReal; $response; $resultFixed)  //2914-5704
C_LONGINT:C283($incResponse; $incStart; $lenResponse)
$response:=""  //18.12-32"
$isReal:=""
If (Count parameters:C259>0)
	$response:=$1
	If (Count parameters:C259>1)
		$isReal:=$2
	End if 
End if 
C_REAL:C285($0)
C_TEXT:C284($resultFixed)
C_LONGINT:C283($asciiValue)
$lenResponse:=Length:C16($response)
$incStart:=1
If ($lenResponse>0)
	If (Character code:C91($response[[1]])=45)
		$resultFixed:="-"
		$incStart:=2
	End if 
	For ($incResponse; $incStart; $lenResponse)
		$asciiValue:=Character code:C91($response[[$incResponse]])
		If (($asciiValue>47) & ($asciiValue<58))
			$resultFixed:=$resultFixed+$response[[$incResponse]]
		End if 
		If (($asciiValue=46) & ($isReal="Real"))
			$resultFixed:=$resultFixed+$response[[$incResponse]]
		End if 
	End for 
End if 
$0:=Num:C11($resultFixed)

If (False:C215)
	$0:=Num:C11(Preg Replace("[^0-9.-]"; ""; $1; Regex Multi Line+Regex Ignore Case))
End if 