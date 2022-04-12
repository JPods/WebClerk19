//%attributes = {"publishedWeb":true}
//Method: Txt_Hex2Normal
C_TEXT:C284($1; $0; $workText)
C_BOOLEAN:C305($doOut)
$doOut:=False:C215
If (Count parameters:C259=0)
	CONFIRM:C162("Convert text on clipboard")
	If (OK=1)
		$workText:=Get text from pasteboard:C524
	End if 
Else 
	$workText:=$1
	$doOut:=True:C214
End if 
If (OK=1)
	$workText:=Replace string:C233($workText; "%20"; " ")
	$workText:=Replace string:C233($workText; "%21"; "!")
	//
	$workText:=Replace string:C233($workText; "%26"; "&")
	$workText:=Replace string:C233($workText; "%3A"; ":")
	$workText:=Replace string:C233($workText; "%3B"; ";")
	$workText:=Replace string:C233($workText; "%3D"; "=")
	$workText:=Replace string:C233($workText; "%3F"; "?")
	//
	$workText:=Replace string:C233($workText; "%7B"; "{")
	$workText:=Replace string:C233($workText; "%7D"; "}")
	If ($doOut)
		$0:=$workText
	Else 
		SET TEXT TO PASTEBOARD:C523($workText)
	End if 
End if 