//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-09-01T05:00:00Z)
// Method: jshowCurSelect
// Description 
// Parameters
// ----------------------------------------------------


<>ptCurTable:=ptCurTable
<>processAlt:=New process:C317("jShowCurSelectProcess"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- Selection")  // +Table name(ptCurTable))