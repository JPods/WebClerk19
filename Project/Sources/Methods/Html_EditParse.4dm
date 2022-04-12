//%attributes = {"publishedWeb":true}

//Procedure: Html_EditParse
HtPageRay(0)
If (Position:C15("jitWeb"; <>WebFolder)<1)
	ALERT:C41("No jitWeb folder")
	jCancelButton
Else 
	ARRAY TEXT:C222(aText1; 0)
	$error:=HFS_CatToArray(<>webFolder; "aText1")
	$k:=Size of array:C274(aText1)
	C_TEXT:C284($theBody; $testText; $thePage; $theHead; $testSuffix)
	C_LONGINT:C283($bodyBeg; $hasSelect; $headBeg; $headEnd; $foundOnPage)
	For ($i; $k; 1; -1)
		$testSuffix:=Substring:C12(aText1{$i}; Length:C16(aText1{$i})-5)
		$bodyBeg:=Position:C15(".htm"; $testSuffix)
		If ($bodyBeg=0)
			DELETE FROM ARRAY:C228(aText1; $i; 1)
		Else 
			C_TEXT:C284($docName)
			C_BOOLEAN:C305($isLocked; $isInvisible)
			C_DATE:C307($dateCreated; $dateModified)
			C_TIME:C306($timeCreated; $timeModified)
			$docName:=<>WebFolder+aText1{$i}
			GET DOCUMENT PROPERTIES:C477($docName; $isLocked; $isInvisible; $dateCreated; $timeCreated; $dateModified; $timeModified)
			If ($isLocked=False:C215)
				myDoc:=Open document:C264(<>WebFolder+aText1{$i})
				If (OK=1)
					$thePage:=""
					<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
					RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
					If (OK=1)
						CLOSE DOCUMENT:C267(myDoc)
						//If (document="customermod.html")
						//TRACE
						//End if 
						C_LONGINT:C283($bodyBeg; $bodyEnd; $segEnd; $bodyLen)
						$hasSelect:=Num:C11(Position:C15("<Select"; $thePage)>0)
						$hasURL:=Num:C11(Position:C15("jitObject"; $thePage)>0)
						$bodyBeg:=Position:C15("<Body"; $thePage)
						$theHead:=Txt_TweenReturn($thePage; "<Head"; "</Head")
						
						If ($bodyBeg>0)
							$theBody:=Substring:C12($thePage; $bodyBeg)
							$bodyEnd:=Position:C15(">"; $theBody)  //;$bodyBeg   need to write to another variable
							If ($bodyEnd=0)
								$bodyEnd:=100
							End if 
							$w:=Size of array:C274(aHtReason)+1
							HtPageRay(-3; $w; 1)
							Case of 
								: (($hasSelect=1) & ($hasURL=1))
									aHtSelect{$w}:="b"
								: ($hasSelect=1)
									aHtSelect{$w}:="s"
								: ($hasURL=1)
									aHtSelect{$w}:="o"
								Else 
									aHtSelect{$w}:=""
							End case 
							aHtPage{$w}:=aText1{$i}
							//
							vText6:=$theHead
							C_LONGINT:C283($noStyle)
							$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtStyle{$w}; "<Link Rel="+"\""+"Stylesheet"; ">")
							$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtJavaScript{$w}; "src="+"\""+"/js/"; "\"")
							If ($noStyle=0)
								$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtJavaScript{$w}; "src="+"\""+"js"; "\"")
								If ($noStyle=0)
									$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtJavaScript{$w}; "src="+"\""+"js"; "\"")
								End if 
							End if 
							
							$foundOnPage:=Position:C15("<script"; vText6)
							If ($w>0)
								aHtLocaljs{$w}:="True"
							Else 
								aHtLocaljs{$w}:="False"
							End if 
							$foundOnPage:=Position:C15("<style"; vText6)
							If ($w>0)
								aHtLocalstyle{$w}:="True"
							Else 
								aHtLocalstyle{$w}:="False"
							End if 
							//src="/js/
							
							
							vText6:=""
							vText4:=""
							//
							//aHtBody{$w}:=Substring($theBody;1;$bodyEnd)
							//aHtPageOrig{$w}:=$thePage
							
							//<BODY background=""text="#000000"vlink="#FF0000"alink=
							//"#0000AA"bgcolor="#FFFFFF"link="#0000FF">
							//HTML_ParseBody ("background=";aHtBody{$w};->aHtBkGraf{$w})
							//HTML_ParseBody ("text=";aHtBody{$w};->aHtText{$w})
							//HTML_ParseBody ("vlink=";aHtBody{$w};->aHtvLink{$w})
							//HTML_ParseBody ("alink=";aHtBody{$w};->aHtaLink{$w})
							//HTML_ParseBody ("link=";aHtBody{$w};->aHtLink{$w})
							//HTML_ParseBody ("bgcolor=";aHtBody{$w};->aHtBkColor{$w})
							aHtUpDate{$w}:=WC_MetaTagRead($theHead; "jitUpDate"; 0)
							aHtRevisionDate{$w}:=WC_MetaTagRead($theHead; "jitRevisionDate"; 0)
							aHtrevisionID{$w}:=WC_MetaTagRead($theHead; "jitrevisionID"; 0)
							aHtProtection{$w}:=WC_MetaTagRead($theHead; "jitProtection"; 0)
							aHtReason{$w}:=WC_MetaTagRead($theHead; "jitReason"; 0)
							//
						End if 
					End if 
				End if 
			Else 
				// file was locked
			End if 
			
		End if 
	End for 
End if 

If (False:C215)
	
	//Procedure: Html_EditParse
	HtPageRay(0)
	If (HFS_ShortName(<>webFolder)#"jitWeb@")
		ALERT:C41("No jitWeb folder")
		jCancelButton
	Else 
		ARRAY TEXT:C222(aText1; 0)
		$error:=HFS_CatToArray(<>webFolder; "aText1")
		$k:=Size of array:C274(aText1)
		C_TEXT:C284($theBody; $testText; $thePage; $theHead; $testSuffix)
		C_LONGINT:C283($bodyBeg; $hasSelect; $headBeg; $headEnd; $foundOnPage)
		For ($i; $k; 1; -1)
			$testSuffix:=Substring:C12(aText1{$i}; Length:C16(aText1{$i})-5)
			$bodyBeg:=Position:C15(".htm"; $testSuffix)
			If ($bodyBeg=0)
				DELETE FROM ARRAY:C228(aText1; $i; 1)
			Else 
				myDoc:=Open document:C264(<>WebFolder+aText1{$i})
				If (OK=1)
					$thePage:=""
					<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
					RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
					If (OK=1)
						CLOSE DOCUMENT:C267(myDoc)
						//If (document="customermod.html")
						//TRACE
						//End if 
						C_LONGINT:C283($bodyBeg; $bodyEnd; $segEnd; $bodyLen)
						$hasSelect:=Num:C11(Position:C15("<Select"; $thePage)>0)
						$hasURL:=Num:C11(Position:C15("jitObject"; $thePage)>0)
						$bodyBeg:=Position:C15("<Body"; $thePage)
						$theHead:=Txt_TweenReturn($thePage; "<Head"; "</Head")
						
						If ($bodyBeg>0)
							$theBody:=Substring:C12($thePage; $bodyBeg)
							$bodyEnd:=Position:C15(">"; $theBody)  //;$bodyBeg   need to write to another variable
							If ($bodyEnd=0)
								$bodyEnd:=100
							End if 
							$w:=Size of array:C274(aHtReason)+1
							HtPageRay(-3; $w; 1)
							Case of 
								: (($hasSelect=1) & ($hasURL=1))
									aHtSelect{$w}:="b"
								: ($hasSelect=1)
									aHtSelect{$w}:="s"
								: ($hasURL=1)
									aHtSelect{$w}:="o"
								Else 
									aHtSelect{$w}:=""
							End case 
							aHtPage{$w}:=aText1{$i}
							//
							vText6:=$theHead
							C_LONGINT:C283($noStyle)
							$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtStyle{$w}; "<Link Rel="+"\""+"Stylesheet"; ">")
							$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtJavaScript{$w}; "src="+"\""+"/js/"; "\"")
							If ($noStyle=0)
								$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtJavaScript{$w}; "src="+"\""+"js"; "\"")
								If ($noStyle=0)
									$noStyle:=Txt_Chunk(->vText6; ->vText4; ->aHtJavaScript{$w}; "src="+"\""+"js"; "\"")
								End if 
							End if 
							
							$foundOnPage:=Position:C15("<script"; vText6)
							If ($w>0)
								aHtLocaljs{$w}:="True"
							Else 
								aHtLocaljs{$w}:="False"
							End if 
							$foundOnPage:=Position:C15("<style"; vText6)
							If ($w>0)
								aHtLocalstyle{$w}:="True"
							Else 
								aHtLocalstyle{$w}:="False"
							End if 
							//src="/js/
							
							
							vText6:=""
							vText4:=""
							//
							//aHtBody{$w}:=Substring($theBody;1;$bodyEnd)
							//aHtPageOrig{$w}:=$thePage
							
							//<BODY background=""text="#000000"vlink="#FF0000"alink=
							//"#0000AA"bgcolor="#FFFFFF"link="#0000FF">
							//HTML_ParseBody ("background=";aHtBody{$w};->aHtBkGraf{$w})
							//HTML_ParseBody ("text=";aHtBody{$w};->aHtText{$w})
							//HTML_ParseBody ("vlink=";aHtBody{$w};->aHtvLink{$w})
							//HTML_ParseBody ("alink=";aHtBody{$w};->aHtaLink{$w})
							//HTML_ParseBody ("link=";aHtBody{$w};->aHtLink{$w})
							//HTML_ParseBody ("bgcolor=";aHtBody{$w};->aHtBkColor{$w})
							aHtUpDate{$w}:=WC_MetaTagRead($theHead; "jitUpDate"; 0)
							aHtRevisionDate{$w}:=WC_MetaTagRead($theHead; "jitRevisionDate"; 0)
							aHtrevisionID{$w}:=WC_MetaTagRead($theHead; "jitrevisionID"; 0)
							aHtProtection{$w}:=WC_MetaTagRead($theHead; "jitProtection"; 0)
							aHtReason{$w}:=WC_MetaTagRead($theHead; "jitReason"; 0)
							//
						End if 
					End if 
				End if 
			End if 
		End for 
	End if 
End if 
