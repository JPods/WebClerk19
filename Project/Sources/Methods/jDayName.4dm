//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_TEXT:C284($0)
Case of 
	: ($1=1)
		$0:="Sun"
	: ($1=2)
		$0:="Mon"
	: ($1=3)
		$0:="Tue"
	: ($1=4)
		$0:="Wed"
	: ($1=5)
		$0:="Thr"
	: ($1=6)
		$0:="Fri"
	: ($1=7)
		$0:="Sat"
End case 