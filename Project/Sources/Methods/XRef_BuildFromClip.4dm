//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XRef_BuildFromClip
	//Date: 12/11/04
	//Who: Bill
	//Description: 
End if 
CONFIRM:C162("Create XRefs from Clipboard for Item "+[Item:4]itemNum:1+"?")
If (OK=1)
	$masterRecNum:=Record number:C243([Item:4])
	ARRAY LONGINT:C221(<>aLsSrRec; 0)
	ARRAY LONGINT:C221(<>aItemLines; 0)
	$myText:=Get text from pasteboard:C524
	If ($myText#"")
		TextToArray($myText; ->aText1; "\r"; False:C215)
		$k:=Size of array:C274(aText1)
		If ($k>0)
			For ($i; 1; $k)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aText1{$i})
				If (Records in selection:C76([Item:4])=1)
					$w:=Size of array:C274(<>aLsSrRec)+1
					INSERT IN ARRAY:C227(<>aLsSrRec; $w)
					<>aLsSrRec{$w}:=Record number:C243([Item:4])
					INSERT IN ARRAY:C227(<>aItemLines; $w)
					<>aItemLines{$w}:=$w
				Else 
					CONFIRM:C162("Create item num "+aText1{$i})
					If (OK=1)
						CREATE RECORD:C68([Item:4])
						[Item:4]itemNum:1:=aText1{$i}
						[Item:4]description:7:=aText1{$i}
						SAVE RECORD:C53([Item:4])
						$w:=Size of array:C274(<>aLsSrRec)+1
						INSERT IN ARRAY:C227(<>aLsSrRec; $w)
						<>aLsSrRec{$w}:=Record number:C243([Item:4])
						INSERT IN ARRAY:C227(<>aItemLines; $w)
						<>aItemLines{$w}:=$w
					End if 
				End if 
			End for 
			GOTO RECORD:C242([Item:4]; $masterRecNum)
			If (Size of array:C274(<>aLsSrRec)>0)
				XRef_BuildFromRay
			End if 
		End if 
	End if 
End if 