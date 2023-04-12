//%attributes = {"publishedWeb":true}
// Txt_2Array(vText;->aText1;",";True)
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-02T00:00:00, 10:23:21
// ----------------------------------------------------
// Method: TextToArray
// Description
// Modified: 01/02/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// Date: 07/01/02
// Who: Bill
// Description: Block of text to an array
// Paramaters: 
// $1 Text to Parse, 
// $2 pointer to Array; 
// $3 Delimiter default = tab
// $4 boolean parse Empty
// Txt_2Array(vText;->aText1;",";True)

// same as Txt_2Array
//#DECLARE($working_t : Text; $theDelim : Text; $doEmpty : Boolean; $vbUnique; Boolean)


C_TEXT:C284($1; $theText; $3)
C_POINTER:C301($2)
C_BOOLEAN:C305($4; $doEmpty; $vbUnique)
ARRAY TEXT:C222($2->; 0)
$doEmpty:=True:C214
$theDelim:="\t"
If ($1#"")
	If ($1[[1]]=Char:C90(10))
		$theText:=Substring:C12($1; 2)
	Else 
		$theText:=$1
	End if 
	If (Count parameters:C259>2)
		// ### bj ### 20200209_1429
		If ($3="")
			$theDelim:="\r"
		Else 
			$theDelim:=$3
		End if 
		If (Count parameters:C259>3)
			$doEmpty:=$4
			If (Count parameters:C259>4)
				$vbUnique:=$5
			Else 
				$vbUnique:=False:C215
			End if 
		Else 
			$doEmpty:=False:C215
		End if 
	End if 
	
	$lenDelim:=Length:C16($theDelim)
	Repeat 
		$p:=Position:C15($theDelim; $theText)
		$theString:=""
		If ($p>0)
			$theString:=Substring:C12($theText; 1; $p-1)
			$theText:=Substring:C12($theText; $p+$lenDelim)
		Else 
			If (Length:C16($theText)>0)
				$theString:=$theText
				$theText:=""
			End if 
			
		End if 
		If (($theString#"") | ($doEmpty))
			$theString:=TxtStripLineFeed($theString)
			
			If ((Find in array:C230($2->; $theString)=-1) | ($vbUnique=False:C215))  // if unique or unique not required
				APPEND TO ARRAY:C911($2->; $theString)
			End if 
			
		End if 
		// ### jwm ### 20160609_1000
		// if the last character is a delimiter and doEmpty is true
		If (($p>0) & ($theText="") & ($doEmpty))
			APPEND TO ARRAY:C911($2->; "")
		End if 
		
	Until ($theText="")
End if 