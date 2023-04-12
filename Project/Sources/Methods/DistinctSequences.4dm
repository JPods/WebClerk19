//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/26/18, 13:31:56
// ----------------------------------------------------
// Method: DistinctSequences
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($working)
C_LONGINT:C283($incRay; $cntRay; $lastAdded)
C_POINTER:C301($1; $ptText)

$cntRay:=Size of array:C274(aLDistinct)
If ($cntRay=0)
	$working:="DistinctSequences: aLDistinct is empty. Run ArrayDistinct to get distinct values."
	If (allowAlerts_boo)
		ALERT:C41($working)
	Else 
		ConsoleLog($working)
	End if 
Else 
	SORT ARRAY:C229(aLDistinct)  // redunant, but incase it was used and changed
	$cntRay:=$cntRay-1  // end loop by one
	C_BOOLEAN:C305($reset)
	$reset:=True:C214
	C_LONGINT:C283($lastWritten)
	$lastWritten:=-1
	Repeat 
		$incRay:=$incRay+1
		If ((aLDistinct{$incRay}+1)=aLDistinct{$incRay+1})
			// sequential
			If ($lastWritten<aLDistinct{$incRay})
				$working:=$working+String:C10(aLDistinct{$incRay})+":"  // set the next beginning
			End if 
			$lastWritten:=aLDistinct{$incRay+1}
		Else 
			$working:=$working+String:C10(aLDistinct{$incRay})+"\r"  // set the end of  a sequence
			//$working:=$working+String(aLDistinct{$incRay+1})+":"  // set the next beginning
		End if 
	Until ($incRay=$cntRay)  // do to one from end
	$working:=$working+String:C10(aLDistinct{Size of array:C274(aLDistinct)})
End if 
If (Count parameters:C259=1)
	$1->:=$working
	//  SET TEXT TO PASTEBOARD($working)
Else 
	SET TEXT TO PASTEBOARD:C523($working)
End if 
