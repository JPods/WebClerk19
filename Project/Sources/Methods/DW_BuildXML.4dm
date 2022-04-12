//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: ancient
// ----------------------------------------------------
// Method: DW_BuildXML
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k)
C_TEXT:C284($textAdd; $selectList; $tableName; $fieldName)
$k:=Size of array:C274(aFieldLns)
$selectList:=""
KeyModifierCurrent
If ($k=0)
	BEEP:C151
Else 
	For ($i; 1; $k)
		$tableName:=Substring:C12(Table name:C256(curTableNum); 1; 7)
		If (Length:C16($tableName)<7)
			$tableName:=$tableName+("_"*(7-Length:C16($tableName)))
		End if 
		$fieldName:=Substring:C12(Field name:C257(curTableNum; theFldNum{aFieldLns{$i}}); 1; 13)
		$textAdd:=$tableName+String:C10(curTableNum; "000")+"_"+String:C10(theFldNum{aFieldLns{$i}}; "000")+$fieldName
		//If (Length($textAdd)>25)
		//$textAdd:=Substring($textAdd;1;25)+String(theFldNum{aFieldLns{$i}};
		//"00")
		//End if   
		If (OptKey=1)
			$selectList:=$selectList+"<tagspec tag_name="+Txt_Quoted(HTML_jitTagMake(3; String:C10(curTableNum); String:C10(theFldNum{aFieldLns{$i}}); Field name:C257(curTableNum; theFldNum{aFieldLns{$i}})))
		Else 
			$selectList:=$selectList+"<tagspec tag_name="+Txt_Quoted(HTML_jitTagMake(1; String:C10(curTableNum); String:C10(theFldNum{aFieldLns{$i}}); Field name:C257(curTableNum; theFldNum{aFieldLns{$i}})))
		End if 
		$selectList:=$selectList+"\t"+"start_string="+Txt_Quoted(<>jitTag+String:C10(curTableNum)+<>midTag)
		$selectList:=$selectList+"\t"+"end_string="+Txt_Quoted(String:C10(theFldNum{aFieldLns{$i}})+<>endTag)
		$selectList:=$selectList+"\t"+"content_model="+Txt_Quoted("marker_model")
		$selectList:=$selectList+"\t"+"tag_Type="+Txt_Quoted("nonempty")
		$selectList:=$selectList+"\t"+"detect_in_attribute="+Txt_Quoted("false")
		$selectList:=$selectList+"></tagspec>"+"\r"
		If (False:C215)
			$selectList:=$selectList+"<tagspec tag_name="+"\""+$textAdd+"\""
			$selectList:=$selectList+"\t"+"content_model="+"\""+"marker_model"+"\""
			$selectList:=$selectList+"\t"+"start_string="+"\""+<>jitTag+String:C10(curTableNum)+"_"+"\""
			$selectList:=$selectList+"\t"+"end_string="+"\""+String:C10(theFldNum{aFieldLns{$i}})+"_"+"\""
			$selectList:=$selectList+"\t"+"detect_in_attribute="+"\""+"false"+"\""+"\t"+"icon="+"\""+$textAdd+".gif"+"\""
			$selectList:=$selectList+"\t"+"icon_width="+"\""+"125"+"\""+"\t"+"icon_height="+"\""+"11"+"\""+"></tagspec>"+"\r"
		End if 
		If (False:C215)
			$selectList:=$selectList+"<tagspec tag_name="+"\""+$textAdd+"\""
			$selectList:=$selectList+"\t"+"content_model="+"\""+"script_model"+"\""+"></tagspec>"
			$selectList:=$selectList+"\t"+"start_string="+"\""+<>jitTag+String:C10(curTableNum)+"_"+"\""
			$selectList:=$selectList+"\t"+"end_string="+"\""+String:C10(theFldNum{aFieldLns{$i}})+"_"+"\""
			$selectList:=$selectList+"\t"+"detect_in_attribute="+"\""+"true"+"\""+"\t"+"icon="+"\""+$textAdd+".gif"+"\""
			$selectList:=$selectList+"\t"+"icon_width="+"\""+"125"+"\""+"\t"+"icon_height="+"\""+"11"+"\""+"\r"
		End if 
		If (False:C215)
			$selectList:=$selectList+"<tagspec tag_name="+"\""+$textAdd+<>vQuot
			$selectList:=$selectList+"\t"+"start_string="+"\""+<>jitTag+String:C10(curTableNum)+"_"+"\""
			$selectList:=$selectList+"\t"+"end_string="+"\""+String:C10(theFldNum{aFieldLns{$i}})+"_"+"\""
			$selectList:=$selectList+"\t"+"detect_in_attribute="+"\""+"true"+"\""+"\t"+"icon="+"\""+$textAdd+".gif"+"\""
			$selectList:=$selectList+"\t"+"icon_width="+"\""+"125"+"\""+"\t"+"icon_height="+"\""+"11"+"\""
			$selectList:=$selectList+"\t"+"content_model="+"\""+"script_model"+"\""+"></tagspec>"+"\r"
		End if 
	End for 
	Case of 
		: (is4DWriteUser=3)
			////**WR INSERT TEXT (eLetterArea;$selectList)
		Else 
			vTextSummary:=$selectList+"\r"+"\r"+vTextSummary
			//SET TEXT TO CLIPBOARD($selectList)
	End case 
End if 

If (False:C215)
	C_LONGINT:C283($i; $k)
	C_TEXT:C284($textAdd; $selectList; $tableName)
	$k:=Size of array:C274(aFieldLns)
	$selectList:=""
	TRACE:C157
	If ($k=0)
		BEEP:C151
	Else 
		For ($i; 1; $k)
			$tableName:=Substring:C12(Table name:C256(curTableNum); 1; 7)
			If (Length:C16($tableName)<7)
				$tableName:=$tableName+("_"*(7-Length:C16($tableName)))
			End if 
			$textAdd:=$tableName+String:C10(curTableNum; "000")+"_"+String:C10(theFldNum{aFieldLns{$i}}; "000")+Substring:C12(theFields{aFieldLns{$i}}; 1; 13)
			//If (Length($textAdd)>25)
			//$textAdd:=Substring($textAdd;1;25)+String(theFldNum{aFieldLns{$i}};
			//"00")
			//End if 
			$selectList:=$selectList+"<tagspec tag_name="+"\""+$textAdd+"\""
			$selectList:=$selectList+"\t"+"start_string="+"\""+<>jitTag+String:C10(curTableNum)+"_"+String:C10(theFldNum{aFieldLns{$i}})+"\""
			$selectList:=$selectList+"\t"+"end_string="+"\""+"_j_"+"\""+"\t"+"detect_in_attribute="+"\""+"true"+"\""
			$selectList:=$selectList+"\t"+"icon="+"\""+$textAdd+".gif"+"\""
			$selectList:=$selectList+"\t"+"icon_width="+"\""+"125"+"\""+"\t"+"icon_height="+"\""+"11"+"\""
			$selectList:=$selectList+"\t"+"content_model="+"\""+"script_model"+"\""+"></tagspec>"+"\r"
		End for 
		
	End if 
End if 