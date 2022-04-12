//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 110328, 17:43:31
// ----------------------------------------------------
// Method: HTML_SelectWrite
// Description
// --WORKONTHIS--
// 
//
// Parameters
// ----------------------------------------------------
// Modified by: williamjames (110328)

C_LONGINT:C283($i; $k)
C_TEXT:C284($textAdd; $selectList; $tableName; $fieldName)
$k:=Size of array:C274(aFieldLns)
$selectList:=""
If ($k=0)
	BEEP:C151
Else 
	$fileID:=String:C10(curTableNum)
	For ($i; 1; $k)
		// ### bj ### 20181127_1852
		// $theName:=HTML_jitTagMake (0;$fileID;String(theFldNum{aFieldLns{$i}});theFields{aFieldLns{$i}})
		$theName:=Tag_jit_FromNumbers(curTableNum; theFldNum{aFieldLns{$i}}; "rjit_")
		$targetName:=Txt_Quoted(Replace string:C233($theName; "rjit"; "tjit"))
		$selectList:=$selectList+"\r"+"<select class="+Txt_Quoted("12Select")+" name="+$targetName+" jitTitle="+Txt_Quoted(theFields{aFieldLns{$i}})
		$selectList:=$selectList+" jitSourceTable="+Txt_Quoted("zzz")
		$selectList:=$selectList+" jitSourceField="+Txt_Quoted("zzz")
		$selectList:=$selectList+" jitQueryValue="+Txt_Quoted("@")
		$selectList:=$selectList+" jitLevel="+Txt_Quoted("")+" OnChange="+Txt_Quoted("javascript:fillstatus(this, '"+$theName+"')")+">"
		$selectList:=$selectList+"\r"+"</select>"
	End for 
	Case of 
		: (is4DWriteUser=3)
			//**WR INSERT TEXT (eLetterArea;$selectList)
		Else 
			vTextSummary:=$selectList+"\r"+"\r"+vTextSummary
			//SET TEXT TO CLIPBOARD($selectList)
	End case 
End if 