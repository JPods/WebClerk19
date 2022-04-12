//%attributes = {"publishedWeb":true}
C_LONGINT:C283(bDeleteForm; $num)
C_BOOLEAN:C305($1)
//  aMatchLine
$num:=Size of array:C274(aMatchLine)  //  selected lines
If (Size of array:C274(aMatchType)>=$num)
	For ($i; $num; 1; -1)
		DELETE FROM ARRAY:C228(aMatchField; aMatchLine{$i}; 1)
		DELETE FROM ARRAY:C228(aMatchType; aMatchLine{$i}; 1)
		DELETE FROM ARRAY:C228(aMatchNum; aMatchLine{$i}; 1)
		DELETE FROM ARRAY:C228(aCntMatFlds; aMatchLine{$i}; 1)
	End for 
	aMatchType:=Size of array:C274(aMatchType)
	ARRAY LONGINT:C221(aMatchLine; 0)
	If (Size of array:C274(aMatchType)>0)
		APPEND TO ARRAY:C911(aMatchLine; Size of array:C274(aMatchType))
	End if 
	//
	For ($i; 1; Size of array:C274(aCntMatFlds))
		aCntMatFlds{$i}:=$i
	End for 
	// End if 
	Case of 
		: (Size of array:C274(aMatchType)=0)
			aMatchType:=0
		: (aMatchType=1)
		Else   // : (aMatchType>1)
			aMatchType:=aMatchType-1
	End case 
	
	//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
Else 
	BEEP:C151
	BEEP:C151
End if 