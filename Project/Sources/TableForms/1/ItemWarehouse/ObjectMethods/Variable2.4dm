ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY LONGINT:C221($aUniqIds; 0)
//  CHOPPED  $error:=AL_GetSelect(eItemWarehouse; aRecvRecs)
$cntRec:=Size of array:C274(aRecvRecs)
If ($cntRec>0)
	//get the uniqueIDs for the selected rows
	$cntRec:=Size of array:C274(aRecvRecs)
	For ($incRec; 1; $cntRec)
		//  CHOPPED  AL_GetCellValue(eItemWarehouse; aRecvRecs{$incRec}; 8; $tData)
		INSERT IN ARRAY:C227($aUniqIds; 1; 1)
		$aUniqIds{1}:=Num:C11($tData)
	End for 
	ARRAY LONGINT:C221(<>aLongInt1; 0)
	COPY ARRAY:C226($aUniqIds; <>aLongInt1)
	vText1:="jSetFromArray (->[ItemWarehouse];-><>aLongInt1;0;->[ItemWarehouse]UniqueID)"
	ProcessTableOpen(Table:C252(->[ItemWarehouse:117]); vText1; ""; ->[ItemWarehouse:117])
End if 