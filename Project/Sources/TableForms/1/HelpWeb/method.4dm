// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-08-13T00:00:00, 00:27:06
// ----------------------------------------------------
// Method: [Control].HelpWeb
// Description
// Modified: 08/13/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Load:K2:1)
	ARRAY TEXT:C222(aiLoText1; 6)
	aiLoText1{1}:="All Sources"
	aiLoText1{2}:="Company and Local"
	aiLoText1{3}:="WebClerk"
	aiLoText1{4}:="Company"
	aiLoText1{5}:="Local Machine"
	aiLoText1{6}:="Other"
	aiLoText1:=3
	iLoText1:=aiLoText1{aiLoText1}
	
	ARRAY TEXT:C222(aiLoText3; 4)
	aiLoText3{1}:="Input"
	aiLoText3{2}:="Output"
	aiLoText3{3}:="Splash"
	aiLoText3{4}:="Special"
	
	iLoText1:=""
	iLoText2:=""
	iLo35String1:=""
	iLo35String2:=""
	iLo35String3:=""
	iLo35String4:=""
	$theKeywords:=""
	$theCommand:=""
	// 
	C_POINTER:C301($ptTable)
	
	//$ptTable:=Current form table//provides a pointer to the table of this form
	$theTableName:=Table name:C256(ptCurTable)
	iLo35String1:=$theTableName
	If (vHere>1)
		iLo35String4:=String:C10(aPages)  //$thePage
	Else 
		iLo35String4:=""
	End if 
	
	iLo35String3:="Input"
	
	jaFilesInitial(False:C215; False:C215)  //restricted access; auto load search field  
	Fld_ALDefine(eExportFlds)
	
	If (vHere=1)
		$theCommand:="Tech_List?TableName="+iLo35String1+"&form=output&keyword="+iLoText1
	Else 
		If ($ptTable=(->[Control:1]))
			$theKeywords:="Control_Table,dialog_layout&page="+iLo35String3
			$theCommand:="Tech_List?TableName="+iLo35String1+"&form=input&page="+iLo35String3+("_iLoPage"*(Num:C11(iLo35String3#"")))+"&keyword="+iLoText1
		Else 
			$theKeywords:=$theTableName+"_Table,input_layout,"+iLo35String3
			$theCommand:="Tech_List?TableName="+iLo35String1+"&form=input&page="+iLo35String3+("_iLoPage"*(Num:C11(iLo35String3#"")))+"&keyword="+iLoText1
		End if 
	End if 
	
End if 


iLoText2:="Tech_List?TableName="+iLo35String1+"&field="+iLo35String2+"&form="+iLo35String3+"&page="+iLo35String4+"&keyword="+iLoText1
