//%attributes = {"publishedWeb":true}
C_LONGINT:C283($subCnt; $2; $5)
C_REAL:C285($3; $4)
C_BOOLEAN:C305($1)
SORT ARRAY:C229(a20Str1; aLongInt1)  // count uses of rate charts
$subCnt:=0
Repeat 
	$subCnt:=$subCnt+1
	If ($1)
		prntQtyShip:=Num:C11($subCnt=1)*"Total"
		//    prntKeyNum:=String(aLongInt3{$subCnt})
		prntKeyNum:=String:C10(aLongInt5{$subCnt})
		prntFrght:=""
		prntTotal:=""
	Else 
		prntQtyShip:=Num:C11($subCnt=1)*"SubTotal"
		prntKeyNum:=String:C10(aLongInt5{$subCnt})
		prntFrght:=String:C10($3)
		prntTotal:=String:C10($4; <>tcFormatTt)
	End if 
	shipTo:=a20Str1{$subCnt}
	prntAcct:=""
	prntItemNum:=""
	prntExt:=""
	v2:=""
	v3:=""
	v4:=""
	v5:=""
	v6:=""
	Print form:C5([QQQCarrier:11]; "Manifest_Totals")
	$2:=$2+1
	aLongInt5{$subCnt}:=0
	If ($5=0)
		$5:=10
	End if 
	If (($2%$5)=0)
		//   PRINT LAYOUT([Order];"Empty_w_Line")
		PAGE BREAK:C6
		Print form:C5([QQQCarrier:11]; "Manifest_header")
	End if 
Until ($subCnt=Size of array:C274(a20Str1))
$0:=$2+1