//%attributes = {"publishedWeb":true}
//Method: Item_PopupValues
C_TEXT:C284($1; $arrayName)
C_POINTER:C301($2; $3; $4)
READ ONLY:C145([PopUp:23])
//TRACE
If ($1#"")
	QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3=$1)
	If (Records in selection:C76([PopUp:23])=1)
		$2->:=[PopUp:23]listName:4  //vItemsProfile4  
		QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=[PopUp:23]arrayName:3)
		$k:=Records in selection:C76([PopupChoice:134])
		ARRAY TEXT:C222($3->; 0)
		FIRST RECORD:C50([PopupChoice:134])
		For ($i; 1; $k)
			$w:=Find in array:C230($3->; [PopupChoice:134]choice:3)
			If ($w=-1)
				$w:=Size of array:C274($3->)+1
				INSERT IN ARRAY:C227($3->; $w)
				$3->{$w}:=[PopupChoice:134]choice:3
			End if 
			NEXT RECORD:C51([PopupChoice:134])
		End for 
		INSERT IN ARRAY:C227($3->; 1; 1)
		$3->{1}:=$1
	Else 
		COPY ARRAY:C226($4->; $3->)
		$2->:=$4->{1}
	End if 
Else 
	COPY ARRAY:C226($4->; $3->)
	$2->:=$4->{1}
End if 
READ ONLY:C145([PopUp:23])
UNLOAD RECORD:C212([PopUp:23])