//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtBubblePage2Multi
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

TRACE:C157
//UtBubblePage2Multi
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText6; 0)
$tempFold:=Get_FolderName("Select folder for setting suffix.")
If ($tempFold#"")
	$err:=HFS_CatToArray($tempFold; "aText1")
	$k:=Size of array:C274(aText1)
	If ($k>0)
		myDocName:=""
		C_LONGINT:C283($myOK)
		myDoc:=Open document:C264($tempFold+"BubblePagesByModel.txt")
		If (OK=1)
			vText1:=""
			sumDoc:=Open document:C264($tempFold+"BubbleLink.txt")
			If (OK=1)
				C_TEXT:C284($clipInsertText; $thePageText; $groupPage; $pageName)
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
				RECEIVE PACKET:C104(sumDoc; $clipInsertText; <>vEoF)
				CLOSE DOCUMENT:C267(sumDoc)
				$clipInsertText:=Replace string:C233($clipInsertText; "\r"; "")
				RECEIVE PACKET:C104(myDoc; $theLine; "\r")
				TextToArray($theLine; ->aText7; "\t"; True:C214)
				ARRAY TEXT:C222(aText6; Size of array:C274(aText7))
				Repeat 
					RECEIVE PACKET:C104(myDoc; $theLine; "\r")
					If (OK=1)
						TextToArray($theLine; ->aText8; "\t"; True:C214)
						$cntPages:=Size of array:C274(aText8)-1
						If ($cntPages>1)
							$w:=Find in array:C230(aText1; aText8{1})
							If ($w>0)
								sumDoc:=Open document:C264($tempFold+aText1{$w})
								If (OK=1)
									RECEIVE PACKET:C104(sumDoc; vText9; 2000000000)
									CLOSE DOCUMENT:C267(sumDoc)
									vText9:=Replace string:C233(vText9; "href="+Char:C90(34)+"#"; "href="+Char:C90(34))
									$clipName:=Substring:C12(aText1{$w}; 1; Position:C15(".htm"; aText1{$w})-1)
									//
									$groupPage:=""
									
									For ($incPage; 2; $cntPages)
										If (aText8{$incPage}#"")
											$pageName:=aText7{$incPage}+"_P"+$clipName+".html"
											If (HFS_Exists($tempFold+$pageName)>0)
												$err:=HFS_Delete($tempFold+$pageName)
											End if 
											sumDoc:=Create document:C266($tempFold+$pageName)
											If (OK=1)
												aText6{$incPage}:=aText6{$incPage}+"<a href=/blowapart?"+Txt_Quoted($pageName)+">"+$pageName+"</a>"+"\r"
												//
												$thePageText:=Replace string:C233(vText9; "href="+Char:C90(34); "target="+Txt_Quoted("Frame_PDescript")+" href="+Char:C90(34)+$clipInsertText+aText8{$incPage}+"&BubbleID=")
												$thePageText:=Replace string:C233($thePageText; "<area"; "\r"+"<area")
												$thePageText:=Replace string:C233($thePageText; "\r"+"\r"; "\r")
												$thePageText:=Replace string:C233($thePageText; "<img src"; "<a href="+Txt_Quoted("/blowapart?"+aText7{$incPage}+".html")+">"+aText7{$incPage}+" Master Page</a><BR>"+"\r"+"<img src")
												//$thePageText:=Replace string($thePageText;"href="
												//+Char(34);"href="+Char(34)+$clipInsertText+)
												SEND PACKET:C103(sumDoc; $thePageText)
												CLOSE DOCUMENT:C267(sumDoc)
											End if 
										End if 
									End for 
								End if 
							End if 
						End if 
					End if 
				Until (OK=0)
				CLOSE DOCUMENT:C267(myDoc)
				For ($incPage; 2; $cntPages)
					$pageName:=$tempFold+aText7{$incPage}+".html"
					If (HFS_Exists($pageName)>0)
						$err:=HFS_Delete($pageName)
					End if 
					sumDoc:=Create document:C266($pageName)
					SEND PACKET:C103(sumDoc; aText6{$incPage})
					CLOSE DOCUMENT:C267(sumDoc)
				End for 
			End if 
		End if 
	End if 
End if 
C_LONGINT:C283($incPage)


