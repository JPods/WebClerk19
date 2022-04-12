ARRAY LONGINT:C221(aRecvRecs; 0)
ARRAY TEXT:C222($aItemNum; 0)

//  CHOPPED  $error:=AL_GetSelect(eWorkOrders; aRecvRecs)
$cntRec:=Size of array:C274(aRecvRecs)
If ($cntRec>0)
	C_LONGINT:C283($cntRec; $incRec; $woNum; $w)
	$cntRec:=Size of array:C274(aRecvRecs)
	For ($incRec; 1; $cntRec)
		//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{$incRec}; 7; $tData)
		$w:=Find in array:C230($aItemNum; $tData)
		If ($w<1)
			APPEND TO ARRAY:C911($aItemNum; $tData)
		End if 
	End for 
	$cntRec:=Size of array:C274($aItemNum)
	CREATE EMPTY SET:C140([ItemSiteBucket:136]; "Current")
	For ($incRec; 1; $cntRec)
		QUERY:C277([ItemSiteBucket:136]; [ItemSiteBucket:136]itemNum:2=$aItemNum{$incRec})
		CREATE SET:C116([ItemSiteBucket:136]; "ByItem")
		UNION:C120("Current"; "ByItem"; "Current")
		CLEAR SET:C117("ByItem")
	End for 
	UNLOAD RECORD:C212([WorkOrder:66])
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	DB_ShowCurrentSelection(->[ItemSiteBucket:136])
	If (False:C215)
		//get the uniqueIDs for the selected rows
		$cntRec:=Size of array:C274(aRecvRecs)
		For ($incRec; 1; $cntRec)
			//  CHOPPED  AL_GetCellValue(eWorkOrders; aRecvRecs{$incRec}; 2; $tData)
			INSERT IN ARRAY:C227($aUniqIds; 1; 1)
			$aUniqIds{1}:=Num:C11($tData)
		End for 
		ARRAY LONGINT:C221(<>aLongInt1; 0)
		COPY ARRAY:C226($aUniqIds; <>aLongInt1)
		vText1:="jSetFromArray (->[ItemBySite];-><>a;0;->[WorkOrder]ItemNum)"
		ProcessTableOpen(Table:C252(->[WorkOrder:66]); vText1; ""; ->[WorkOrder:66])
		
	End if 
End if 