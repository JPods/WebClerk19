//%attributes = {}
var $1; $lb_name : Text
var $0; $o : Object

$lb_name:=Current method name:C684

Case of 
	: (Form:C1466=Null:C1517)
		
	: (Count parameters:C259=0)
		
	: ($1="init")
		
	: ($1="doSearch")
		
		$o:=Form:C1466[$lb_name]
		$o.search:=Get edited text:C655
		$o.data:=$o.source.query("question = :1"; $o.search+"@").orderBy("question asc")
		
End case 