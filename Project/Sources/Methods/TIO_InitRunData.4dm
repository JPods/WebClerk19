//%attributes = {"publishedWeb":true}
//Procedure: TIO_InitRunData
C_LONGINT:C283($soa)
$soa:=Size of array:C274(aTIOTypeCd)
ARRAY LONGINT:C221(aTIOTyRData; $soa)  //runtime data, temp copies of data like loop iterators
C_LONGINT:C283($index)
For ($index; 1; $soa)
	aTIOTyRData{$index}:=-1
End for 