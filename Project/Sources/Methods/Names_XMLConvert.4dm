//%attributes = {}
C_TEXT:C284($vtRaw; $vtOutput; $vtChanges; $vtPathxml; $vtPathChanges)
C_LONGINT:C283($findTable; $findField)
C_TIME:C306($docTime)

ARRAY TEXT:C222($aArrayLine; 0)
ARRAY TEXT:C222($aArrayDoc; 0)
C_LONGINT:C283($incDoc; $cntDoc; $incTable; $incField)
C_LONGINT:C283($incLine; $cntLine)
C_TIME:C306($myDoc; $changeDoc; $saveDoc)
TRACE:C157
//ALERT("Open XML")
//$vtPathxml:=Convert path POSIX to system("/Applications/4D v18 R5/Renaming/ComEx18-oa-edited.xml")
//$vtPathChanges:=Convert path POSIX to system("/Applications/4D v18 R5/Renaming/ReNameTables_2021-02-09.txt")
$myDoc:=Open document:C264(""; Read mode:K24:5)
If (OK=1)
	CLOSE DOCUMENT:C267($myDoc)
	$vtXML:=Document to text:C1236(Document)
	//ALERT("Open Changes")
	//$vtPathChanges:=""
	//$changeDoc:=Open document($vtPathChanges; Read mode)
	//If (OK=1)
	//CLOSE DOCUMENT($changeDoc)
	//$vtChanges:=Document to text(Document)
	//If (OK=1)
	
	$vtXML:=CamelCase_FixCatalog($vtXML)
	
	$saveDoc:=Create document:C266("")
	If (OK=1)
		CLOSE DOCUMENT:C267($saveDoc)
		TEXT TO DOCUMENT:C1237(Document; $vtXML)
	End if 
End if 


If (False:C215)
	TextToArray($vtChanges; ->$aArrayDoc; "\r")
	$cntRay:=Size of array:C274($aArrayDoc)
	For ($incRay; 1; $cntRay)
		TextToArray($aArrayDoc{$incRay}; ->$aArrayLine)
		If (Size of array:C274($aArrayLine)>1)
			$vtXML:=Replace string:C233($vtXML; "name=\""+$aArrayLine{1}+"\""; "name=\""+$aArrayLine{2}+"\"")
		End if 
	End for 
	
End if 
// zzz
//dSync
//WOTemplateTasks
//WebClerkDevices