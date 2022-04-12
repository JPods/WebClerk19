//%attributes = {"publishedWeb":true}
//Method: Move_Images
C_LONGINT:C283($err; $i; $k; $1; $doHtml; $inc2; $cnt2; $inc3; $cnt3)
C_TEXT:C284($fileFold; $theSite; $baseItem; $theSubject; $Pro1; $Pro2; $Pro3; $Pro4; $theText)
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText2; 0)
C_LONGINT:C283($doItem)
vText1:=""
$fileFold:=Get_FolderName("Select folder to ind images in.")
If ($fileFold#"")
	$moveFold:=Get_FolderName("Select destination folder.")
	If ($moveFold#"")
		$error:=HFS_CatToArray($fileFold; "aText1")
		$k:=Size of array:C274(aText1)
		For ($i; 1; $k)
			If ((":"=aText1{$i}[[Length:C16(aText1{$i})]]) | ("\\"=aText1{$i}[[Length:C16(aText1{$i})]]))
				$2Folder:=$fileFold+aText1{$i}
				$error:=HFS_CatToArray($2Folder; "aText2")
				$cnt2:=Size of array:C274(aText2)
				For ($inc2; 1; $cnt2)
					If ((":"=aText2{$inc2}[[Length:C16(aText2{$inc2})]]) | ("\\"=aText2{$inc2}[[Length:C16(aText2{$inc2})]]))
						$3Folder:=$fileFold+aText1{$i}+aText2{$inc2}
						$error:=HFS_CatToArray($3Folder; "aText3")
						$cnt3:=Size of array:C274(aText3)
						For ($inc3; 1; $cnt3)
							If ((":"=aText3{$inc3}[[Length:C16(aText3{$inc3})]]) | ("\\"=aText3{$inc3}[[Length:C16(aText3{$inc3})]]))
								$4Folder:=$fileFold+aText1{$i}+aText2{$inc2}+aText3{$inc3}
								$error:=HFS_CatToArray($4Folder; "aText4")
								$cnt4:=Size of array:C274(aText4)
								For ($inc4; 1; $cnt4)
									$theDocPath:=$4Folder+aText4{$inc4}
									$newDoc:=$moveFold+aText4{$inc4}
									If (HFS_Exists($newDoc)=0)
										COPY DOCUMENT:C541($theDocPath; $moveFold; *)
									End if 
								End for 
							Else 
								$theDocPath:=$3Folder+aText3{$inc3}
								$newDoc:=$moveFold+aText3{$inc3}
								If (HFS_Exists($newDoc)=0)
									COPY DOCUMENT:C541($theDocPath; $moveFold; *)
								End if 
							End if 
						End for 
					Else 
						$theDocPath:=$2Folder+aText2{$inc2}
						$newDoc:=$moveFold+aText2{$inc2}
						If (HFS_Exists($newDoc)=0)
							COPY DOCUMENT:C541($theDocPath; $moveFold; *)
						End if 
					End if 
				End for 
			Else 
				$theDocPath:=$fileFold+aText1{$i}
				$newDoc:=$moveFold+aText1{$i}
				If (HFS_Exists($newDoc)=0)
					COPY DOCUMENT:C541($theDocPath; $moveFold; *)
				End if 
			End if 
		End for 
	End if 
End if 