C_OBJECT:C1216($obRec)
C_TEXT:C284($vtName; $vtTopic)
$vtName:=Request:C163("Enter Letter Name"; "DraftName - "+process_o.tableName)
If ($vtName#"")
	$vtTopic:=Request:C163("Enter Letter Topic"; "DraftTopic")
	If ($vtTopic#"")
		
		$obRec:=ds:C1482.Letter.new()
		$result_o:=$obRec.save()
		$obRec.active:=True:C214
		$obRec.tableNum:=ds:C1482[process_o.tableName].getInfo().tableNumber  //  (process_o.tableName)
		
		$obRec.name:=$vtName
		$obRec.topic:=$vtTopic
		
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "getContent"; tinyMCE_Content_t)
		$obRec.body:=Replace string:C233(tinyMCE_Content_t; "</p>\n<p>"; "</p><p>")
		$result_o:=$obRec.save()
		$cTemp:=Ltr_GetCollection(process_o.tableName)
		Form:C1466.cLetter:=$cTemp
		C_LONGINT:C283($viPosition)
		If (False:C215)
			C_COLLECTION:C1488($cOne)
			$cOne:=New collection:C1472
			$cOne:=$cTemp.find("CU_FindID"; $obRec.id)  //Form.cLetter.find(Form.cLetter.id=$obRec.id)
			Form:C1466.cLetterCurrent:=$cOne
			Form:C1466.cLetterSelection:=Form:C1466.cLetterCurrent
			
			
			$viPosition:=$cTemp.findIndex("CU_FindID"; $obRec.id)
			Form:C1466.cLetterPosition:=$viPosition
		End if 
		If ($viPosition=0)
			$viPosition:=2
		End if 
		LISTBOX SELECT ROW:C912(*; "LBLetter"; $viPosition; lk replace selection:K53:1)
		Ltr_FillTinyMCE(Form:C1466.cLetterCurrent.body)
	End if 
End if 