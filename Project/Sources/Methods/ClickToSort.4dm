//%attributes = {}

//ClickToSort(l;kasjhd;lfkhjsafd:lkjhasdflkjhsadf)

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/07/18, 11:12:40
// ----------------------------------------------------
// Method: ClickToSort
// Description
// 
//
// Parameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// $1
C_TEXT:C284($vtField; $vtFormula; $vtNumber; $vtSort; $vtText; vtAZ; vtDiamond; vtDirection; vtZA)

//==================================
//  Initialize variables 
//==================================

$vtField:=""
$vtFormula:=""
$vtNumber:=""
$vtSort:=""
$vtText:=""
vtAZ:=""
vtDiamond:=""
vtDirection:=""
vtZA:=""
//</declarations>

//SelectSort ("Field_1";"Text_1")
vtAZ:=Char:C90(0x25B2)  // > ascending a-z
vtZA:=Char:C90(0x25BC)  // < descending z-a
vtDiamond:=Char:C90(0x25C6)

$vtNumber:=String:C10(Num:C11(OBJECT Get name:C1087(Object current:K67:2)))
$vtField:="Field_"+$vtNumber
$vtText:="Text_"+$vtNumber
$vtSort:="Sort_"+$vtNumber

// get current sort direction
vtDirection:=OBJECT Get title:C1068(*; $vtSort)
// reset all sort icons
OBJECT SET TITLE:C194(*; "Sort_@"; vtDiamond)

If ((vtDirection=vtDiamond) | (vtDirection=vtZA))  // Not Sorted or Descending
	OBJECT SET TITLE:C194(*; $vtSort; vtAZ)  // set icon to ascending
	vtDirection:=vtAZ  // set direction to ascending
Else 
	OBJECT SET TITLE:C194(*; $vtSort; vtZA)  // set icon to descending 
	vtDirection:=vtZA  // set direction to descending
End if 

If (Count parameters:C259>=1)
	$vtFormula:=$1
	SelectSort($vtField; $vtText; ""; $vtFormula)  // pass formula as fourth parameter
Else 
	SelectSort($vtField; $vtText)
End if 

