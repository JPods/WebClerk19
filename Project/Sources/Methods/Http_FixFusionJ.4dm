//%attributes = {"publishedWeb":true}
//Procedure: Mac_SetCreator
C_TIME:C306($myDoc)
C_LONGINT:C283($err; $i; $k; $len; $p; $incPic; $cntPic)
C_TEXT:C284($myCreator; $oldCreator)
C_TEXT:C284($mySuffix; $pictFold; $pageFold; $thePage)
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText2; 0)
$pageFold:=Get_FolderName("Select folder for page checking.")
$pictFold:=Get_FolderName("Select folder for setting .ext")
If (($pictFold#"") & ($pageFold#""))
	$mySuffix:=Request:C163("Enter .ext"; ".jpg")
	If (($mySuffix#"") & (OK=1))
		$err:=HFS_CatToArray($pictFold; "aText1")
		$err:=HFS_CatToArray($pageFold; "aText2")
		$k:=Size of array:C274(aText2)
		$cntPic:=Size of array:C274(aText1)
		For ($incPic; $cntPic; 1; -1)
			$p:=Position:C15("."; aText1{$incPic})
			If (($p>0) | (":"=aText1{$incPic}[[Length:C16(aText1{$incPic})]]) | ("\\"=aText1{$incPic}[[Length:C16(aText1{$incPic})]]))
				DELETE FROM ARRAY:C228(aText1; $incPic; 1)
			Else 
				$err:=HFS_Rename($pictFold+aText1{$incPic}; aText1{$incPic}+$mySuffix)
			End if 
		End for 
		$cntPic:=Size of array:C274(aText1)
		For ($i; 2; $k)
			MESSAGE:C88(String:C10($i)+" of "+String:C10($k))
			$p:=Position:C15(".htm"; aText2{$i})
			If ($p>0)
				$myDoc:=Open document:C264($pageFold+aText2{$i})
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
				RECEIVE PACKET:C104($myDoc; $thePage; <>vEoF)
				CLOSE DOCUMENT:C267($myDoc)
				$err:=HFS_Delete($pageFold+aText2{$i})
				If ($err=0)
					For ($incPic; 1; $cntPic)
						$thePage:=Replace string:C233($thePage; aText1{$incPic}; aText1{$incPic}+$mySuffix+"!zzz!")
					End for 
					$myDoc:=Create document:C266($pageFold+aText2{$i})
					SEND PACKET:C103($myDoc; $thePage)
					CLOSE DOCUMENT:C267($mydoc)
				End if 
			End if 
		End for 
	End if 
End if 

REDRAW WINDOW:C456
