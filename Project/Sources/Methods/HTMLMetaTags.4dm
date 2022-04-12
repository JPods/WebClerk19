//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-03T00:00:00, 00:11:20
// ----------------------------------------------------
// Method: HTML_MetaTags
// Description
// Modified: 05/03/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $returnText)


$returnText:=""
$returnText:=$returnText+"<meta charset="+Txt_Quoted("utf-8")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("viewport")+" content="+Txt_Quoted("th=device-width, initial-scale=1.0")+" />"+"\r"

$returnText:=$returnText+"<meta http-equiv="+Txt_Quoted("Pragma")+" content="+Txt_Quoted("no-cache")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitReason")+" content="+Txt_Quoted("Description of use")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitSecure")+" content="+Txt_Quoted("1")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitFrom")+" content="+Txt_Quoted("_jit_0_jitURLjj")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitTo")+" content="+Txt_Quoted("_jit_0_jitThisPagejj")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("TableName")+" content="+Txt_Quoted("Customer")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitRelate")+" content="+Txt_Quoted("1")+" comment="+Txt_Quoted("0 is no relate, 1 is general, 5 is script")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitRelateScript")+" content="+Txt_Quoted("SomeScript")+" comment="+Txt_Quoted("Optional")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("PriceLiteral")+" content="+Txt_Quoted("true")+" comment="+Txt_Quoted("Optional")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitLineModulo")+" content="+Txt_Quoted("2")+" comment="+Txt_Quoted("For line color styles")+" />"+"\r"
$returnText:=$returnText+"<meta name="+Txt_Quoted("jitSort")+" content="+Txt_Quoted("_jitSort_4_-7jj")+" comment="+Txt_Quoted("Sort Override")+" />"+"\r"

// SET TEXT TO PASTEBOARD($returnText)

QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="HTMLMetaTag")
C_LONGINT:C283($incTM; $cntTM)
$cntTM:=Records in selection:C76([TallyMaster:60])
If ($cntTM>0)
	ORDER BY:C49([TallyMaster:60]; [TallyMaster:60]name:8)
	READ ONLY:C145([TallyMaster:60])
	FIRST RECORD:C50([TallyMaster:60])
	For ($incTM; 1; $cntTM)
		$returnText:=$returnText+[TallyMaster:60]script:9+"\r"
		NEXT RECORD:C51([TallyMaster:60])
	End for 
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
	READ WRITE:C146([TallyMaster:60])
End if 

$0:=$returnText