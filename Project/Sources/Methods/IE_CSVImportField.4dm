//%attributes = {"publishedWeb":true}
//Method: IE_CSVImportField
//Noah Dykoski 20000107
C_TEXT:C284($0)  //imported, de-quoted string
C_TIME:C306($1; $FileRef)
$FileRef:=$1
C_TEXT:C284($2; $ReadToChar)
C_BOOLEAN:C305($StripLF)
C_TIME:C306(vtImportFile)
$StripLF:=False:C215
If (Count parameters:C259>=2)
	If ($2=(Storage:C1525.char.crlf))
		$ReadToChar:="\r"
		$StripLF:=True:C214
	Else 
		$ReadToChar:=$2
	End if 
Else 
	$ReadToChar:=","
End if 

C_TEXT:C284($InStr; $tempStr)
C_LONGINT:C283($OK; myOK)
RECEIVE PACKET:C104($FileRef; $InStr; $ReadToChar[[1]])
If (OK=1)
	C_LONGINT:C283($trailQuotes)
	$trailQuotes:=IE_CSVCountTrailingQuotes($InStr)
	$OK:=1
	While (($OK>0) & ($InStr[[1]]=Char:C90(34)) & ((($trailQuotes\2)*2=$trailQuotes)))  //Starts with a Quote, ends w/ even number of quotes
		RECEIVE PACKET:C104($FileRef; $tempStr; $ReadToChar[[1]])
		$OK:=OK
		$InStr:=$InStr+$ReadToChar[[1]]+$tempStr
		$trailQuotes:=IE_CSVCountTrailingQuotes($InStr)
	End while 
	
	If (($InStr[[1]]=Char:C90(34)) & ($InStr[[Length:C16($InStr)]]=Char:C90(34)))
		$InStr:=Substring:C12($InStr; 2)  //Strip start quote
		$InStr:=Substring:C12($InStr; 1; Length:C16($InStr)-1)  //Strip end quote
		$0:=Replace string:C233($InStr; Char:C90(34)+Char:C90(34); Char:C90(34))  //undouble doubled quotes
	Else 
		$0:=$InStr
	End if 
	If ($StripLF)
		C_TEXT:C284($Dump)
		RECEIVE PACKET:C104(vtImportFile; $Dump; "\n")  //Should be only this one character
	End if 
	myOK:=$OK
Else 
	$0:=""
	myOK:=0
End if 