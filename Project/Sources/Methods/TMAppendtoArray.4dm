//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/04/18, 14:28:13
// ----------------------------------------------------
// Method: TMAppendtoArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $purposeTM)
C_POINTER:C301($2; $ptArray)
C_LONGINT:C283(viTallyMasterArrayElement)
$purposeTM:=$1
$ptArray:=$2
APPEND TO ARRAY:C911($ptArray->; "----[TallyMaster]----")
viTallyMasterArrayElement:=Size of array:C274($ptArray->)
$0:=viTallyMasterArrayElement
If ($purposeTM#"")
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3=$purposeTM)
	//  QUERY([TallyMaster]; | ;[TallyMaster]tab=$purposeTM)
	C_LONGINT:C283($i; $k; $element)
	$k:=Records in selection:C76([TallyMaster:60])
	If ($k>0)
		ORDER BY:C49([TallyMaster:60]; [TallyMaster:60]Name:8)
		FIRST RECORD:C50([TallyMaster:60])
		For ($i; 1; $k)
			APPEND TO ARRAY:C911($ptArray->; [TallyMaster:60]Name:8)
			NEXT RECORD:C51([TallyMaster:60])
		End for 
	End if 
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
End if 