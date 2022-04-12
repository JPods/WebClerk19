//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($2)

$what2do:=$1
$params:=$2

Case of 
	: ($what2do="UpdateQuerySubform")
		Form:C1466.queryString:=""
		POST KEY:C465(Tab:K15:37)
		
	: ($what2do="???")
		
End case 