//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/21/20, 00:17:49
// ----------------------------------------------------
// Method: ItemKeywordSearch
// Description
// 
//
// Parameters
// ----------------------------------------------------



srItemKeyWords:=Request:C163("Search Items for Keyword:")
If ((OK=1) & (srItemKeyWords#""))
	TRACE:C157
	KeyWordByAlpha(Table:C252(->[Item:4]); srItemKeyWords; True:C214)
	ProcessTableOpen(->[Item:4])
End if 



//KeyModifierCurrent 
//$wildCard:="@"*Num(CmdKey=0)//wild search if 
//
//srItemKeyWord:=Request("Search Items for Keyword:")
//If (OK=1)
//If (ShftKey=0)
//QUERY([Item];[Item]Retired=False;*)
//QUERY([Item];&[Item]KeyWords'Keyword=srItemKeyWord+$wildCard)
//Else 
//QUERY([Item];[Item]KeyWords'Keyword=srItemKeyWord+$wildCard)
//End if 
//If (Records in selection([Item])=0)
//ALERT("No Items matched Keyword.")
//End if 
//ProcessTableOpen (->[Item])
//End if 