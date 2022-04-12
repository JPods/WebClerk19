//%attributes = {}

// ### bj ### 20210221_1509
// JUNK keep for 1 month to see it useful
C_TEXT:C284($vtWorking; $vtComplete; $vtLine; $vtLineOut; $vt2222)
TRACE:C157
$vtWorking:=Get text from pasteboard:C524
C_COLLECTION:C1488($cLines; $cLinesOut)
C_LONGINT:C283($viFindQuote)
$cLines:=New collection:C1472
$cLinesOut:=New collection:C1472
$cLines:=Split string:C1554($vtWorking; "\n")

For each ($vtLine; $cLines)
	$viFindQuote:=Position:C15("\""; $vtLine)
	If ($viFindQuote>1)
		$vtLineOut:=Substring:C12($vtLine; 1; $viFindQuote)
		$vtLineOut:=$vtLineOut+Lowercase:C14($vtLine[[$viFindQuote+1]])
		$vtLineOut:=$vtLineOut+Substring:C12($vtLine; $viFindQuote+2)
	Else 
		$vtLineOut:=$vtLine
	End if 
	$vtLineOut:=Replace string:C233($vtLineOut; "userUUIDKey"; "idUser")
	$vtLineOut:=Replace string:C233($vtLineOut; "\"dt"; "\"dt")
	$vtLineOut:=Replace string:C233($vtLineOut; "\"fob"; "\"fob")
	$vtLineOut:=Replace string:C233($vtLineOut; "\"fax"; "\"fax")
	$vtLineOut:=Replace string:C233($vtLineOut; "id\":"; "id\":")
	$vtLineOut:=Replace string:C233($vtLineOut; "uniqueid"; "idNum")
	$vtLineOut:=Replace string:C233($vtLineOut; "sequence"; "seq")
	$vtLineOut:=Replace string:C233($vtLineOut; "UUIDKey"; "id")
	$cLinesOut.push($vtLineOut)
End for each 
$vt2222:=$cLinesOut.join("\n")
SET TEXT TO PASTEBOARD:C523($vt2222)