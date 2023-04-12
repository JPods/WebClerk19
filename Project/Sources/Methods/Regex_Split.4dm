//%attributes = {}

// Modified by: Bill James (2022-12-09T06:00:00Z)
// Method: Regex_Split
// Description 
// Parameters
// ----------------------------------------------------

// QQQ Learn to use this
//<code 4D>
//_Split_string(stringToSplit_t;separator_t{;option_l})→collection
//option_l to 4 is split on regex. other options execute the split string command.
C_TEXT:C284($1; $2; $word_t; $separator_t)
C_LONGINT:C283($3; $option_l)

$word_t:=$1
$separator_t:=$2
$option_l:=Choose:C955(Count parameters:C259=3; $3; 0)

If ($option_l=4)  //split on regex
	C_COLLECTION:C1488($word_c)
	C_LONGINT:C283($start_l; $cnt_l; $pos_l; $length_l)
	C_BOOLEAN:C305($match_b)
	$start_l:=1
	$cnt_l:=0
	$word_c:=New collection:C1472
	Repeat 
		$match_b:=Match regex:C1019($separator_t; $word_t; $start_l; $pos_l; $length_l)
		If ($match_b)
			$word_c[$cnt_l]:=Substring:C12($word_t; $pos_l; $length_l)
			$cnt_l:=$cnt_l+1
			$start_l:=$pos_l+$length_l
		End if 
	Until ($match_b=False:C215)
	$0:=$word_c
	
Else   //other
	$0:=Split string:C1554($word_t; $separator_t; $option_l)
End if 
