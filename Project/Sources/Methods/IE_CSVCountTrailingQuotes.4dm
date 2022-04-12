//%attributes = {"publishedWeb":true}
//Method: IE_CSVCountTrailingQuotes
//Noah Dykoski 20000107
C_LONGINT:C283($0)  //Number of "'s at the end of the test string
C_TEXT:C284($1; $testStr)
$testStr:=$1

C_LONGINT:C283($index)
$index:=Length:C16($testStr)
$0:=0
C_BOOLEAN:C305($notDone)
$notDone:=True:C214
While ($notDone)
	If ($index>1)  //don't count initial quote
		If ($testStr[[$index]]=Char:C90(34))
			$0:=$0+1
		Else 
			$notDone:=False:C215
		End if 
	Else 
		$notDone:=False:C215
	End if 
	$index:=$index-1
End while 