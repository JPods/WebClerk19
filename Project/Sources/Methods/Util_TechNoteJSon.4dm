//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/19/12, 18:44:58
// ----------------------------------------------------
// Method: Method: Util_TechNoteJSon
// Description sending .json files for technote searching
// 
//
// Parameters
// ----------------------------------------------------
CONFIRM:C162("Create JSon for TechNotes.")
If (OK=1)
	myDoc:=Create document:C266("")
	If (OK=1)
		ALL RECORDS:C47([TechNote:58])
		ORDER BY:C49([TechNote:58]; [TechNote:58]chapter:14; [TechNote:58]section:15)
		$cntRec:=Records in selection:C76([TechNote:58])
		FIRST RECORD:C50([TechNote:58])
		C_LONGINT:C283($incKey; $cntKey)
		
		SEND PACKET:C103(myDoc; "{\"pages\": ["+"\r")
		For ($incRec; 1; $cntRec)
			$keytext:=""
			QUERY:C277([Word:99]; [Word:99]tableNum:2=Table:C252(->[TechNote:58]); *)
			QUERY:C277([Word:99];  & [Word:99]idNum:1=[TechNote:58]idNum:1)
			$cntKey:=Records in selection:C76([Word:99])
			FIRST RECORD:C50([Word:99])
			For ($incKey; 1; $cntKey)
				$keytext:=$keytext+[Word:99]wordCombined:5+" "
				NEXT RECORD:C51([Word:99])
			End for 
			vText1:=Replace string:C233([TechNote:58]subject:6; Char:C90(34); "")
			vText1:=Parse_UnWanted(vText1)
			$theText:=Replace string:C233(vText1; "'"; "")
			$theText:=Replace string:C233($theText; ","; "")
			$theText:=Replace string:C233($theText; "\r"; "")
			$theText:=Replace string:C233($theText; "\n"; "")
			$theText:=Replace string:C233($theText; "\t"; " ")
			$theText:=Replace string:C233($theText; "<br>"; " ")
			$theText:=Replace string:C233($theText; "<br />"; " ")
			SEND PACKET:C103(myDoc; "{\"title\": \""+$theText)
			vText1:=Replace string:C233([TechNote:58]summary:3; Char:C90(34); "")
			vText1:=Parse_UnWanted(vText1)
			$theText:=Replace string:C233(vText1; "'"; "")
			$theText:=Replace string:C233($theText; ","; "")
			$theText:=Replace string:C233($theText; "\r"; "")
			$theText:=Replace string:C233($theText; "\n"; "")
			$theText:=Replace string:C233($theText; "\t"; " ")
			$theText:=Replace string:C233($theText; "<br>"; " ")
			$theText:=Replace string:C233($theText; "<br />"; " ")
			SEND PACKET:C103(myDoc; "\", \"text\": \""+$theText+"\", \"tags\": \"")
			
			$theText:="Chap_"+String:C10([TechNote:58]chapter:14; "000")
			SEND PACKET:C103(myDoc; $keytext+"\", \"loc\": \"technotes/"+$theText+"/"+String:C10([TechNote:58]chapter:14)+"_"+String:C10([TechNote:58]section:15)+".html\"}")
			If ($incRec<$cntRec)
				SEND PACKET:C103(myDoc; ","+"\r")
			Else 
				SEND PACKET:C103(myDoc; "\r"+"]}")
			End if 
			NEXT RECORD:C51([TechNote:58])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
		UNLOAD RECORD:C212([TechNote:58])
		ALERT:C41("finished")
	End if 
End if 