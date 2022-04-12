//%attributes = {"publishedWeb":true}
C_REAL:C285($0; $1; $2)
//$1 allowable change, $2 actual change
Case of 
	: ($2=0)
		$0:=0
	: (($2<0) & ($1<0) & ($2>=$1))  //both less than 0, change is less or equal to base (-)
		$0:=$2
	: (($2<0) & ($1<0) & ($2<$1))  //both less than 0, change is greater than base (-)
		$0:=$1
	: ($1=$2)
		$0:=$2
	: ($1>$2)
		$0:=$2
	: ($1<$2)
		$0:=$1
	Else 
		$0:=0
End case 