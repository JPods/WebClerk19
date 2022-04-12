//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)
C_LONGINT:C283($i; $k)
KeyModifierCurrent
//TRACE
If (OptKey=1)
	$k:=Size of array:C274($2->)
	If ($k>0)
		QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=$1->{$2->{1}}; *)
		QUERY:C277([ItemXRef:22];  & [ItemXRef:22]xRefLinked:17>=0)
		ARRAY TEXT:C222($aItemNum; 0)
		SELECTION TO ARRAY:C260([ItemXRef:22]itemNumXRef:2; $aItemNum)
		REDUCE SELECTION:C351([ItemXRef:22]; 0)
		$k:=Size of array:C274($aItemNum)
		If ($k>0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$aItemNum{1}; *)
			For ($i; 2; $k)
				QUERY:C277([Item:4];  | [Item:4]itemNum:1=$aItemNum{$i}; *)
			End for 
			QUERY:C277([Item:4])
			viRecordsInSelection:=Records in selection:C76([Item:4])
			List_FillOpts(viRecordsInSelection; vUseBase)
			BEEP:C151
			doSearch:=1000
			bMultiSr:=0
		End if 
	End if 
Else 
	If (Size of array:C274($1->)>0)
		$k:=Size of array:C274($2->)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1->{$2->{1}}; *)
		For ($i; 2; $k)
			QUERY:C277([Item:4];  | [Item:4]itemNum:1=$1->{$2->{$i}}; *)
		End for 
		QUERY:C277([Item:4])
		viRecordsInSelection:=Records in selection:C76([Item:4])
		List_FillOpts(viRecordsInSelection; vUseBase)
		BEEP:C151
		doSearch:=1000
		bMultiSr:=0
		////  --  CHOPPED  AL_UpdateArrays (eItemList;Size of array(aItemSrRec))
	End if 
End if 