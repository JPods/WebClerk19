//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/12/11, 16:04:13
// ----------------------------------------------------
// Method: Wcc_ReduceSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------

//
If (Count parameters:C259=1)
	$doThis:=$1
Else 
	$doThis:=0
End if 
If ($doThis=0)
	SelectionToZero
	KeywordWebRelated(0)
	WC_ServerInit
	vText11:=""
End if 

