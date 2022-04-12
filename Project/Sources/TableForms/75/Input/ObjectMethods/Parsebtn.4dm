
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/19/18, 21:04:55
// ----------------------------------------------------
// Method: [EventLog].Input.Parsebtn
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($working)
ARRAY TEXT:C222($atWorking; 0)
ARRAY TEXT:C222($atSummary; 0)
ARRAY LONGINT:C221($atCounts; 0)
C_LONGINT:C283($i; $k; $cntsummary)

TextToArray([EventLog:75]WCLog:27; ->$atworking; <>vCR; False:C215)
SORT ARRAY:C229($atworking)
$k:=Size of array:C274($atworking)
For ($i; $k; 2; -1)
	If ($atworking{$i}=$atworking{$i-1})
		$atCounts{$cntsummary}:=$atCounts{$cntsummary}+1
	Else 
		APPEND TO ARRAY:C911($atSummary; $atworking{$i-1})
		APPEND TO ARRAY:C911($atCounts; 1)
		$cntsummary:=Size of array:C274($atCounts)
	End if 
End for 
$k:=Size of array:C274($atSummary)
For ($i; 1; $k)
	$working:=$working+$atSummary{$i}+<>vTab+"     "+<>vTab+String:C10($atCounts{$i})+<>vCR
End for 
ALERT:C41("Summary is on clipboard.")
SET TEXT TO PASTEBOARD:C523($working)