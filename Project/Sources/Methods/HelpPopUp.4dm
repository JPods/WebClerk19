//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/08, 08:50:26
// ----------------------------------------------------
// Method: HelpPopUp
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $helpSource)
C_TEXT:C284($2; $theKeywords)
C_LONGINT:C283($3; $noDialog)
KeyModifierCurrent
$helpSource:=<>viHelpSet
$theKeywords:=""
$noDialog:=0
If (Count parameters:C259>0)
	$helpSource:=$1  // <>viHelpSet, [Default]HelpAction
	If (Count parameters:C259>1)
		$theKeywords:=$2
	End if 
End if 
C_TEXT:C284($helpPath)


C_LONGINT:C283($pageNum)
C_TEXT:C284($pageName; $formName; $tableName; $parametersPass)

C_TEXT:C284($tableName; $currentForm)
$tableName:=Table name:C256(Current form table:C627)
$currentForm:=Current form name:C1298
$pageNum:=FORM Get current page:C276
If ($pageNum<=Size of array:C274(aPages))
	$pageName:=aPages{$pageNum}
Else 
	$pageName:="ns"
End if 
If (OptKey=1)
	OPEN URL:C673("http://www.webclerk.com/Tech_List?"+"tablename="+$tableName+"&form="+$currentForm+"&pagename="+$pageName)
Else 
	<>vTN_OutSide:=$tableName+" "+$currentForm+" "+$pageName
	TN_Dialog
End if 


