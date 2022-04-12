//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_TEXT:C284($0)
//
$0:=Replace string:C233($1->; "File("; "Table(")
$0:=Replace string:C233($0; "Search Selection("; "Query Selection(")
$0:=Replace string:C233($0; "Search("; "Query(")
$0:=Replace string:C233($0; "Sort Selection("; "Order By(")
$0:=Replace string:C233($0; ""; "->")