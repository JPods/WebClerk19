//%attributes = {}
QuoteQuick
$found:=Prs_CheckRunnin("QuickQuote")
If ($found>0)
	POST OUTSIDE CALL:C329(<>aPrsNum{$found})
	
End if 
//