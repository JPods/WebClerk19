//%attributes = {"publishedWeb":true}
//Method: IE_QuoteCSV
//Noah 20000107
C_TEXT:C284($0)  //Quoted CSV String (only quoted if it contains a " or a , and all original " x2
C_TEXT:C284($1; $OrgString)
$OrgString:=$1

$0:=Replace string:C233($OrgString; Char:C90(34); Char:C90(34)+Char:C90(34))  //double up original quotes
If ((Length:C16($0)#Length:C16($OrgString)) | (Position:C15(","; $OrgString)>0) | (Position:C15("\r"; $OrgString)>0) | (Position:C15("\n"; $OrgString)>0))
	$0:=Char:C90(34)+$0+Char:C90(34)  //quote strings that had quotes or comma's or <CR> or <LF>
End if 