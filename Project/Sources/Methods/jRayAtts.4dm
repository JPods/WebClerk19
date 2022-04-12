//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i; $k; $skipOne; $setPoint)
$skipOne:=$1
Case of 
	: (((aAttributes=0) & ($1=0)) | ((aAttributes<2) & ($1=1)))
		ARRAY TEXT:C222(aCauses; $1)
		ARRAY LONGINT:C221(aCauseNums; $1)
	Else 
		MESSAGES OFF:C175
		QUERY:C277([QQQCause:18]; [QQQCause:18]AttributeKey:4=aAttNums{aAttributes})
		$k:=Records in selection:C76([QQQCause:18])+$1
		ARRAY TEXT:C222(aCauses; $k)
		ARRAY LONGINT:C221(aCauseNums; $k)
		ARRAY LONGINT:C221(aLongInt1; $k)
		FIRST RECORD:C50([QQQCause:18])
		$skipOne:=Num:C11($1=1)*1
		$setPoint:=1+$skipOne
		$k:=Records in selection:C76([QQQCause:18])+$skipOne
		For ($i; $setPoint; $k)
			aCauses{$i}:=[QQQCause:18]Cause:2
			aCauseNums{$i}:=[QQQCause:18]CauseNum:5
			aLongInt1{$i}:=[QQQCause:18]SequenceNum:1
			NEXT RECORD:C51([QQQCause:18])
		End for 
		aCauses:=$1
		UNLOAD RECORD:C212([QQQCause:18])
		SORT ARRAY:C229(aLongInt1; aCauses; aCauseNums)
		ARRAY LONGINT:C221(aLongInt1; 0)
		viRecordsInTable:=Size of array:C274(aCauses)
		MESSAGES ON:C181
End case 