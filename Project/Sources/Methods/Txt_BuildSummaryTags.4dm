//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/02/09, 14:55:26
// ----------------------------------------------------
// Method: Txt_BuildSummaryTags
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($theFile)




If ((Form event code:C388=On Load:K2:1) | (aiLoText15=1))
	ARRAY TEXT:C222(aiLoText15; 0)
	
	APPEND TO ARRAY:C911(aiLoText15; "Find Uniques")
	APPEND TO ARRAY:C911(aiLoText15; "FldChar Allow Change")
	APPEND TO ARRAY:C911(aiLoText15; "FldChar Protect Read")
	APPEND TO ARRAY:C911(aiLoText15; "HTML Data")
	APPEND TO ARRAY:C911(aiLoText15; "HTML Form")
	APPEND TO ARRAY:C911(aiLoText15; "HTML Lists")
	APPEND TO ARRAY:C911(aiLoText15; "HTML Tabular Table")
	APPEND TO ARRAY:C911(aiLoText15; "javascript Data/Submit")
	
	//APPEND TO ARRAY(aiLoText15; "Item Links by typeID")
	//APPEND TO ARRAY(aiLoText15; "Select")
	//APPEND TO ARRAY(aiLoText15; "URL Link Lists")
	//APPEND TO ARRAY(aiLoText15; "URL Keyword Pages")
	//APPEND TO ARRAY(aiLoText15; "URL Lists Support")
	//APPEND TO ARRAY(aiLoText15; "URL from Word Lists")
	//APPEND TO ARRAY(aiLoText15; "XML DreamWeaver")
	APPEND TO ARRAY:C911(aiLoText15; "XML Table")
	APPEND TO ARRAY:C911(aiLoText15; "XML List")
	APPEND TO ARRAY:C911(aiLoText15; "Meta Tags")
	// append to array(aiLoText15;"Wiki List")
	// append to array(aiLoText15;"Foundation Head")
	// append to array(aiLoText15;"Foundation 3 Search")
	
	// append to array(aiLoText15;"Foundation Data")
	// append to array(aiLoText15;"Foundation Form")
	// append to array(aiLoText15;"Foundation List")
	// APPEND TO ARRAY(aiLoText15;"Foundation PopUp")
	
	SORT ARRAY:C229(aiLoText15)
	
	C_LONGINT:C283($tallyMasterBreak)
	$tallyMasterBreak:=TMAppendtoArray("ScriptEditorHTML"; ->aiLoText15)
	
	INSERT IN ARRAY:C227(aiLoText15; 1; 1)
	aiLoText15{1}:="HTML Build:"
	aiLoText15:=1
	
	
	
Else 
	KeyModifierCurrent
	//TRACE
	C_LONGINT:C283($error)
	//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)
	$theText:=vTextSummary
	
	C_LONGINT:C283($i; $k; $viElement)
	$viElement:=aiLoText15
	aiLoText15:=1
	C_TEXT:C284($textAdd)
	C_TEXT:C284($tableName)
	$tableName:=Table name:C256(curTableNum)
	$k:=Size of array:C274(aFieldLns)
	$textAdd:=""
	C_TEXT:C284($quote)
	C_TEXT:C284($textResult)
	C_TEXT:C284($clip1; $clip2)
	$quote:=Char:C90(34)
	C_LONGINT:C283($tallyMasterBreak)
	$tallyMasterBreak:=Find in array:C230(aiLoText15; "----[TallyMaster]----")
	
	Case of 
		: (aiLoText15{$viElement}="----[TallyMaster]----")
			TMTaskOpenTable("ScriptEditorHTML")
			
		: ($viElement>$tallyMasterBreak)  //Data     
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ScriptEditorHTML"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=aiLoText15{$viElement})
			C_TEXT:C284($template; $script)
			$template:=[TallyMaster:60]template:29
			$script:=[TallyMaster:60]script:9
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
			ExecuteText(0; $script)
			vTextSummary:=vTextSummary+"\r"+"\r"+"/////// Template ///////"+"\r"+"\r"+$template
		: (aiLoText15{$viElement}="HTML Tabular Table")  //Data    
			$vtJavaScript:=HTML_TabularTable
			vTextSummary:=$vtJavaScript+"\r"+"\r"+vTextSummary
			
		: (aiLoText15{$viElement}="HTML Data")  //Data    
			C_TEXT:C284($vtjavaScript)
			
			Case of 
				: ($k>0)
					
					
					
					
					$strTableNum:=String:C10(curTableNum)
					$textAdd:=Replace string:C233(atTableHTML{1}; "dataTable-zzzTableName"; "dataTable-"+$tableName)
					For ($i; 1; $k)
						$textAdd:=$textAdd+"\r"+"  <tr>"
						$textAdd:=$textAdd+"\r"+"    "+"<td class="+Txt_Quoted("tdLabel")+">"+theFields{aFieldLns{$i}}+"</td>"
						C_TEXT:C284($clip1)
						// $clip1:=HTML_jitTagMake (1;$strTableNum;String(theFldNum{aFieldLns{$i}});theFields{aFieldLns{$i}})
						$valueTag:=Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}}; "_jit_")
						$textAdd:=$textAdd+"<td "+" id=\"2"+$tableName+"_"+theFields{aFieldLns{$i}}+"\"></td>"
						$textAdd:=$textAdd+"\r"+"  "+"</tr>"
					End for 
					$textAdd:=$textAdd+"\r"+"</table>"
			End case 
			// ### bj ### 20201027_2351
			vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
		: (aiLoText15{$viElement}="HTML Form")  //Form
			C_LONGINT:C283($i; $k)
			C_TEXT:C284($textAdd)
			$k:=Size of array:C274(aFieldLns)
			If ($k>0)
				C_TEXT:C284($vtLineConfig)
				C_OBJECT:C1216($vObLineConfig)
				// $textAdd:=SE_javaScriptLoadSubmit 
				// $textAdd:=$textAdd+"\r"+"\r"+"\r"
				$textAdd:=""
				C_TEXT:C284($vtLayout)
				$vtLayout:=""
				$strTableNum:=String:C10(curTableNum)
				$textAdd:=$textAdd+" function form"+$tableName+"() {\r "
				$textAdd:=$textAdd+(3*" ")+"let cfg = {\r"
				$textAdd:=$textAdd+(5*" ")+"url = \"/WCC_SaveRec\",\r"
				$textAdd:=$textAdd+(5*" ")+"divId = \"form"+$tableName+"Area\",\r"
				$textAdd:=$textAdd+(5*" ")+"title = \""+$tableName+" Form\",\r"
				$textAdd:=$textAdd+(5*" ")+"fields = [\r"
				For ($i; 1; $k)
					// $vObLineConfig:=ds.FieldConfig.query("ParentName = "+$tableName+", FieldName = "+theFields{aFieldLns{$i}}).first()
					QUERY:C277([FieldConfig:126]; [FieldConfig:126]parentName:2=$tableName; *)
					QUERY:C277([FieldConfig:126];  & ; [FieldConfig:126]fieldName:4=theFields{aFieldLns{$i}})
					// If ($vObLineConfig#Null)
					If (Records in selection:C76([FieldConfig:126])>0)
						FIRST RECORD:C50([FieldConfig:126])
						$vtLineConfig:=JSON Stringify:C1217([FieldConfig:126]definition:1)
					Else 
						
						C_TEXT:C284($vtType)
						C_OBJECT:C1216($voFieldDefinition)
						
						$voFieldDefinition:=STR_GetFieldDefinition($tableName; theFields{aFieldLns{$i}})
						$vtType:=OB Get:C1224($voFieldDefinition; "type")
						// ### bj ### 20210211_0218  QQQQZZZZ
						// this is terrible
						// $vtType:=STR_GetFieldTypeWeb($tableName; theFields{aFieldLns{$i}})
						$vtLineConfig:="{ name: \""+theFields{aFieldLns{$i}}+"\", title: \""+theFields{aFieldLns{$i}}+"\", type: \""+$vtType+"\" }"
						If ($i<$k)
							$textAdd:=$textAdd+(8*" ")+$vtLineConfig+",\r"
							$vtLayout:=$vtLayout+(8*" ")+"[{ name: \""+theFields{aFieldLns{$i}}+"\", col: 12}],\r"
						Else 
							$textAdd:=$textAdd+(8*" ")+$vtLineConfig+"\r"
							$vtLayout:=$vtLayout+(8*" ")+"[{ name: \""+theFields{aFieldLns{$i}}+"\", col: 12}]\r"
						End if 
					End if 
				End for 
				$textAdd:=$textAdd+(5*" ")+"],\r"
				$textAdd:=$textAdd+(5*" ")+"extras: {\r"
				$textAdd:=$textAdd+(8*" ")+"returnField:  ,\r"
				$textAdd:=$textAdd+(8*" ")+"returnValue: ,\r"
				$textAdd:=$textAdd+(8*" ")+"returnPage: ,\r"
				$textAdd:=$textAdd+(8*" ")+"TableName: \""+$tableName+"\",\r"
				$textAdd:=$textAdd+(8*" ")+"Field1: ,\r"
				$textAdd:=$textAdd+(8*" ")+"Operator1: \"equal\",\r"
				$textAdd:=$textAdd+(8*" ")+"jitPageOne: ,\r"
				$textAdd:=$textAdd+(8*" ")+"jitPageList: \r"
				$textAdd:=$textAdd+(5*" ")+"},\r"
				
				$textAdd:=$textAdd+(5*" ")+"layout: [\r"
				$textAdd:=$textAdd+$vtLayout
				$textAdd:=$textAdd+(5*" ")+"]\r"
				$textAdd:=$textAdd+(3*" ")+"}\r"
				$textAdd:=$textAdd+(3*" ")+"addForm(cfg);\r"
				$textAdd:=$textAdd+"}\r"
				
				
				
			End if 
			
			vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
			
			
		: (aiLoText15{$viElement}="javascript Data/Submit")
			$vtJavaScript:=SE_javaScriptLoadSubmit
			
			vTextSummary:=$vtJavaScript+"\r"+"\r"+vTextSummary
			
		: (aiLoText15{$viElement}="javascript Submit")
			C_TEXT:C284($vtJavaScript)
			
			
		: (aiLoText15{$viElement}="javascript Form")
		: (aiLoText15{$viElement}="javascript Lists")
			
			
		: (aiLoText15{$viElement}="HTML Lists")  //List
			Case of 
				: ($k=0)
					BEEP:C151
				: ($k>0)
					C_TEXT:C284($tableName)
					$strTableNum:=String:C10(curTableNum)
					
					
					$textAdd:=Replace string:C233(atTableHTML{1}; "dataTable-zzzTableName"; "dataTable-"+$tableName)+"\r"+"<thead>"+"\r"+"  "+atTableHTML{2}
					
					If (OptKey=0)
						$textAdd:=$textAdd+"\r"+"<th class="+Txt_Quoted("ttGoTo")+">GoTo</th>"
					End if 
					C_TEXT:C284($theAlignment)
					C_TEXT:C284($vtext1; $vtext2)
					
					// ### bj ### 20200222_1630  set the headers differently than body, 
					//  rewrite this whole thing to be based on variables.
					$vtext1:="td"
					$vtext2:="tt"
					For ($i; 1; $k)
						// ### bj ### 20190903_2031
						$theAlignment:=HTML_Alignment(Field:C253(curTableNum; theFldNum{aFieldLns{$i}}))
						$theAlignment:=Replace string:C233($theAlignment; "<td"; "<th")
						$theAlignment:=Replace string:C233($theAlignment; $vtext1; $vtext2)
						
						$textAdd:=$textAdd+"\r"+"    "+$theAlignment+theFields{aFieldLns{$i}}+"</th>"
					End for 
					
					$textAdd:=$textAdd+"\r"+"  </tr>"+"\r"+"</thead>"
					$textAdd:=$textAdd+"\r"+"<tfoot>"+"\r"+"<tr>"+"\r"+($k*("<td>&nbsp;</td>"+"\r"))+"</tr>"+"\r"+"</tfoot>"
					// $textAdd:=$textAdd+"\r"+"<tbody>"+"\r"+"<!-- _jit_begin_"+String(curTableNum)+"_1"+<>endTag+" -->"+"\r"+"  <tr>"
					$textAdd:=$textAdd+"\r"+"<tbody>"+"\r"
					
					$textAdd:=$textAdd+"<!-- _jit_begin_"+$tableName+"_1"+<>endTag+" -->"+"\r"+"  <tr>"
					
					
					If (OptKey=0)
						C_TEXT:C284($gotoStr)
						// $gotoStr:="/Wcc_QueryRecordNum?TableName="+$tableName+"&RecordNum=_jit_"+String(curTableNum)+"_-2jj&jitPageOne=Wcc"+Table name(curTableNum)+"One.html"
						$gotoStr:="/Wcc_QueryUUIDKey?TableName="+$tableName+"&RecordNum=_jit_"+$tableName+"_RecordNumjj&jitPageOne=Wcc"+$tableName+"One.html"
						$textAdd:=$textAdd+"\r"+"<td class="+Txt_Quoted("tdGoTo")+"><a href="+Txt_Quoted($gotoStr)+">GoTo</a></td>"
					Else 
						// $gotoStr:="/Search_Table?TableName="+Table name(curTableNum)+"&RecordNum=_jit_"+String(curTableNum)+"_-2jj&jitPageOne="+Table name(curTableNum)+"One.html"
						$gotoStr:="/Search_Table?TableName="+Table name:C256(curTableNum)+"&RecordNum=_jit_"+$tableName+"__RecordNumjjjj&jitPageOne="+$tableName+"One.html"
						$textAdd:=$textAdd+"\r"+"<td class="+Txt_Quoted("tdGoTo")+"><a href="+Txt_Quoted($gotoStr)+">GoTo</a></td>"
						//zzz consider making this dependent on a metatag on the page listing tables allowed to search by RecordNumber
						// Modified by: williamjames (12/12/10)
					End if 
					$forceSpace:=""
					If (CmdKey=1)
						$forceSpace:="&nbsp;"
					End if 
					
					//  if($loop=1)
					For ($i; 1; $k)
						
						$theAlignment:=HTML_Alignment(Field:C253(curTableNum; theFldNum{aFieldLns{$i}}))
						
						$textAdd:=$textAdd+"\r"+"    "+$theAlignment+$forceSpace+Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}}; "_jit_")+"</td>"  // ### bj ### 20181127_1907     <!--"+theFields{aFieldLns{$i}}+"-->"
					End for 
					
					$textAdd:=$textAdd+"\r"+"  </tr>"+"\r"+"<!-- "+<>jitTag+"end"+<>midTag+<>endTag+"-->"+"\r"+"</tbody>"
					$textAdd:=$textAdd+"\r"+"</table>"
			End case 
			
			$textAdd:=$textAdd+"\r"+"\r"+"\r"+"\r"
			
			
			// ### bj ### 20190903_1434  this will be replaced by a json 
			If (False:C215)
				// Else 
				C_TEXT:C284($vtJavaScript)
				$vtJavaScript:="<script>\r"
				$vtJavaScript:=$vtJavaScript+"$(document).ready(function(){\r"
				$vtJavaScript:=$vtJavaScript+"   $.getJSON(\""+$tableName+".json\", function(data){\r"
				$vtJavaScript:=$vtJavaScript+"      var ("+$tableName+"_data =- '';\r"
				$vtJavaScript:=$vtJavaScript+"      $.each(data, function(key, value) {\r"
				$vtJavaScript:=$vtJavaScript+"         "+$tableName+"_data += '<tr>';\r"
				
				$vtJavaScript:=$vtJavaScript+"         "+$tableName+"_data += '<td><a href=\"somelink-fixthis\">'+value."+"FILLIN"+"+'</a></td>';\r"
				For ($i; 1; $k)
					$vtJavaScript:=$vtJavaScript+"         "+$tableName+"_data += '<td>'+value."+HTML_jitTagMake(1; $strTableNum; String:C10(theFldNum{aFieldLns{$i}}); theFields{aFieldLns{$i}})+"+'</td>';\r"
				End for 
				$vtJavaScript:=$vtJavaScript+"         "+$tableName+"_data += '</tr>';\r"
				$vtJavaScript:=$vtJavaScript+"      ]);\r"
				$vtJavaScript:=$vtJavaScript+"      $('#dataTable-"+$tableName+"'),append("+$tableName+"+_data);\r"
				$vtJavaScript:=$vtJavaScript+"   ]);\r"
				$vtJavaScript:=$vtJavaScript+"]);\r"
				$vtJavaScript:=$vtJavaScript+"</script>\r"
				// End if 
				
				$textAdd:=$textAdd+"\r"+"\r"+"\r"+$vtJavaScript
				
			End if 
			
			vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
			
		: (aiLoText15{$viElement}="URL Link Lists")  //URL List
			Html_URL_Draft
		: (aiLoText15{$viElement}="Item Links by typeID")  //URL List All items
			Html_URLItemPage
		: (aiLoText15{$viElement}="URL Keyword Pages")  //URL List All items
			// HTML_URLItemKeywords 
			// replaced by the general Words feature
		: (aiLoText15{$viElement}="URL Lists Support")  //URL List By Keywords
			Html_URLSupportPage
		: (aiLoText15{$viElement}="DreamWeaver XML")  //URL List All Support
			DW_BuildXML
		: (aiLoText15{$viElement}="Select")  //Select
			HTML_SelectWrite
			
		: (aiLoText15{$viElement}="Find Uniques")  //Uniques
			TRACE:C157
			If (OptKey=0)
				If (curTableNum>0)
					If (Size of array:C274(aFieldLns)>0)
						ARRAY TEXT:C222($aText1; 0)
						ALL RECORDS:C47(Table:C252(curTableNum)->)
						DISTINCT VALUES:C339(Field:C253(curTableNum; theFldNum{aFieldLns{1}})->; $aText1)
						$k:=Size of array:C274($aText1)
						For ($i; 1; $k)
							$textAdd:=$textAdd+$aText1{$i}+"\r"
						End for 
					End if 
				End if 
			Else 
				$textAdd:=KWDistinct($theText; ", ")
			End if 
			Case of 
				: ((is4DWriteUser=3) & (eLetterArea>0))
					//**WR INSERT TEXT (eLetterArea;$textAdd)
				Else 
					vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
			End case 
		: (aiLoText15{$viElement}="XML Table")  //Draft XML Table
			C_TEXT:C284($returnText)
			$returnText:=XML_DraftTable(String:C10(curTableNum))
		: (aiLoText15{$viElement}="XML List")  //Draft XML List
			C_TEXT:C284($returnText)
			$returnText:=XML_DraftList(String:C10(curTableNum))
		: (aiLoText15{$viElement}="Meta Tags")  //Draft XML List
			C_TEXT:C284($returnText)
			$returnText:=HTMLMetaTags
			
			Case of 
				: ((is4DWriteUser=3) & (eLetterArea>0))
					//**WR INSERT TEXT (eLetterArea;$returnText)
				Else 
					vTextSummary:=$returnText+"\r"+"\r"+vTextSummary
			End case 
			
			
		: (aiLoText15{$viElement}="Foundation Head")  //Draft XML List
			
			C_TEXT:C284($returnText)
			$returnText:=HTMLHead
			
			
			Case of 
				: ((is4DWriteUser=3) & (eLetterArea>0))
					//**WR INSERT TEXT (eLetterArea;$returnText)
				Else 
					vTextSummary:=$returnText+"\r"+"\r"+vTextSummary
			End case 
			
			
		: (aiLoText15{$viElement}="Wiki List")  //Draft Wiki List
			If ($k>0)
				Wiki_TxtList
			End if 
			
			
		Else 
			BEEP:C151
			BEEP:C151
	End case 
	
End if 
