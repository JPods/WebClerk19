C_PICTURE:C286(stPict1)
C_TEXT:C284(stText1)
C_BOOLEAN:C305($vbSaveOK)
$vbSaveOK:=True:C214
If (Form:C1466.cLetterCurrent.securityLevel>0)
	$vbSaveOK:=False:C215
	C_OBJECT:C1216($obCurrentUser)
	If (True:C214)
		$vbSaveOK:=(Form:C1466.cLetterCurrent.securityLevel<=Storage:C1525.user.securityLevel)
	Else 
		$obCurrentUser:=ds:C1482.Employee.query("nameID = :1 "; Current user:C182).first()
		If (Form:C1466.cLetterCurrent.securityLevel<=$obCurrentUser.securityLevel)
			$vbSaveOK:=True:C214
		End if 
	End if 
End if 
If ($vbSaveOK)
	If (bConvert=1)
		CONFIRM:C162("Save while data_tags are converted to values?")
		$vbSaveOK:=(OK=1)
	End if 
End if 
If ($vbSaveOK)
	C_OBJECT:C1216($obLetterRec)
	$obLetterRec:=ds:C1482.Letter.query("id = :1"; Form:C1466.cLetterCurrent.id).first()
	If ($obLetterRec#Null:C1517)
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "getContent"; tinyMCE_Content_t)
		$obLetterRec.body:=Replace string:C233(tinyMCE_Content_t; "</p>\n<p>"; "</p><p>")
		$obLetterRec.save()
		Form:C1466.cLetterCurrent.body:=$obLetterRec.body
	End if 
End if 