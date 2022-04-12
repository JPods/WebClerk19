//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-09-13T00:00:00, 11:03:28
// ----------------------------------------------------
// Method: KeywordClearBad
// Description
// Modified: 09/13/13
// 
// 
//
// Parameters
// ----------------------------------------------------


//If (Count parameters=1)
//$tableNum:=$1
//Else 
//$tableNum:=Table(PTCURTABLE)
//End if 
//$k:=Size of array(aBadWords)
//For ($i; 1; $k)
//QUERY([Word]; [Word]tableNum=$tableNum; *)
//QUERY([Word];  & [Word]wordOnly=aBadWords{$i})
//If (Records in selection([Word])>0)
//DELETE SELECTION([Word])
//End if 
//End for 