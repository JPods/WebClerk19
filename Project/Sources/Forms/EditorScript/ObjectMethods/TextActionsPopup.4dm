// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-19T00:00:00, 21:21:35
// ----------------------------------------------------
// Method: [Control].SummaryText.Variable21
// Description
// Modified: 11/19/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: ((Form event code:C388=On Load:K2:1) | (aiLoText16=1))
		ARRAY TEXT:C222(aiLoText16; 0)
		APPEND TO ARRAY:C911(aiLoText16; "Fields")
		APPEND TO ARRAY:C911(aiLoText16; "Field Details")
		APPEND TO ARRAY:C911(aiLoText16; "Array from page")
		APPEND TO ARRAY:C911(aiLoText16; "FieldList")
		APPEND TO ARRAY:C911(aiLoText16; "ListBoxObject")
		APPEND TO ARRAY:C911(aiLoText16; "Variables: eMail")
		APPEND TO ARRAY:C911(aiLoText16; "Variables: Record Passing")
		APPEND TO ARRAY:C911(aiLoText16; "Object Map, Partners")
		SORT ARRAY:C229(aiLoText16)
		
		C_LONGINT:C283($tallyMasterBreak)
		$tallyMasterBreak:=TMAppendtoArray("ScriptDrafts"; ->aiLoText16)
		
		INSERT IN ARRAY:C227(aiLoText16; 1; 1)
		aiLoText16{1}:="Text Build:"
		//aiLoText16{7}:="Arrays"
		//aiLoText16{8}:="Programs"
		aiLoText16:=1
		
	Else 
		
		C_LONGINT:C283($error)
		
		C_TEXT:C284($theFile)
		C_LONGINT:C283($i; $k; $cnt)
		C_TEXT:C284($textAdd)
		$k:=Size of array:C274(aFieldLns)
		$textAdd:=""
		C_TEXT:C284($quote)
		$quote:=Char:C90(34)
		C_OBJECT:C1216($obTemp)
		C_LONGINT:C283($i; $k; $viElement)
		$viElement:=aiLoText16
		aiLoText16:=1
		C_LONGINT:C283($tallyMasterBreak)
		$tallyMasterBreak:=Find in array:C230(aiLoText15; "----[TallyMaster]----")
		//TRACE
		Case of 
			: (aiLoText16{$viElement}="ListBoxObject")
				var column_o : Object
				
				
				
			: (aiLoText16{$viElement}="Array from page")
				C_TEXT:C284($vtWord)
				//  $vtParsed:=SE_ArrayFromWebPage
				C_COLLECTION:C1488($cText)
				C_LONGINT:C283($viFound)
				ARRAY LONGINT:C221(aFieldLns; 0)
				$cText:=Split string:C1554(vTextSummary; "\r")
				For each ($vtWord; $cText)
					$viFound:=Find in array:C230(theFields; $vtWord)
					If ($viFound>0)
						APPEND TO ARRAY:C911(aFieldLns; $viFound)
					End if 
				End for each 
				
			: (aiLoText16{$viElement}="FieldList")
				vTextSummary:=FieldList_json(Table name:C256(curTableNum))+"\r"+"\r"+vTextSummary
				
			: (aiLoText16{$viElement}="Object Map")
				$TableNum:=String:C10(curTableNum)
				For ($i; 1; $k)
					$textAdd:=$textAdd+theFields{aFieldLns{$i}}
					If ($i<$k)
						$textAdd:=$textAdd+","
					End if 
				End for 
				jsonListToMapObject(->$obTemp; Table name:C256(curTableNum); $textAdd)
				C_OBJECT:C1216($obPartner)
				// ### bj ### 20200218_1910 compile 18
				OB SET:C1220($obPartner; "Partner1"; $obTemp)
				OB SET:C1220($obPartner; "Partner2"; $obTemp)
				C_OBJECT:C1216($obMap)
				OB SET:C1220($obMap; "maps"; $obPartner)
				
				$textAdd:=""
				vTextSummary:=JSON Stringify:C1217($obMap)+"\r"+"\r"+vTextSummary
				
			: (aiLoText16{$viElement}="----[TallyMaster]----")  //Field List            
				TMTaskOpenTable("ScriptDrafts")
			: (aiLoText16>viTallyMasterArrayElement)  //Field List 
				READ ONLY:C145([TallyMaster:60])
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ScriptDrafts"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=aiLoText16{$viElement})
				C_TEXT:C284($template)
				$template:=[TallyMaster:60]template:29
				ExecuteText(0; [TallyMaster:60]script:9)
				REDUCE SELECTION:C351([TallyMaster:60]; 0)
				vTextSummary:=vTextSummary+"\r"+"\r"+"/////// Template ///////"+"\r"+"\r"+$template
			: (aiLoText16{$viElement}="Fields")  //Field List              
				For ($i; 1; $k)
					$textAdd:=$textAdd+"["+Table name:C256(curTableNum)+"]"+theFields{aFieldLns{$i}}+"\r"
				End for 
				Case of 
					: ((is4DWriteUser=3) & (eLetterArea>0))
						//**WR INSERT TEXT (eLetterArea;$textAdd)
					Else 
						vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
				End case 
			: (aiLoText16{$viElement}="Field Details")  //Field details             
				Draft_FieldDetails
				
			: (aiLoText16{$viElement}="Data Tags")  //Data
				$TableNum:=String:C10(curTableNum)
				For ($i; 1; $k)
					$textAdd:=$textAdd+Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}})+"\r"
					// HTML_jitTagMake (1;$TableNum;String(theFldNum{aFieldLns{$i}});theFields{aFieldLns{$i}})+"\r"
				End for 
				
				//vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
				
			: (aiLoText16{$viElement}="Data_XML")  //Data XML
				$TableNum:=String:C10(curTableNum)
				$textAdd:="<"+Table name:C256(curTableNum)+" DataType="+Txt_Quoted("Table")+">"+"\r"
				For ($i; 1; $k)
					$textAdd:=$textAdd+Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}})+"\r"
				End for 
				$textAdd:=$textAdd+"</"+Table name:C256(curTableNum)+">"+"\r"
				
			: (aiLoText16{$viElement}="List")  //List
				
				$TableNum:=String:C10(curTableNum)
				
				For ($i; 1; $k)
					$textAdd:=$textAdd+theFields{aFieldLns{$i}}+"\t"
				End for 
				$textAdd:=$textAdd+"\r"+"<!--  _jit_begin_"+String:C10(curTableNum)+"_1jj  --> "+"\r"
				For ($i; 1; $k)
					$textAdd:=$textAdd+Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}})+"\t"
				End for 
				$textAdd:=$textAdd+"\r"+"<!--  _jit_end_jj  -->"+"\r"
				
				vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
				
			: (aiLoText16{$viElement}="Lists_XML")  //List XML
				
				$TableNum:=String:C10(curTableNum)
				$textAdd:="<?xml version="+Txt_Quoted("1.0")+" encoding="+Txt_Quoted("UTF-8")+"?>"+"\r"
				$textAdd:=$textAdd+"<"+Table name:C256(curTableNum)+"List DataType="+Txt_Quoted("List")+">"+"\r"
				$textAdd:=$textAdd+"\r"+"_jit_begin_"+String:C10(curTableNum)+"_1jj"+"\r"
				$textAdd:=$textAdd+"<"+Table name:C256(curTableNum)+" DataType="+Txt_Quoted("Table")+">"+"\r"
				For ($i; 1; $k)
					$textAdd:=$textAdd+Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}})+"\r"
				End for 
				$textAdd:=$textAdd+"\r"+"</"+Table name:C256(curTableNum)+">"+"\r"
				$textAdd:=$textAdd+"\r"+"_jit_end_jj"+"\r"+"</"+Table name:C256(curTableNum)+"List>"+"\r"
				vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
				
			: (aiLoText16{$viElement}="Variables: eMail")
				email_DraftVariables
				
				
			: (aiLoText16{$viElement}="Variables: Record Passing")
				RP_DraftParameters
		End case 
		
End case 
aiLoText16:=1