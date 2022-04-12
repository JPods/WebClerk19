//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/20/12, 20:32:46
// ----------------------------------------------------
// Method: Util_ReplaceString
// Description
// 
//
// Parameters
// ----------------------------------------------------

//vText1:=Select folder("")
//If (OK=1)
vText1:="Beldin:2004_r7_3:4D7r3SubFiles:jitHelp:technotes:"
FOLDER LIST:C473(vText1; aText1)
vi2:=Size of array:C274(aText1)
vText14:=""
For (vi1; 1; vi2)
	DOCUMENT LIST:C474(vText1+aText1{vi1}; aText2)
	vi4:=Size of array:C274(aText2)
	For (vi3; 1; vi4)
		If (aText2{vi3}[[1]]#".")
			vText16:=vText1+aText1{vi1}+":"+aText2{vi3}
			myDoc:=Open document:C264(vText16)
			If (OK=0)
				ALERT:C41(vText16)
			Else 
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
				RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
				CLOSE DOCUMENT:C267(myDoc)
				vi9:=Position:C15("onclick=\"setKeyword"; $thePage)  //////onclick="setKeyword
				If (vi9<1)
					vText14:=vText14+aText2{vi3}+"\r"
					If (False:C215)
						vi9:=Position:C15("#0000d4"; $thePage)
						If (vi9>0)
							//DELAY PROCESS(Current process;20)
							//DELETE DOCUMENT(vText16)
							//DELAY PROCESS(Current process;20)
							vText8:=""
							vText13:=""
							vText14:=""
							vText16:=vText1+aText1{vi1}+":nnn"+aText2{vi3}
							myDoc:=Create document:C266(vText16)
							vi11:=vi9
							Repeat   //back to the beginning of the line
								vi9:=vi9-1
							Until ($thePage[[vi9]]="\r")
							$sendPage:=Substring:C12($thePage; 1; vi9)
							$thePage:=Substring:C12($thePage; vi11+8)  //clipl to the end of the keyword color style
							SEND PACKET:C103(myDoc; $sendPage)
							SEND PACKET:C103(myDoc; "\r"+"font.fkeywords{font-family: 'open sans'; font-size: 12pt; color: #0000d4}")  //replace the keyworkd style
							//
							//find and replace style
							vText8:=Substring:C12($thePage; 1; 20)  //grab a chuck of text containing font.xx{
							vi8:=0
							Repeat 
								vi8:=vi8+1
							Until (vText8[[vi8]]=".")
							vText8:=Substring:C12(vText8; vi8+1)
							vi8:=0
							Repeat 
								vi8:=vi8+1
							Until (vText8[[vi8]]="{")
							vText8:=Substring:C12(vText8; 1; vi8-1)
							
							vText14:="<font class=\""+vText8+"\">"  //find the use of the keynote font
							vi7:=Position:C15(vText14; $thePage)  //find the beginning of keywords
							If (vi7=0)
								//cannot find usage, send out the existing page
							Else 
								$sendPage:=Substring:C12($thePage; 1; vi7)  //clip the page to that point.
								SEND PACKET:C103(myDoc; $sendPage)  //send the page out to the beginning of keywords.
								$thePage:=Substring:C12($thePage; vi7)  //clip the page to that point.
								
								vi7:=Position:C15(">"; $thePage)  //find the end of the keywork font usage
								$thePage:=Substring:C12($thePage; vi7+1)  //clip the page to that point.
								
								SEND PACKET:C103(myDoc; "<font class=\"fkeywords\">")  //send out the replacement Keyword style
								
								vi7:=Position:C15("</font>"; $thePage)  //find the end of the keyworks text block
								vText8:=Substring:C12($thePage; 1; vi7-1)  //captuer the keyworks and ;nbsp;
								$thePage:=Substring:C12($thePage; vi7)  //clip the page after the keyword block
								
								vText8:=Replace string:C233(vText8; "&nbsp;"; "~")
								
								
								vi8:=Length:C16(vText8)
								vi12:=0
								vText12:=""
								For (vi6; 1; vi8)
									If ((vText12="") & (vi12=0))  //send the linking string at the beginning of each word
										vi12:=1
										SEND PACKET:C103(myDoc; "<a href=\"#\" onclick=\"setKeyword('")
									End if 
									Case of 
										: (((vText8[[vi6]]="~") & (vText12#"") & (vi12=1)) | (vi6=vi8))  //post out the word and link, reset
											vText13:="'); return false;\">"
											vText13:=vText12+vText13+vText12+"</a>"+("  |  "*(Num:C11(vi6#vi8)))
											SEND PACKET:C103(myDoc; vText13)
											vText12:=""
											vi12:=0
										: ((vText8[[vi6]]="~") & (vi12=1))
											//do nothing, skip the character
										: ((vText8[[vi6]]#"~") & (vi12=1))  //accumulate the word
											//If (Char(vText8vi6)>31)
											vText12:=vText12+vText8[[vi6]]
											//End if 
									End case 
								End for 
							End if 
						End if 
						SEND PACKET:C103(myDoc; $thePage)
						CLOSE DOCUMENT:C267(myDoc)
					End if 
				End if 
			End if 
		End if 
	End for 
End for 
//End if 
SET TEXT TO PASTEBOARD:C523(vText14)


If (False:C215)
	$thePage:=Get text from pasteboard:C524
	vi9:=Position:C15("#0000d4"; $thePage)
	If (vi9>0)
		vi11:=vi9
		myDoc:=Create document:C266(Storage:C1525.folder.jitF+"zzz"+String:C10(DateTime_Enter)+".html")
		Repeat 
			vi9:=vi9-1
		Until ($thePage[[vi9]]="\r")
		SEND PACKET:C103(myDoc; Substring:C12($thePage; 1; vi9))
		vi8:=vi9
		Repeat 
			vi8:=vi8+1
		Until ($thePage[[vi8]]="{")
		vText8:=Substring:C12($thePage; vi9+1; vi8-vi9-1)
		vText7:=Replace string:C233(vText8; "font."; "")  //find the font style of Keywords
		
		SEND PACKET:C103(myDoc; "font.fkeywords{font-family: 'open sans'; font-size: 12pt; color: #0000d4}")  //replace the keyworkd style
		$thePage:=Substring:C12($thePage; vi11+8)  //clipl to the end of the keyword color style
		vText14:="<font class=\""+vText7+"\">"
		vi7:=Position:C15(vText14; $thePage)  //find the beginning of keywords
		SEND PACKET:C103(myDoc; Substring:C12($thePage; 1; vi7-1))  //send the page out to the beginning of keywords.
		$thePage:=Substring:C12($thePage; vi7+1)  //clip the page to that point.
		
		vi7:=Position:C15(">"; $thePage)  //find the end of the keywork font usage
		$thePage:=Substring:C12($thePage; vi7+1)  //clip the page to that point.
		SEND PACKET:C103(myDoc; "<font class=\"fkeywords\">")  //send out the replacement Keyword style
		
		vi7:=Position:C15("</font>"; $thePage)  //find the end of the keyworks text block
		vText8:=Substring:C12($thePage; 1; vi7-1)  //captuer the keyworks and ;nbsp;
		$thePage:=Substring:C12($thePage; vi7)  //clip the page after the keyword block
		
		vText8:=Replace string:C233(vText8; "&nbsp;"; "~")
		
		
		vi8:=Length:C16(vText8)
		vi12:=0
		vText12:=""
		For (vi6; 1; vi8)
			If ((vText12="") & (vi12=0))  //send the linking string at the beginning of each word
				vi12:=1
				SEND PACKET:C103(myDoc; "<a href=\"#\" onclick=\"setKeyword('")
			End if 
			Case of 
				: (((vText8[[vi6]]="~") & (vText12#"") & (vi12=1)) | (vi6=vi8))  //post out the word and link, reset
					vText13:="'); return false;\">"
					vText13:=vText12+vText13+vText12+"</a>"+("  |  "*(Num:C11(vi6#vi8)))
					SEND PACKET:C103(myDoc; vText13)
					vText12:=""
					vi12:=0
				: ((vText8[[vi6]]="~") & (vi12=1))
					//do nothing, skip the character
				: ((vText8[[vi6]]#"~") & (vi12=1))  //accumulate the word
					//If (Char(vText8vi6)>31)
					vText12:=vText12+vText8[[vi6]]
					//End if 
			End case 
		End for 
		SEND PACKET:C103(myDoc; $thePage)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 




If (False:C215)
	
	vText1:=Select folder:C670("")
	If (OK=1)
		FOLDER LIST:C473(vText1; aText1)
		vi2:=Size of array:C274(aText1)
		For (vi1; 1; vi2)
			DOCUMENT LIST:C474(vText1+aText1{vi1}; aText2)
			vi4:=Size of array:C274(aText2)
			For (vi3; 1; vi4)
				myDoc:=Open document:C264(vText1+aText1{vi1}+":"+aText2{vi3})
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
				RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
				CLOSE DOCUMENT:C267(myDoc)
				vi9:=Position:C15("onclick=\"setKeyword("; $thePage)
				If (vi9<1)
					vi9:=Position:C15("#0000d4"; $thePage)
					If (vi9>0)
						vi11:=vi9
						DELAY PROCESS:C323(Current process:C322; 20)
						DELETE DOCUMENT:C159(document)
						DELAY PROCESS:C323(Current process:C322; 20)
						myDoc:=Create document:C266(vText1+aText1{vi1}+":"+aText2{vi3})
						Repeat 
							vi9:=vi9-1
						Until ($thePage[[vi9]]="\r")
						SEND PACKET:C103(myDoc; Substring:C12($thePage; 1; vi9))
						vi8:=vi9
						Repeat 
							vi8:=vi8+1
						Until ($thePage[[vi8]]="{")
						vText8:=Substring:C12($thePage; vi9+1; vi8-vi9)
						vText7:=Replace string:C233(vText8; "font."; "")
						
						SEND PACKET:C103(myDoc; "font.fkeywords{font-family: 'open sans'; font-size: 12pt; color: #0000d4}")
						$thePage:=Substring:C12($thePage; vi11+8)
						//vi7:=Position("<font class=\""+vText7+\">";$thePage)
						SEND PACKET:C103(myDoc; Substring:C12($thePage; 1; vi7-1))
						vi7:=Position:C15(">"; $thePage)
						$thePage:=Substring:C12($thePage; vi7+1)
						SEND PACKET:C103(myDoc; "<font class=\"fkeywords\">")
						
						vi7:=Position:C15("</font>"; $thePage)
						vText8:=Substring:C12($thePage; 1; vi7-1)
						$thePage:=Substring:C12($thePage; vi7)
						
						vText8:=Replace string:C233(vText8; "&nbsp;"; "~")
						vi8:=Length:C16(vText8)
						vi12:=1
						vText12:=""
						SEND PACKET:C103(myDoc; "<a href=\"#\" onclick=\"setKeyword('")
						For (vi6; 1; vi8)
							Case of 
								: ((vText12="") & (vi12=0))  //send the linking string at the beginning of each word
									vi12:=1
									SEND PACKET:C103(myDoc; "<a href=\"#\" onclick=\"setKeyword('")
								: ((vText8[[vi6]]="~") & (vi12=1))
									//do nothing, skip the character
								: ((vText8[[vi6]]#"~") & (vi12=1))  //accumulate the word
									vText12:=vText12+vText8[[vi6]]
								: (((vText8[[vi6]]="~") & (vi12=1)) | (vi6=vi8))  //post out the word and link, reset
									vText13:=vText12+"'); return false;\">"+vText12+"</a>  |  "
									SEND PACKET:C103(myDoc; vText13)
									vText12:=""
									vi12:=0
							End case 
						End for 
						SEND PACKET:C103(myDoc; $thePage)
						CLOSE DOCUMENT:C267(myDoc)
					End if 
				End if 
			End for 
		End for 
	End if 
	
	
	
	
	
	
	
	
	
	
	vText1:=Select folder:C670("")
	If (OK=1)
		FOLDER LIST:C473(vText1; aText1)
		vi2:=Size of array:C274(aText1)
		For (vi1; 1; vi2)
			DOCUMENT LIST:C474(vText1+aText1{vi1}; aText2)
			vi4:=Size of array:C274(aText2)
			For (vi3; 1; vi4)
				myDoc:=Open document:C264(vText1+aText1{vi1}+":"+aText2{vi3})
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
				RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
				CLOSE DOCUMENT:C267(myDoc)
				vi9:=Position:C15("chapterzzz"; $thePage)
				If (vi9>0)
					DELAY PROCESS:C323(Current process:C322; 20)
					DELETE DOCUMENT:C159(document)
					DELAY PROCESS:C323(Current process:C322; 20)
					myDoc:=Create document:C266(vText1+aText1{vi1}+":"+aText2{vi3})
					SEND PACKET:C103(myDoc; Substring:C12($thePage; 1; vi9-1))
					
					vText9:=Replace string:C233(aText2{vi3}; ".html"; "")
					vText9:=Replace string:C233(vText9; "_"; "-")
					SEND PACKET:C103(myDoc; "Chapter-Section: "+vText9)
					SEND PACKET:C103(myDoc; Substring:C12($thePage; vi9+10))
					CLOSE DOCUMENT:C267(myDoc)
				End if 
			End for 
		End for 
	End if 
	
End if 