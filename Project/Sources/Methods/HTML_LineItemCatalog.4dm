//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTML_LineItemCatalog
	//Date: 07/01/02
	//Who: Bill James
	//Description: Change web site to no jitxUser and !jit
	VERSION_960
End if 
C_LONGINT:C283($err; $i; $k; $doHtml; $kPages; $iPages)
C_TEXT:C284($fileFold; $theSite; $1)
vi1:=1
If (Count parameters:C259=0)
	CONFIRM:C162("Backup before this step, OK to change web pages to '_jit' tags.")
	If (OK=1)
		$fileFold:=Get_FolderName("Select folder to List Files.")
	End if 
Else 
	vi1:=vi1+1
	$fileFold:=$1
End if 
If ($fileFold#"")
	ARRAY TEXT:C222(aText1; 0)
	ARRAY TEXT:C222($aDocArray; 0)
	$error:=HFS_CatToArray($fileFold; "aText1")
	COPY ARRAY:C226(aText1; $aDocArray)
	$kPages:=Size of array:C274($aDocArray)
	If ($kPages>0)
		
		C_TEXT:C284($theBody; $testText; $thePage; $theHead; $itemNumExt; $itemValue)
		C_LONGINT:C283($bodyBeg; $hasSelect; $headBeg; $headEnd; $pQuote; $p; $pEndLine)
		For ($iPages; $kPages; 1; -1)
			MESSAGE:C88(String:C10($iPages)+" to zero")
			Case of 
				: ($aDocArray{$iPages}="")
				: ($aDocArray{$iPages}="Secure.txt")  //skipThis
				: ($aDocArray{$iPages}[[Length:C16($aDocArray{$iPages})]]=Folder separator:K24:12)  //do subfolders
					HTML_LineItemCatalog($fileFold+$aDocArray{$iPages})
				: ((Position:C15(".htm"; $aDocArray{$iPages})>0) | (Position:C15(".txt"; $aDocArray{$iPages})>0))  //it is a page or object          
					myDoc:=Open document:C264($fileFold+$aDocArray{$iPages})
					If (OK=1)
						$outPage:=""
						$thePage:=""
						<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
						RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
						If (OK=1)
							CLOSE DOCUMENT:C267(myDoc)
							If (Position:C15("LineRecordNum"; $thePage)>1)
								//drop out if already done
							Else 
								$thePage:=Replace string:C233($thePage; ""; "<>")
								Repeat 
									$p:=Position:C15("<input type="+Txt_Quoted("text")+" name="+Char:C90(34)+"itemNum"; $thePage)
									If ($p>0)
										$outPage:=$outPage+Substring:C12($thePage; 1; $p-1)
										
										//$thePage:=Substring($thePage;$p)
										//$p:=Position(">";$thePage)
										//If ($p>0)
										//$theClip:=Substring($thePage;1;$p+1)
										//$thePage:=Substring($thePage;$p+1)
										////parse values out of $theClip
										//
										//End if 
										
										$p:=Position:C15("itemNum"; $thePage)
										$thePage:=Substring:C12($thePage; $p+7)
										$pQuote:=Position:C15(Char:C90(34); $thePage)
										If ($pQuote>0)
											$itemNumExt:=Substring:C12($thePage; 1; $pQuote-1)
										End if 
										$pEndLine:=Position:C15(">"; $thePage)
										If ($pEndLine>0)
											$thePage:=Substring:C12($thePage; $pEndLine+1)
										End if 
										$replaceItem:="<INPUT TYPE="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("LineRecordNum")+"  value="+Txt_Quoted("_jit_101_-2jj")+">"+"\r"
										$replaceItem:=$replaceItem+"<INPUT TYPE="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("ItemNum")+" VALUE="+Txt_Quoted($itemNumExt)+">"+"\r"
										$replaceItem:=$replaceItem+"<INPUT TYPE="+Txt_Quoted("text")+" NAME="+Txt_Quoted("QtyOrdered")+" VALUE="+Txt_Quoted($itemValue)+" Length="+Txt_Quoted("5")+" Size="+Txt_Quoted("4")+">"+"\r"
										$outPage:=$outPage+$replaceItem
									Else 
										$outPage:=$outPage+$thePage
									End if 
								Until ($p<1)
								$err:=HFS_Delete(document)
								myDoc:=Create document:C266(document)
								SEND PACKET:C103(myDoc; $outPage)
								CLOSE DOCUMENT:C267(myDoc)
								If (Position:C15(".html.txt"; document)>0)
									$newName:=Replace string:C233(document; ".html.txt"; ".html")
									$err:=HFS_Rename(document; $newName)
									//App_SetSuffix (".html.txt";".html";$doSubFolders;document)
								End if 
							End if 
						End if 
					End if 
			End case 
		End for 
	End if 
End if 

REDRAW WINDOW:C456