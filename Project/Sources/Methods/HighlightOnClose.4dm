//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/16/20, 23:51:22
// ----------------------------------------------------
// Method: HighlightOnClose
// Description
// 
//
// Parameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

C_POINTER:C301($vptable)

//==================================
//  Initialize variables 
//==================================

//</declarations>

$vpTable:=Current form table:C627  // get pointer to table of current form
CREATE EMPTY SET:C140($vpTable->; "Highlight")  //create set for current record
ADD TO SET:C119($vptable->; "Highlight")  // add curent record to set to be highlighted
HIGHLIGHT RECORDS:C656($vptable->; "Highlight")  // highlight current record
CLEAR SET:C117("Highlight")  // release memory
