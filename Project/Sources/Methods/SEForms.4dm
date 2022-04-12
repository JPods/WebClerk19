//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/08/18, 18:49:35
// ----------------------------------------------------
// Method: SEForms
// Description
// 
//
// Parameters
// ----------------------------------------------------
// zzzNotUsedAnyWhere

C_LONGINT:C283($i; $k)
C_TEXT:C284($textAdd)
$k:=Size of array:C274(aFieldLns)
If (Size of array:C274(atTableHTML)=0)
	C_TEXT:C284(labelText; fieldText)
	labelText:="<div class="+Txt_Quoted("form-group")+">"+"\r"+"<label for="+Txt_Quoted(theFields{aFieldLns{$i}})+">"+"\r"
	atTableHTML{1}:="<table id="+Txt_Quoted("myTable1")+" class="+Txt_Quoted("tableStandard tablesorter")+">"
	atTableHTML{2}:="<tr>"
	atTableHTML{3}:="<td>"
End if 
Case of 
	: ($k>0)
		$fileID:=String:C10(curTableNum)
		
		$textAdd:="<form action="+Txt_Quoted("/WCC_SaveRec")+" method="+Txt_Quoted("get")+">"+"\r"
		$textAdd:=$textAdd+"<input type="+Txt_Quoted("hidden")+" name="+Txt_Quoted("TableName")+" value="+Txt_Quoted(Table name:C256(curTableNum))+">"+"\r"
		$textAdd:=$textAdd+"<input type="+Txt_Quoted("hidden")+" name="+Txt_Quoted("RecordNum")+" value="+Txt_Quoted(Tag_jit_FromNumbers(curTableNum; -2))+">"+"\r"
		
		If (False:C215)
			$textAdd:=$textAdd+"<input type="+Txt_Quoted("hidden")+" name="+Txt_Quoted("jitxUser")+" value="+Txt_Quoted("_jit_0_vleventIDjj")+">"+"\r"
		End if 
		$textAdd:=$textAdd+atTableHTML{1}
		For ($i; 1; $k)
			$textAdd:=$textAdd+"\r"+"  <tr>"
			If (OptKey=0)
				$textAdd:=$textAdd+"\r"+"    "+"<td class="+Txt_Quoted("tdLabel")+">"+theFields{aFieldLns{$i}}+"</td>"
			Else 
				$textAdd:=$textAdd+"\r"+"    "+"<td>"+theFields{aFieldLns{$i}}+"</td>"
			End if 
			C_TEXT:C284($valueTag; $returnTag)
			// ### bj ### 20181127_1852   $valueTag:=HTML_jitTagMake (0;$fileID;String(theFldNum{aFieldLns{$i}});theFields{aFieldLns{$i}})
			$valueTag:=Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}})
			$returnTag:="r"+Substring:C12($valueTag; 2)
			$textAdd:=$textAdd+"\r"+"    "+"<td><input type="+Txt_Quoted("text")+" name="+Txt_Quoted($returnTag)+" value="+Txt_Quoted($valueTag)+" Size="+Txt_Quoted("65")+" id="+Txt_Quoted(theFields{aFieldLns{$i}})+"></td>"
			$textAdd:=$textAdd+"\r"+"  "+"</tr>"
		End for 
		$textAdd:=$textAdd+"\r"+"</table>"+"\r"+"<input type="+Txt_Quoted("submit")+"  name="+Txt_Quoted("SUBMIT")+" value="+Txt_Quoted("Send")+">"
		$textAdd:=$textAdd+"\r"+"</form>"
End case 
Case of 
	: ((is4DWriteUser=3) & (eLetterArea>0))
		// WR INSERT TEXT (eLetterArea;$textAdd)
	Else 
		vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
End case 


//vText:=$textAdd
//Insert string(vText;$textAdd)