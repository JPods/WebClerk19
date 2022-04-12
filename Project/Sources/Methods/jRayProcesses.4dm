//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i; $k; $skipOne; $setPoint)
$skipOne:=$1
If (((<>aProcesses=0) & ($1=0)) | ((<>aProcesses<2) & ($1=1)))
	ARRAY TEXT:C222(aAttributes; $1)
	ARRAY LONGINT:C221(aAttNums; $1)
	//  array TEXT(aAttCodes;0)
	ARRAY TEXT:C222(aCauses; $1)
	ARRAY LONGINT:C221(aLongInt1; $1)
Else 
	MESSAGES OFF:C175
	QUERY:C277([QQQAttribute:17]; [QQQAttribute:17]ProcessKey:5=<>aProcessNums{<>aProcesses})
	$k:=Records in selection:C76([QQQAttribute:17])+$1
	ARRAY TEXT:C222(aAttributes; $k)
	ARRAY LONGINT:C221(aAttNums; $k)
	//  array TEXT(aAttCodes;0)
	ARRAY LONGINT:C221(aLongInt1; $k)
	FIRST RECORD:C50([QQQAttribute:17])
	$setPoint:=1+$1
	$k:=Records in selection:C76([QQQAttribute:17])+$skipOne
	For ($i; $setPoint; $k)
		aAttributes{$i}:=[QQQAttribute:17]Attribute:2
		//      aAttCodes{$i}:=[Attribute]AttCode
		aAttNums{$i}:=[QQQAttribute:17]idUnique:4
		aLongInt1{$i}:=[QQQAttribute:17]SequenceNum:1
		NEXT RECORD:C51([QQQAttribute:17])
	End for 
	aAttributes:=$1
	UNLOAD RECORD:C212([QQQAttribute:17])
	SORT ARRAY:C229(aLongInt1; aAttNums; aAttributes)
	ARRAY LONGINT:C221(aLongInt1; 0)
	ARRAY TEXT:C222(aCauses; $1)
	viRecordsInTable:=Size of array:C274(aAttributes)
	MESSAGES ON:C181
End if 