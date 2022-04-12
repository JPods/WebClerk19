//%attributes = {"publishedWeb":true}
If (False:C215)
	// Method:      Txt_StripTabs
	// Written by: Noah Swiler
	// Date:          6/23/99
	// Type:          Function
	// Purpose:     Strip Tabs from passed text-
	//                    Especially useful for imports from Text files
	// Called by:   
	// 
	// Parameters
	// $1: Text to Format - (Text)
	// Example:      $TableName:=UTI_StripUnderscores(Tablename)
End if 

C_TEXT:C284($1; $0; $tTextIn; $tTextOut)

$tTextIn:=$1

$tTextOut:=Replace string:C233($tTextIn; Char:C90(Tab:K15:37); "")  // remove tabs

$0:=$tTextOut