C_LONGINT:C283($i; $k)
READ ONLY:C145([Item:4])
doQuickQuote:=1
// File_dSelection (->[Item])
// ### bj ### 20190113_1904
QueryEditorModal(->[Item:4])

$k:=Records in selection:C76([Item:4])
If ((myOK=1) & ($k>0))
	// ItemCriticalRay (0;$k)
	FC_FillRay(0)
	FIRST RECORD:C50([Item:4])
	For ($i; 1; $k)
		BOM_NeedExpand([Item:4]itemNum:1; 0; !00-00-00!; "Item Record"; ""; "IT"; 0; Record number:C243([Item:4]); ->[Item:4]typeid:26)
		aFCBomCnt{$i}:=[Item:4]qtyOnHand:14
		NEXT RECORD:C51([Item:4])
	End for 
	doSearch:=8
End if 
UNLOAD RECORD:C212([Item:4])
READ WRITE:C146([Item:4])


doQuickQuote:=0