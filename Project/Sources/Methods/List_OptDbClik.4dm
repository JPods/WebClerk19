//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/09/08, 13:45:38
// ----------------------------------------------------
// Method: List_OptDbClik
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)

C_TEXT:C284($textQuery)
$textQuery:="QUERY([Item];[Item]ItemNum="+Txt_Quoted($1->)+")"
DB_ShowCurrentSelection(->[Item:4]; $textQuery; 1; "")
// Modified by: williamjames (101021)
