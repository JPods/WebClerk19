var $myDoc : Time
var $systemPath_t; $docPath_t; $comExPath_t; $structurePath_t; $tableFormPath : Text

//  https://doc.4d.com/4Dv19/4D/19/System-folder.301-5391699.en.html
$systemPath_t:=System folder:C487
$docPath_t:=System folder:C487(Documents folder:K41:18)
$structurePath_t:=Structure file:C489
$sourceFolder_t:=HFS_GetParent(Structure file:C489)+"Sources"+Folder separator:K24:12
$tableFolder_t:=HFS_GetParent(Structure file:C489)+"Sources"+Folder separator:K24:12+"TableForms"+Folder separator:K24:12

If (Is macOS:C1572)
	$vtDocPath:=HFS_GetParent(Structure file:C489)+"Sources:TableForms:"+String:C10(STR_GetTableNumber(tableName))+":Output:form.4DForm"
Else 
	$vtDocPath:=HFS_GetParent(Structure file:C489)+"Sources\\TableForms\\"+String:C10(STR_GetTableNumber(tableName))+"\\Output\\form.4DForm"
End if 
If ($vtDocPath="")
	$myDoc:=Open document:C264(""; Get pathname:K24:6)
	If (OK=1)
		var $working_t : Text
		CLOSE DOCUMENT:C267($myDoc)
		$vtDocPath:=document
	End if 
End if 
$working_t:=Document to text:C1236($vtDocPath)


19CVT_CaptureOutputFields($working_t)



If (False:C215)
	var $tableFolder_t; $tableMethod_t : Text
	var $cnt; $inc : Integer
	$cnt:=Get last table number:C254
	For ($inc; 1; $cnt)
		$tableFolder_t:=HFS_GetParent(Structure file:C489)+"Sources"+Folder separator:K24:12+"TableForms"+Folder separator:K24:12+String:C10($inc)+Folder separator:K24:12+"Output"+Folder separator:K24:12+"orm.4DForm"
		If (Test path name:C476($vtDocPath)=1)
			$working_t:=Document to text:C1236($vtDocPath)
			tableName:=Table name:C256($inc)
			19CVT_CaptureOutputFields($working_t)
			
			//REF :FORM_InputDSChange
			
		End if 
	End for 
End if 