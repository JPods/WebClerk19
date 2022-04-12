//%attributes = {"publishedWeb":true}
//Method: HTML_UpDateObjects
C_TEXT:C284($1; $theSelect; $theField; $pageOut; $docName; $theFileStr; $pendHold; $selectList; $holdSelect)
C_LONGINT:C283($pBeg; $p; $pEnd; $pLine; $pSize; $theFile; $pRef; $pEndRef; $pFileNum)
C_TEXT:C284($strFile; $quoteChar)
C_TEXT:C284($strField1; $strField2; $strField3; $myText)
theText:=""
$quoteChar:=Char:C90(34)
$docName:=<>WebFolder+$1
If (Is macOS:C1572)
	$lineBreak:=Char:C90(13)
Else 
	$lineBreak:=Char:C90(13)+Char:C90(10)
End if 

If (HFS_Exists($docName)=1)
	myDoc:=Open document:C264($docName)
	If (OK=1)
		<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
		RECEIVE PACKET:C104(myDoc; $pageIn; <>vEoF)
		CLOSE DOCUMENT:C267(myDoc)
		$pageIn:=Replace string:C233($pageIn; "MfgID"; "mfrID")
		$theFont:="<FONT FACE="+"\""+"Arial"+"\""+" SIZE="+"\""+"1"+"\""+">"
		$endFont:="</FONT>"
		$makeSearch:="SkipSearch"
		C_LONGINT:C283($theBreaks)
		$pageOut:=""
		$pBeg:=Position:C15("<!--jitObject"; $pageIn)
		//TRACE
		If ($pBeg>0)
			While ($pBeg>0)
				$skipQuery:=False:C215
				$queryPara:=""  //set insert equal ""
				ARRAY TEXT:C222(aText2; 0)
				$strField2:=""
				$theTag:=""
				$pageOut:=$pageOut+Substring:C12($pageIn; 1; $pBeg-1)
				$pageIn:=Substring:C12($pageIn; $pBeg)
				$pEnd:=Position:C15("-->"; $pageIn)  //end of file;field
				$jitOBJ:=Substring:C12($pageIn; 1; $pEnd-1)
				$pageIn:=Substring:C12($pageIn; $pEnd+4)
				
				$pBeg:=Position:C15("_"; $jitOBJ)
				$myText:=Substring:C12($jitOBJ; $pBeg+1)  //Clip  
				$jitOBJ:=$jitOBJ+"-->"
				$pBeg:=Position:C15("_"; $myText)
				$theBreaks:=Num:C11(Substring:C12($myText; 1; $pBeg-1))  //number of columns
				$myText:=Substring:C12($myText; $pBeg+1)  //Clip  
				$pBeg:=Position:C15("_"; $myText)
				$strFile:=Substring:C12($myText; 1; $pBeg-1)  //name of the table
				$myText:=Substring:C12($myText; $pBeg+1)  //Clip 
				$pBeg:=Position:C15("_"; $myText)
				If ($pBeg>0)
					$strField1:=Substring:C12($myText; 1; $pBeg-1)
					$myText:=Substring:C12($myText; $pBeg+1)  //second value 
					$pBeg:=Position:C15("?"; $myText)
					If ($pBeg<1)
						$strField2:=$myText
					Else 
						$strField2:=Substring:C12($myText; 1; $pBeg-1)
						theText:=Substring:C12($myText; $pBeg+1)
						
					End if 
				Else 
					$strField1:=$myText
				End if 
				$selectList:=""
				theText:=$jitOBJ
				$tableName:=WCapi_GetParameter("TableName"; "")
				$strFile:=$tableName
				If ($tableName#"")
					$theCommand:=WCapi_GetParameter("Command"; "")
					$queryPara:=""
					$fieldCat1:=WCapi_GetParameter("CatagoryField1"; "")
					$strField1:=$fieldCat1
					$valueCat1:=WCapi_GetParameter("CatagoryValue1"; "")
					$fieldCat2:=WCapi_GetParameter("CatagoryField2"; "")
					$valueCat2:=WCapi_GetParameter("CatagoryValue2"; "")
					$fieldCat3:=WCapi_GetParameter("CatagoryField3"; "")
					$valueCat3:=WCapi_GetParameter("CatagoryValue3"; "")
					//
					$fieldName1:=WCapi_GetParameter("QueryField1"; "")
					$value1:=WCapi_GetParameter("QueryValue1"; "")
					$fieldName2:=WCapi_GetParameter("QueryField2"; "")
					$value2:=WCapi_GetParameter("QueryValue2"; "")
					$fieldName3:=WCapi_GetParameter("QueryField3"; "")
					$value3:=WCapi_GetParameter("QueryValue3"; "")
					If (($fieldName3#"") & ($fieldName3#"Publish"))
						$queryPara:=$fieldName3+"="+$value3+"&"
					End if 
					If (($fieldName2#"") & ($fieldName2#"Publish"))
						$queryPara:=$queryPara+$fieldName2+"="+$value2+"&"
					End if 
					If (($fieldName1#"") & ($fieldName1#"Publish"))
						$queryPara:=$queryPara+$fieldName1+"="+$value1+"&"
					End if 
					//
					$theBreaks:=Num:C11(WCapi_GetParameter("ColumnCount"; ""))
					If ($theBreaks=0)
						$theBreaks:=6
					End if 
					
					$tableNum:=STR_GetTableNumber($tableName)
					$fieldNum:=STR_GetFieldNumber($tableName; $fieldCat1)
					If (($tableNum=0) | ($fieldNum=0))
						If (allowAlerts_boo)
							ALERT:C41("Incorrect Field or Table")
						End if 
					Else 
						theText:=$jitOBJ
						C_LONGINT:C283($viAltTableNum)
						$viAltTableNum:=WccQuery3Fields
						HTML_Distinct(Field:C253($tableNum; $fieldNum); -3; ->[Item:4]publish:60; "SkipSearch"; ->aText1)
						$selectList:=Html_UrlFill(->aText1; $theCommand+"?"+$queryPara+$fieldCat1+"="; $theBreaks)  //"/item_List?vendID=";$theBreaks)
					End if 
					$skipQuery:=True:C214
				End if 
				
				Case of 
					: ($skipQuery)  //
					: (($strFile="4") | ($strFile="item@"))  //Items
						$pBeg:=Position:C15("Query"; $strFile)
						Case of 
							: ($skipQuery=True:C214)  //ALREADY COMPLETED
							: ($pBeg=0)
								QUERY:C277([Item:4]; [Item:4]publish:60>0)
								$doSearch:=True:C214
							Else 
								$doSearch:=False:C215
								curTableNum:=4
								Srch_FullDia(Table:C252(curTableNum))
						End case 
						
						Case of 
							: (($strField1="45") | ($strField1="vendID"))
								HTML_Distinct(->[Item:4]vendorID:45; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/item_List?vendID="; $theBreaks)
								
							: (($strField1="53") | ($strField1="MfgID"))  //!<!--MfgID--></TD>
								HTML_Distinct(->[Item:4]mfrID:53; -3; ->[Item:4]publish:60; ""; ->aText1)
								$selectList:=Http_FillArray(->aText1)
								
							: (($strField1="26") | ($strField1="itemType") | ($strField1="ItemsProfile0"))  //!<!--P0_Sport--></TD>
								HTML_Distinct(->[Item:4]type:26; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/item_List?itemType="; $theBreaks)
								
							: (($strField1="35") | ($strField1="ItemsProfile1") | ($strField1="Profile1"))  //!<!--P1_Season--></TD>              
								$k:=Size of array:C274(<>aItemsType)
								For ($i; 1; $k)
									If ($doSearch)
										QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
										If ($strField2="")
											QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
											$catStr:="/item_List?itemType="+<>aItemsType{$i}
											$catvalue:=<>aItemsType{$i}
										Else 
											QUERY:C277([Item:4];  & [Item:4]type:26=$strField2)
											$catStr:="/item_List?itemType="+$strField2
											$catvalue:=$strField2
											$i:=$k
										End if 
									Else 
										$i:=$k
									End if 
									HTML_Distinct(->[Item:4]profile1:35; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
									$selectList:=$selectList+(("\r"+"<P>")*Num:C11($selectList#""))+Html_UrlFill(->aText1; "/item_Narrow?itemType="+$catvalue+"?ItemsProfile1="; $theBreaks; $catStr)
								End for 
							: (($strField1="36") | ($strField1="ItemsProfile2") | ($strField1="Profile2"))  //!<!--P2_Item Profile--></TD>
								$k:=Size of array:C274(<>aItemsType)
								For ($i; 1; $k)
									If ($doSearch)
										QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
										If ($strField2="")
											QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
											$catStr:="/item_List?itemType="+<>aItemsType{$i}
											$catvalue:=<>aItemsType{$i}
										Else 
											QUERY:C277([Item:4];  & [Item:4]type:26=$strField2)
											$catStr:="/item_List?itemType="+$strField2
											$catvalue:=$strField2
											$i:=$k
										End if 
									Else 
										$i:=$k
									End if 
									HTML_Distinct(->[Item:4]profile2:36; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
									$selectList:=$selectList+(("\r"+"<P>")*Num:C11($selectList#""))+Html_UrlFill(->aText1; "/item_Narrow?itemType="+$catvalue+"?ItemsProfile2="; $theBreaks; $catStr)
								End for 
							: (($strField1="37") | ($strField1="ItemsProfile3") | ($strField1="Profile3"))  //!<!--P3_Item Profile--></TD>
								$k:=Size of array:C274(<>aItemsType)
								For ($i; 1; $k)
									If ($doSearch)
										QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
										If ($strField2="")
											QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
											$catStr:="/item_List?itemType="+<>aItemsType{$i}
										Else 
											QUERY:C277([Item:4];  & [Item:4]type:26=$strField2)
											$catStr:="/item_List?itemType="+$strField2
											$i:=$k
										End if 
									Else 
										$i:=$k
									End if 
									HTML_Distinct(->[Item:4]profile3:37; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
									$selectList:=$selectList+(("\r"+"<P>")*Num:C11($selectList#""))+Html_UrlFill(->aText1; "/item_Narrow?itemType="+$catvalue+"?ItemsProfile3="; $theBreaks; $catStr)
								End for 
							: (($strField1="38") | ($strField1="ItemsProfile4") | ($strField1="Profile4"))  //!<!--P4_Item Profile--></TD>            
								$k:=Size of array:C274(<>aItemsType)
								For ($i; 1; $k)
									If ($doSearch)
										QUERY:C277([Item:4]; [Item:4]publish:60>0; *)
										If ($strField2="")
											QUERY:C277([Item:4];  & [Item:4]type:26=<>aItemsType{$i})
											$catStr:="/item_List?itemType="+<>aItemsType{$i}
											$catvalue:=<>aItemsType{$i}
										Else 
											QUERY:C277([Item:4];  & [Item:4]type:26=$strField2)
											$catStr:="/item_List?itemType="+$strField2
											$catvalue:=$strField2
											$i:=$k
										End if 
									Else 
										$i:=$k
									End if 
									HTML_Distinct(->[Item:4]profile4:38; -3; ->[Item:4]publish:60; $makeSearch; ->aText1)
									$selectList:=$selectList+(("\r"+"<P>")*Num:C11($selectList#""))+Html_UrlFill(->aText1; "/item_Narrow?itemType="+$catvalue+"?ItemsProfile4="; $theBreaks; $catStr)
								End for 
							Else 
								$found:=False:C215
						End case 
					: (($strFile="58") | ($strFile="TechNote@"))  //TechNote
						Case of 
							: ($strField1="subject@")
								HTML_Distinct(->[TechNote:58]subject:6; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?subject="; $theBreaks; "")
							: ($strField1="author")
								HTML_Distinct(->[TechNote:58]author:10; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?author="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
						
					: (($strFile="23") | ($strFile="Popups@"))  //TechNote
						Case of 
							: ($strField1="subject@")
								HTML_Distinct(->[TechNote:58]subject:6; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?subject="; $theBreaks; "")
							: ($strField1="author")
								HTML_Distinct(->[TechNote:58]author:10; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?author="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
						
					: (($strFile="58") | ($strFile="TechNote@"))  //TechNote
						Case of 
							: ($strField1="subject@")
								HTML_Distinct(->[TechNote:58]subject:6; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?subject="; $theBreaks; "")
							: ($strField1="author")
								HTML_Distinct(->[TechNote:58]author:10; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?author="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
					: (($strFile="58") | ($strFile="TechNote@"))  //TechNote
						Case of 
							: ($strField1="subject@")
								HTML_Distinct(->[TechNote:58]subject:6; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?subject="; $theBreaks; "")
							: ($strField1="author")
								HTML_Distinct(->[TechNote:58]author:10; -3; ->[TechNote:58]publish:11; ""; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/Tech_List?author="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
						
					: ($strFile="FAQ")  //FAQ
						Case of 
							: ($strField1="who")
								HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; "FAQ"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/FAQ_List?who="; $theBreaks; "")
							: ($strField1="topic")
								HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; "FAQ"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/FAQ_List?topic="; $theBreaks; "")
							: ($strField1="subject")
								HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; "FAQ"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/FAQ_List?subject="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
					: ($strFile="Webclerk1")  //Lib 1
						Case of 
							: ($strField1="who")
								HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; "Webclerk1"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/webClerk1?who="; $theBreaks; "")
							: ($strField1="topic")
								HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; "Webclerk1"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/webClerk1?topic="; $theBreaks; "")
							: ($strField1="subject")
								HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; "Webclerk1"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/webClerk1?subject="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
					: ($strFile="Webclerk2")  //Lib 2
						Case of 
							: ($strField1="who")
								HTML_Distinct(->[TallyResult:73]profile1:17; -3; ->[TallyResult:73]publish:36; "Webclerk2"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/webClerk2?who="; $theBreaks; "")
							: ($strField1="topic")
								HTML_Distinct(->[TallyResult:73]profile2:18; -3; ->[TallyResult:73]publish:36; "Webclerk2"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/webClerk2?topic="; $theBreaks; "")
							: ($strField1="subject")
								HTML_Distinct(->[TallyResult:73]profile3:19; -3; ->[TallyResult:73]publish:36; "Webclerk2"; ->aText1)
								$selectList:=Html_UrlFill(->aText1; "/webClerk2?subject="; $theBreaks; "")
							Else 
								$found:=False:C215
						End case 
					: (($strFile="80") | ($strFile="Forum"))  //Forum       
						Case of 
							: ($strField1="who")
								HTML_Distinct(->[Forum:80]fromid:3; -3; ->[Forum:80]publish:7; "")
								$selectList:=Html_UrlFill(->aText1; "/Forum_List?Who="; $theBreaks; ""; ->aText1)
							: ($strField1="topic")
								HTML_Distinct(->[Forum:80]topic:2; -3; ->[Forum:80]publish:7; "")
								$selectList:=Html_UrlFill(->aText1; "/Forum_List?Topic="; $theBreaks; ""; ->aText1)
							: ($strField1="subject")
								HTML_Distinct(->[Forum:80]subject:1; -3; ->[Forum:80]publish:7; "")
								$selectList:=Html_UrlFill(->aText1; "/Forum_List?Subject="; $theBreaks; ""; ->aText1)
							Else 
								$found:=False:C215
						End case 
					Else 
						$found:=False:C215
				End case 
				$pEnd:=Position:C15("<!--jitObjectEnd-->"; $pageIn)
				If ($pEnd>0)
					$pageIn:=Substring:C12($pageIn; $pEnd+19)
					$pageOut:=$pageOut+$jitOBJ+$lineBreak+$selectList+$lineBreak+"<!--jitObjectEnd-->"
				Else 
					$pageOut:=$pageOut+"<!--jitObjectEnd-->"+$pageIn
					$pageIn:=""
				End if 
				$jitOBJ:=""
				$pBeg:=Position:C15("<!--jitObject="; $pageIn)
			End while 
			$pageOut:=$pageOut+$pageIn
			$error:=HFS_Delete($docName)
			If ($error=0)
				myDoc:=Create document:C266($docName; "")
				SEND PACKET:C103(myDoc; $pageOut)
				CLOSE DOCUMENT:C267(myDoc)
				App_SetSuffix(".html.txt"; ".html")
			End if 
		End if 
	End if 
End if 
theText:=""