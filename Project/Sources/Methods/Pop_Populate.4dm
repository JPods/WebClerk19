//%attributes = {"publishedWeb":true}
//Procedure: Pop_Populate
//Monday, November 9, 1998
C_LONGINT:C283($i; $k)
CONFIRM:C162("Populate Popups from current data?")
If (OK=1)
	CONFIRM:C162("NO UNDO, Replaces current popup values?")
	If (OK=1)
		vText1:=""
		ALL RECORDS:C47([PopUp:23])
		FIRST RECORD:C50([PopUp:23])
		$k:=Records in selection:C76([PopUp:23])
		For ($i; 1; $k)
			Txt_PopDistinct(0)  //build the values for all records
			Pop_Paste(5)  //skip pasting, no warning
			SAVE RECORD:C53([PopUp:23])
			NEXT RECORD:C51([PopUp:23])
		End for 
	End if 
End if 