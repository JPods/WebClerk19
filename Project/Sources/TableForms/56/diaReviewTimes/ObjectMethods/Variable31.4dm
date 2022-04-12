//SEARCH([Time];[Time]Complete#"tc";*)
//SEARCH([Time];&[Time]Complete="dc")
KeyModifierCurrent
QUERY:C277([QQQTime:56]; [QQQTime:56]LapseTime:8=?00:00:00?)
//If (OptKey=0)
//If (<>aNameID<1)
//C_TEXT($theName)
//$theName:=Current user
//Else 
//$theName:=<>aNameID{<>aNameID}
//End if 
//SEARCH([Time];&[Time]NameIDKey=$theName;*)
//End if 
//SEARCH([Time])
TC_FillArrays(Records in selection:C76([QQQTime:56]))
doSearch:=6