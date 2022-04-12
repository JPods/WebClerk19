//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTML_jit2Dotted
	//Date: 07/01/02
	//Who: Bill James
	//Description: Change web site to no jitxUser and !jit
	VERSION_960
End if 
C_LONGINT:C283($err; $i; $k; $1; $doHtml; $kPages; $iPages)
C_TEXT:C284($fileFold; $theSite)
KeyModifierCurrent
CONFIRM:C162("Backup before this step, OK to change web pages to '_jit' tags.")
If (OK=1)
	$fileFold:=Get_FolderName("Select folder to List Files.")
	If ($fileFold#"")
		$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")
		If ($w>0)
			WC_StartUpShutDownFlip
		End if 
		ARRAY TEXT:C222(aText1; 0)
		ARRAY TEXT:C222($aDocArray; 0)
		$error:=HFS_CatToArray($fileFold; "aText1")
		COPY ARRAY:C226(aText1; $aDocArray)
		$kPages:=Size of array:C274($aDocArray)
		If ($kPages>0)
			C_TEXT:C284($theBody; $testText; $thePage; $theHead)
			C_LONGINT:C283($bodyBeg; $hasSelect; $headBeg; $headEnd)
			$do_Cookie:=False:C215
			$do_jit:=False:C215
			//
			If (optKey=0)
				$do_jit:=True:C214
				$do_Cookie:=True:C214
			Else 
				CONFIRM:C162("Replace: !jit=.. with _jit_...")
				$do_jit:=(OK=1)
				CONFIRM:C162("Replace: jitUser. with Session Cookie...")
				$do_Cookie:=(OK=1)
			End if 
			//
			TRACE:C157
			If (($do_jit) | ($do_Cookie))
				For ($iPages; $kPages; 1; -1)
					MESSAGE:C88(String:C10($iPages)+" to zero")
					$bodyBeg:=Position:C15("."; $aDocArray{$iPages})
					If (($bodyBeg>0) & ($aDocArray{$iPages}#"Secure.txt"))
						myDoc:=Open document:C264($fileFold+$aDocArray{$iPages})
						If (OK=1)
							$thePage:=""
							<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
							RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
							If (OK=1)
								CLOSE DOCUMENT:C267(myDoc)
								// TRACE
								$thePage:=Html_TagMetaJIT($thePage)
								ARRAY TEXT:C222($aJavaScripts; 0)
								Repeat 
									$p:=Position:C15("<Script"; $thePage)
									$pScriptEnd:=Position:C15("</Script>"; $thePage)
									If (($p>0) & ($pScriptEnd>0))
										$w:=Size of array:C274($aJavaScripts)+1
										INSERT IN ARRAY:C227($aJavaScripts; $w)
										$aJavaScripts{$w}:=Substring:C12($thePage; $p; $pScriptEnd-$p+9)
										$thePage:=Substring:C12($thePage; 1; $p-1)+"<!--JavaScript_"+String:C10($w; "000")+"-->"+Substring:C12($thePage; $pScriptEnd+9)
									End if 
								Until ($p=0)
								Repeat 
									$p:=Position:C15("<Style"; $thePage)
									$pScriptEnd:=Position:C15("</Style>"; $thePage)
									If (($p>0) & ($pScriptEnd>0))
										$w:=Size of array:C274($aJavaScripts)+1
										INSERT IN ARRAY:C227($aJavaScripts; $w)
										$aJavaScripts{$w}:=Substring:C12($thePage; $p; $pScriptEnd-$p+8)
										$thePage:=Substring:C12($thePage; 1; $p-1)+"<!--JavaScript_"+String:C10($w; "000")+"-->"+Substring:C12($thePage; $pScriptEnd+8)
									End if 
								Until ($p=0)
								
								If ($do_jit)
									
									If (Position:C15("jit"; $thePage)>0)
										//
										If ($do_Cookie)
											//jitxUser
											
											//
											$userhidden:="<INPUT TYPE="+Txt_Quoted("hidden")+" NAME="+Txt_Quoted("jitUser")+" VALUE="+Txt_Quoted("_jit_0_vleventIDjj")+">"
											$thePage:=Replace string:C233($thePage; $userhidden; "")
											//
											$userhidden:="jitUser"
											$thePage:=Replace string:C233($thePage; $userhidden; "theUser")
											//
										End if 
										//
										$thePage:=Replace string:C233($thePage; "p_Profile"; "pvLnProfile")
										$thePage:=Replace string:C233($thePage; "vQtyAvailable"; "pvQtyAvailable")
										$thePage:=Replace string:C233($thePage; "\""+"p_Profile"; "\""+"pvLnProfile")
										$thePage:=Replace string:C233($thePage; "\""+"p_"; "\""+"pv")
										$thePage:=Replace string:C233($thePage; ";p_"; ";pv")
										$thePage:=Replace string:C233($thePage; ";tc_"; ";tc")
										$thePage:=Replace string:C233($thePage; ";vQtyAvailable"; ";pvQtyAvailable")
										$thePage:=Replace string:C233($thePage; ";<>tc_"; ";tc")
										
										
										//
										$thePage:=Replace string:C233($thePage; ".html&"+"\""; ".html"+"\"")
										
										//all variables from 
										
										
										//$thePage:=Replace string($thePage;"p_QtyOrd";"pvQtyOrd
										//")
										//$thePage:=Replace string($thePage;"p_ItemNum";
										//"pvItemNum")
										//$thePage:=Replace string($thePage;"p_BasePrice";
										//"pvBasePrice")
										//$thePage:=Replace string($thePage;"p_UnitPrice";
										//"pvUnitPrice")
										//$thePage:=Replace string($thePage;"p_Dcnt";"pvDcnt")
										//$thePage:=Replace string($thePage;"p_ExtPrice";
										//"pvExtPrice")
										//$thePage:=Replace string($thePage;"p_ExtPrice";
										//"pvExtPrice")
										//$thePage:=Replace string($thePage;"p_SumQuantity";
										//"pvSumQuantity")
										//$thePage:=Replace string($thePage;"p_SumPrice";
										//"pvSumPrice")
										//$thePage:=Replace string($thePage;"p_SumBonus";
										//"pvSumBonus")
										//$thePage:=Replace string($thePage;"p_LnProfile1";
										//"pvLnProfile1")
										//$thePage:=Replace string($thePage;"p_LnProfile2";
										//"pvLnProfile2")
										//$thePage:=Replace string($thePage;"p_LnProfile3";
										//"pvLnProfile3")
										//$thePage:=Replace string($thePage;"p_LnProfile4";
										//"pvLnProfile4")
										//$thePage:=Replace string($thePage;"p_LnComment";
										//"pvLnComment")
										//p_LnComment
										
										//pvLnProfile1
										
										
										
										$thePage:=Replace string:C233($thePage; "!jit=-3;"; "_jit_-3_")
										$thePage:=Replace string:C233($thePage; "!jit=-2;"; "_jit_-2_")
										$thePage:=Replace string:C233($thePage; "!jit=-1;"; "_jit_-1_")
										//
										
										$thePage:=Replace string:C233($thePage; "!jitSort="; "_jitSort_")
										//
										C_LONGINT:C283($pEnd)
										$myWorking:=""
										$p:=Position:C15("jitSort"; $thePage)
										If ($p>0)
											While ($p>0)
												$myWorking:=$myWorking+Substring:C12($thePage; 1; $p-1)
												$thePage:=Substring:C12($thePage; $p)
												$pEnd:=Position:C15(">"; $thePage)
												$theObject:=""
												If ($pEnd>0)
													$theObject:=Substring:C12($thePage; 1; $pEnd)
													$thePage:=Substring:C12($thePage; $pEnd+1)
													$theObject:=Replace string:C233($theObject; ";"; "_")
													$theObject:=Replace string:C233($theObject; "!"; "jj")
													$myWorking:=$myWorking+$theObject
												Else 
													$theObject:=Substring:C12($thePage; 1; 3)+"zzz"  //clip past error
													$thePage:=Substring:C12($thePage; 3+1)
													$myWorking:=$myWorking+$theObject
												End if 
												$p:=Position:C15("jitSort"; $thePage)
											End while 
											$thePage:=$myWorking+$thePage
										End if 
										//
										$thePage:=Replace string:C233($thePage; "!jit=end;!"; "_jit_end_jj")
										//
										C_TEXT:C284($myWorking; $theObject)
										$myWorking:=""
										$p:=Position:C15("<!--jitObject="; $thePage)
										If ($p>0)
											//TRACE
											While ($p>0)
												//
												$myWorking:=$myWorking+Substring:C12($thePage; 1; $p-1)
												$thePage:=Substring:C12($thePage; $p)
												$p:=Position:C15("-->"; $thePage)
												$theObject:=Substring:C12($thePage; 1; $p+2)
												$theObject:=Replace string:C233($theObject; ";"; "_")
												$theObject:=Replace string:C233($theObject; "="; "_")
												$theObject:=Replace string:C233($theObject; "!"; "jj")
												$thePage:=Substring:C12($thePage; $p+3)
												$myWorking:=$myWorking+$theObject
												$p:=Position:C15("<!--jitObject="; $thePage)
											End while 
											$thePage:=$myWorking+$thePage
										End if 
										
										//
										
										C_LONGINT:C283($k; $i; $incFields; $cntFields)
										$k:=Get last table number:C254
										
										For ($i; 1; $k)
											$thePage:=Replace string:C233($thePage; "!jit=begin;"+String:C10($i)+";1!"; "_jit_begin_"+String:C10($i)+"_1"+<>endTag)
											$thePage:=Replace string:C233($thePage; "!jit="+String:C10($i)+";0!"; "_jit_"+String:C10($i)+"_0"+<>endTag)
											$thePage:=Replace string:C233($thePage; "!jit="+String:C10($i)+";-1!"; "_jit_"+String:C10($i)+"_-1"+<>endTag)
											$thePage:=Replace string:C233($thePage; "!jit="+String:C10($i)+";-2!"; "_jit_"+String:C10($i)+"_-2"+<>endTag)
											$thePage:=Replace string:C233($thePage; "!jit="+String:C10($i)+";-3!"; "_jit_"+String:C10($i)+"_-3"+<>endTag)
											
											$cntFields:=Get last field number:C255(Table:C252($i))
											For ($incFields; 1; $cntFields)
												$thePage:=Replace string:C233($thePage; "!jit="+String:C10($i)+";"+String:C10($incFields)+"!"; "_jit_"+String:C10($i)+"_"+String:C10($incFields)+""+<>endTag)
											End for 
										End for 
										
										
										
										
										//                
										$thePage:=Replace string:C233($thePage; "!jit="; <>jitTag)
										$thePage:=Replace string:C233($thePage; "!ref="; <>refTag)
										//
										$thePage:=Replace string:C233($thePage; "!jitSort"; "_jitSort_")
										//   
										$thePage:=Replace string:C233($thePage; "0;"; "0_")
										$thePage:=Replace string:C233($thePage; "1;"; "1_")
										$thePage:=Replace string:C233($thePage; "2;"; "2_")
										$thePage:=Replace string:C233($thePage; "3;"; "3_")
										$thePage:=Replace string:C233($thePage; "4;"; "4_")
										$thePage:=Replace string:C233($thePage; "5;"; "5_")
										$thePage:=Replace string:C233($thePage; "6;"; "6_")
										$thePage:=Replace string:C233($thePage; "7;"; "7_")
										$thePage:=Replace string:C233($thePage; "8;"; "8_")
										$thePage:=Replace string:C233($thePage; "9;"; "9_")
										//
										$thePage:=Replace string:C233($thePage; ";!"; "_"+<>endTag)
										$thePage:=Replace string:C233($thePage; "0!"; "0"+<>endTag)
										$thePage:=Replace string:C233($thePage; "1!"; "1"+<>endTag)
										$thePage:=Replace string:C233($thePage; "2!"; "2"+<>endTag)
										$thePage:=Replace string:C233($thePage; "3!"; "3"+<>endTag)
										$thePage:=Replace string:C233($thePage; "4!"; "4"+<>endTag)
										$thePage:=Replace string:C233($thePage; "5!"; "5"+<>endTag)
										$thePage:=Replace string:C233($thePage; "6!"; "6"+<>endTag)
										$thePage:=Replace string:C233($thePage; "7!"; "7"+<>endTag)
										$thePage:=Replace string:C233($thePage; "8!"; "8"+<>endTag)
										$thePage:=Replace string:C233($thePage; "9!"; "9"+<>endTag)
										//
										$thePage:=Replace string:C233($thePage; "<!"; "_jjj_")
										$thePage:=Replace string:C233($thePage; "!!"; "_zzz_")
										$thePage:=Replace string:C233($thePage; "!<"; <>endTag+"<")
										$thePage:=Replace string:C233($thePage; "!*"; <>endTag+"*")
										$thePage:=Replace string:C233($thePage; "!"+Char:C90(34); <>endTag+Char:C90(34))
										$thePage:=Replace string:C233($thePage; ".0!"; <>formatTag+"0"+<>endTag)
										$thePage:=Replace string:C233($thePage; ".1!"; <>formatTag+"1"+<>endTag)
										$thePage:=Replace string:C233($thePage; ".2!"; <>formatTag+"2"+<>endTag)
										$thePage:=Replace string:C233($thePage; ".fone!"; <>formatTag+"fone"+<>endTag)
										$thePage:=Replace string:C233($thePage; "!jitSecure="; "_jitSecure_")
										//
										$buildPage:=""
										$restPage:=$thePage
										$p:=Position:C15("!"; $restPage)
										If ($p>0)
											While ($p>0)
												$testStr:=Substring:C12($restPage; $p-40; $p+2)
												$buildPage:=$buildPage+Substring:C12($restPage; 1; $p-1)  //cut out the '!'
												$restPage:=Substring:C12($restPage; $p+1)
												$p_jit:=Position:C15("jit_"; $testStr)
												If ($p_jit>0)
													$buildPage:=$buildPage+<>endTag
												Else 
													$buildPage:=$buildPage+"!"
												End if 
												$p:=Position:C15("!"; $restPage)
											End while 
											$thePage:=$buildPage+$restPage
										End if 
										$thePage:=Replace string:C233($thePage; "_jjj_"; "<!")
										$thePage:=Replace string:C233($thePage; "_zzz_"; "!!")
										//
										$thePage:=Replace string:C233($thePage; ".0jj"; "_0jj")  //fix formating instances
										$thePage:=Replace string:C233($thePage; ".1jj"; "_1jj")
										$thePage:=Replace string:C233($thePage; ".2jj"; "_2jj")
										//
										$thePage:=Replace string:C233($thePage; "<jj--"; "<!--")  //fix commented tags
										
									End if 
									$k:=Size of array:C274($aJavaScripts)
									For ($i; 1; $k)
										$p:=Position:C15("<!--JavaScript_"+String:C10($i; "000")+"-->"; $thePage)
										If ($p>0)
											$thePage:=Substring:C12($thePage; 1; $p-1)+$aJavaScripts{$i}+Substring:C12($thePage; $p+21)
										End if 
									End for 
									$err:=HFS_Delete(document)
									myDoc:=Create document:C266(document)
									SEND PACKET:C103(myDoc; $thePage)
									CLOSE DOCUMENT:C267(myDoc)
									App_SetSuffix(".html.txt"; ".html")
								End if 
							End if 
						End if 
					End if 
				End for 
				ALERT:C41("Check for 'jj_jj' incorrectly applied to '!'"+"\r"+"Single '!' conversion may affect content")
			End if 
		End if 
	End if 
	REDRAW WINDOW:C456
End if 

REDRAW WINDOW:C456