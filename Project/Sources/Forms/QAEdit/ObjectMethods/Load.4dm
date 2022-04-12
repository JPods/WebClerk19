var $docPath; $working_t : Text
$docPath:=Storage:C1525.folder.jitExportsF+"Anwers.txt"
If (Test path name:C476($docPath)#1)
	$myDoc:=Create document:C266($docPath)
	CLOSE DOCUMENT:C267($myDoc)
	AE_LaunchDoc(document)
Else 
	var $c; $c2; $c3 : Collection
	$c2:=New collection:C1472
	$c3:=New collection:C1472
	$working_t:=Document to text:C1236($docPath)
	$c:=Split string:C1554($working_t; "\r")
	$c2:=$c.distinct()
	For each ($anwer_t; $c2)
		$c3.push(New object:C1471("answer"; $anwer_t))
	End for each 
	Form:C1466.LB_AnswersAll:=$c3
	Form:C1466.LB_AnswersAll:=Form:C1466.LB_AnswersAll
End if 