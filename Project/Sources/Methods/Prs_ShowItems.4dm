//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 13:04:32
// ----------------------------------------------------
// Method: Prs_ShowItems
// Description
// Action: TestThis
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	CREATE EMPTY SET:C140([Item:4]; "<>curSelSet")
	For ($i; 1; Size of array:C274(<>aTopLevelItem))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=<>aTopLevelItem{$i})
		ADD TO SET:C119([Item:4]; "<>curSelSet")
	End for 
	DB_ShowCurrentSelection(->[Item:4]; ""; 4; "Top Level Items")  //### jwm ### 20120109_1138
End if 