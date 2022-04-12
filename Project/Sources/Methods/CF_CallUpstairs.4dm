//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($2;$3)

$what2do:=$1

Case of 
	: ($what2do="UpdateList")
		Form:C1466.displayedSelection:=$2
		
	: ($what2do="doSearch")
		$event:=$2
		$params:=$3
		Form:C1466.queryTable.doQuickSearch($event;$params)
End case 