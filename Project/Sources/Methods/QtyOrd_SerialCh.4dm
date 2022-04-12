//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)  //$1; $2
Case of 
	: ($1->>1)
		BEEP:C151
		$2->:=1
		$1->:=1
	: ($1-><-1)
		$2->:=-1
		$1->:=-1
		BEEP:C151
	Else 
		$2->:=0
		$1->:=0
End case 