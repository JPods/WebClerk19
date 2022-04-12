//%attributes = {"publishedWeb":true}
ORDER BY:C49([Time:56]; [Time:56]nameid:1; [Time:56]orderNum:3)
FIRST RECORD:C50([Time:56])
C_REAL:C285($theChange)
C_LONGINT:C283($i; $k; $rayCnt; $inc)
vText1:=[Time:56]nameid:1
$i:=0
$k:=Records in selection:C76([Time:56])
ARRAY TEXT:C222(aTmp25Str1; 0)
ARRAY TEXT:C222(aTmp20Str1; 0)
ARRAY LONGINT:C221(aTmpLong1; 0)
ARRAY REAL:C219(aTmpReal1; 0)
ARRAY REAL:C219(aTmpReal2; 0)
vR9:=0
vR10:=0
While ((vText1=[Time:56]nameid:1) & ($i<$k))
	$rayCnt:=Size of array:C274(aTmp25Str1)+1
	INSERT IN ARRAY:C227(aTmp25Str1; $rayCnt; 1)
	INSERT IN ARRAY:C227(aTmp20Str1; $rayCnt; 1)
	INSERT IN ARRAY:C227(aTmpLong1; $rayCnt; 1)
	INSERT IN ARRAY:C227(aTmpReal1; $rayCnt; 1)
	INSERT IN ARRAY:C227(aTmpReal2; $rayCnt; 1)
	aTmp25Str1{$rayCnt}:=[Time:56]nameid:1
	aTmp20Str1{$rayCnt}:=[Time:56]activity:10
	aTmpLong1{$rayCnt}:=[Time:56]orderNum:3
	Repeat 
		$i:=$i+1
		$theChange:=Round:C94((([Time:56]lapseTime:8/3600)*([Time:56]perCentActive:18*0.01)); 2)
		aTmpReal1{$rayCnt}:=aTmpReal1{$rayCnt}+$theChange
		aTmpReal2{$rayCnt}:=aTmpReal2{$rayCnt}+Round:C94(($theChange*[Time:56]rate:9); 2)
		NEXT RECORD:C51([Time:56])
	Until ((aTmpLong1{$rayCnt}#[Time:56]orderNum:3) | ($i=$k) | (vText1#[Time:56]nameid:1))
	vText1:=[Time:56]nameid:1
End while 
TRACE:C157
$k:=Size of array:C274(aTmp25Str1)
ARRAY LONGINT:C221(aTmpLong2; $k)
ARRAY LONGINT:C221(aTmpLong3; $k)
C_LONGINT:C283($startElem; $endElem; $inc)
$i:=0
While ($i<$k)
	$startElem:=$i+1
	$theName:=aTmp25Str1{$startElem}
	$totalHrs:=0
	$totalDol:=0
	$endLoop:=False:C215
	Repeat 
		$i:=$i+1
		$totalHrs:=$totalHrs+aTmpReal1{$i}
		$totalDol:=$totalDol+aTmpReal2{$i}
		$endElem:=$i
		If ($i=$k)
			$endLoop:=True:C214
		Else 
			$endLoop:=($theName#aTmp25Str1{$i+1})
		End if 
	Until (($i>=$k) | ($endLoop))
	For ($inc; $startElem; $endElem)
		If ($totalHrs=0)
			aTmpLong2{$inc}:=0
		Else 
			aTmpLong2{$inc}:=Round:C94(100*aTmpReal1{$inc}/$totalHrs; 0)
		End if 
		If ($totalDol=0)
			aTmpLong3{$inc}:=0
		Else 
			aTmpLong3{$inc}:=Round:C94(100*aTmpReal2{$inc}/$totalDol; 0)
		End if 
	End for 
	vR9:=vR9+$totalHrs
	vR10:=vR10+$totalDol
End while 